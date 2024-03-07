#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YQOPERATORS){
    YQ_Add,//加
    YQ_Mul,//乘
    YQ_Sub,//减
    YQ_Div//除
};
@interface NSNumber (YQ)

//无格式,四舍五入
- (NSString *)changeToumberFormatterNoStyle;
//小数型,
- (NSString *)changeToNumberFormatterDecimalStyle;
//货币型,
- (NSString *)changeToNumberFormatterCurrencyStyle;
//百分比型
- (NSString *)changeToNumberFormatterPercentStyle;
//科学计数型,
- (NSString *)changeToNumberFormatterScientificStyle;
//全拼
- (NSString *)changeToNumberFormatterSpellOutStyle;


/// 运算方法
/// @param one 第一个数
/// @param opera 运算方式
/// @param two 第二个数
+ (NSNumber *)getResult:(NSNumber *)one  operators:(YQOPERATORS)opera num:(NSNumber *)two;

@end

NS_ASSUME_NONNULL_END
