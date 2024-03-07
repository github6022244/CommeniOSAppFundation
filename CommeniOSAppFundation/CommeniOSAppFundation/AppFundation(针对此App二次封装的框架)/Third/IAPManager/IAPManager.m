//
//  IAPManager.m
//  CXGrainStudentApp
//
//  Created by User on 2020/8/27.
//  Copyright © 2022 ChangXiangGu. All rights reserved.
//

#import "IAPManager.h"
//#import "CXGRechargeNetwork.h"
//#import "CXGRechargeCoinListModel.h"

@interface IAPManager () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (nonatomic, strong) NSMutableArray *rechargeCoinArr;
@property (nonatomic, strong) NSMutableArray *productIDArr;

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) RechargeReceiptResultBlock receiptBlock;

@property (nonatomic, strong) QMUITips *tips;

@end

@implementation IAPManager

static IAPManager *instance = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[super allocWithZone:nil] init];
        }
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [IAPManager sharedManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [IAPManager sharedManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [IAPManager sharedManager];
}

// 没用到这个方法
//- (void)requestRechargeCoinList {
//    @ggweakify(self);
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"type"] = @(2);
//
//    [CXGRechargeNetwork getRechargeCoinListWithParam:param success:^(ResponseStatus responseStatus, NSInteger code, NSString * _Nonnull message, id  _Nonnull responseObject) {
//        @ggstrongify(self);
//        if (responseStatus == Successed) {
//            self.rechargeCoinArr = [[CXGRechargeCoinListModel mj_objectArrayWithKeyValuesArray:responseObject] mutableCopy];
//
//        }
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
//
//    [[XYStore defaultStore] requestProducts:[NSSet setWithArray:self.productIDArr] success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
//        QMUILog(nil, @"%@--%@", products, invalidProductIdentifiers);
//    } failure:^(NSError *error) {
//        QMUILog(nil, @"%@", error);
//    }];
//}


#pragma mark -- 暂且使用下方的代码
- (void)requestProductInfoWithProductId:(NSString *)productId receiptBlock:(RechargeReceiptResultBlock)receiptBlock {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    NSArray* transactions = [SKPaymentQueue defaultQueue].transactions;
    if (transactions.count > 0)
    {
        //检测是否有未完成的交易
        SKPaymentTransaction *transaction = [transactions firstObject];
        if (transaction.transactionState == SKPaymentTransactionStatePurchased)
        {
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            return;
        }
    }
    
    self.productId = productId;
    self.receiptBlock = receiptBlock;
    [self startIAP];
}

- (void)startIAP
{
    //如果app允许applepay
    if ([SKPaymentQueue canMakePayments]) {
        QMUILog(nil, @"yes");
        
        // 6.请求苹果后台商品
        [self getRequestAppleProduct];
    }
    else
    {
        QMUILog(nil, @"not");
        [self _showAlertWithTitle:NSLocalizedString(@"IAP_Alert_Title", @"提示") message:NSLocalizedString(@"IAP_Alert_Message_DeviceCanNotMakePayments", @"设备不支持内购") cancelButtonTitle:NSLocalizedString(@"IAP_Alert_Cancel", @"取消")];
    }
}

//请求苹果商品
- (void)getRequestAppleProduct
{
    [self _showLoadingInMainQueue:NSLocalizedString(@"IAP_Toast_RequestProductInfo", @"向AppStore请求商品信息")];
    
//    // 因为 app 从山东账号改为北京账号，后台商品id 还没改，所以手动改成背景账号的商品id
//    if ([self.productId containsString:@"Shandong"]) {
//        self.productId = [self.productId stringByReplacingOccurrencesOfString:@"Shandong" withString:@"Beijing"];
//    }
    
    // 7.这里的 com.aaa.bbb 就对应着苹果后台的商品ID,他们是通过这个ID进行联系的。
    NSArray *product = [[NSArray alloc] initWithObjects:self.productId, nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    
    // 8.初始化请求
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    
    // 9.开始请求
    [request start];
}

// 10.接收到产品的返回信息,然后用返回的商品信息进行发起购买请求
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    [ProgressHUD dismiss];
    
    NSArray *product = response.products;
    
    //如果服务器没有产品
    if ([product count] == 0){
        QMUILog(nil, @"nothing");
        [self _showAlertWithTitle:NSLocalizedString(@"IAP_Alert_Title", @"提示") message:NSLocalizedString(@"IAP_Alert_Message_NoProducts", @"应用商店没有商品") cancelButtonTitle:NSLocalizedString(@"IAP_Alert_Cancel", @"取消")];
        return;
    }
    
    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {
        
        QMUILog(nil, @"%@", [pro description]);
        QMUILog(nil, @"%@", [pro localizedTitle]);
        QMUILog(nil, @"%@", [pro localizedDescription]);
        QMUILog(nil, @"%@", [pro price]);
        QMUILog(nil, @"%@", [pro productIdentifier]);
        
        // 11.如果后台消费条目的ID与我这里需要请求的一样（用于确保订单的正确性）
        if ([pro.productIdentifier isEqualToString:self.productId])
        {
            requestProduct = pro;
        }
    }
    
    if (!requestProduct) {
        [self _showAlertWithTitle:NSLocalizedString(@"IAP_Alert_Title", @"提示") message:NSLocalizedString(@"IAP_Alert_Message_NilProductInfomation", @"商品信息为空") cancelButtonTitle:NSLocalizedString(@"IAP_Alert_Cancel", @"取消")];
        return;
    }
    
    // 12.发送购买请求
    [self sendAppStorePayWithProduct:requestProduct];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    QMUILog(nil, @"error:%@", error);
    [ProgressHUD dismiss];
    [ProgressHUD showMessage:NSLocalizedString(@"IAP_Toast_RequestProductInfoError", @"请求商品信息失败")];
}

//反馈请求的产品信息结束后
- (void)requestDidFinish:(SKRequest *)request{
    QMUILog(nil, @"向AppStore请求商品信息结束");
}

// 发起购买请求
- (void)sendAppStorePayWithProduct:(SKProduct *)requestProduct {
    [self _showLoadingInMainQueue:NSLocalizedString(@"IAP_Toast_CallInAppPurchases", @"调起应用商店支付")];
    
    SKPayment *payment = [SKPayment paymentWithProduct:requestProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

// 13.监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction
{
    for(SKPaymentTransaction *tran in transaction)
    {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased: {
                QMUILog(nil, @"交易完成");
                [ProgressHUD dismiss];
                [self completeTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing: {
                QMUILog(nil, @"商品添加进列表");
                [ProgressHUD dismiss];
                [self _showLoadingInMainQueue:NSLocalizedString(@"IAP_Toast_UnderPurchase", @"支付中")];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                QMUILog(nil, @"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [ProgressHUD dismiss];
            }
                break;
            case SKPaymentTransactionStateFailed: {
                QMUILog(nil, @"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [ProgressHUD dismiss];
            }
                break;
            default:
                break;
        }
    }
}

// 14.交易结束,当交易结束后还要去appstore上验证支付信息是否都正确,只有所有都正确后,我们就可以给用户方法我们的虚拟物品了。
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSString *str = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    
    NSString *environment = [self environmentForReceipt:str];
    
    QMUILog(nil, @"----- 完成交易调用的方法completeTransaction 1--------%@",environment);
    BOOL isSandbox = NO;
    if ([environment isEqualToString:@"environment=Sandbox"])
    {
        isSandbox = YES;
    }
    
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:0];
    
    NSDictionary *param = @{@"product_id" : self.productId, @"transaction_id" : transaction.transactionIdentifier, @"isSandbox" : [NSNumber numberWithBool:isSandbox], @"receipt" : encodeStr };
    
    if (self.receiptBlock) {
        self.receiptBlock(param);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (NSString *)environmentForReceipt:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    NSArray *arr = [str componentsSeparatedByString:@";"];
    
    //存储收据环境的变量
    NSString *environment = arr[2];
    return environment;
}



#pragma mark -- Private
- (void)_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:cancleAction];
        [[QMUIHelper visibleViewController] fullScreenPresentViewController:alert animated:YES completion:nil];
        
    });
}

- (void)_showLoadingInMainQueue:(NSString *)text {
    if (self.tips) {
        [ProgressHUD dismissTips:self.tips];
    }
    
    if (text.length) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tips = [ProgressHUD showLoading:text];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tips = [ProgressHUD showLoading];
        });
    }
}


#pragma mark -- lazy
- (NSMutableArray *)rechargeCoinArr {
    if (!_rechargeCoinArr) {
        _rechargeCoinArr = [NSMutableArray array];
    }
    return _rechargeCoinArr;
}

- (NSMutableArray *)productIDArr {
    if (!_productIDArr) {
        // 山东账号id
        _productIDArr = [NSMutableArray arrayWithArray:@[
            @"com.changxianggu.studentProjectSeparateShandong00001",
            @"com.changxianggu.studentProjectSeparateShandong00003",
            @"com.changxianggu.studentProjectSeparateShandong00006",
            @"com.changxianggu.studentProjectSeparateShandong00012",
            @"com.changxianggu.studentProjectSeparateShandong00030",
            @"com.changxianggu.studentProjectSeparateShandong00050",
            @"com.changxianggu.studentProjectSeparateShandong00068",
            @"com.changxianggu.studentProjectSeparateShandong00088",
            @"com.changxianggu.studentProjectSeparateShandong00108",
        ]];
        // 北京账号id
//        _productIDArr = [NSMutableArray arrayWithArray:@[
//            @"com.changxianggu.studentProjectSeparateBeijing00001",
//            @"com.changxianggu.studentProjectSeparateBeijing00003",
//            @"com.changxianggu.studentProjectSeparateBeijing00006",
//            @"com.changxianggu.studentProjectSeparateBeijing00012",
//            @"com.changxianggu.studentProjectSeparateBeijing00030",
//            @"com.changxianggu.studentProjectSeparateBeijing00050",
//            @"com.changxianggu.studentProjectSeparateBeijing00068",
//            @"com.changxianggu.studentProjectSeparateBeijing00088",
//            @"com.changxianggu.studentProjectSeparateBeijing00108",
//        ]];
    }
    return _productIDArr;
}

@end
