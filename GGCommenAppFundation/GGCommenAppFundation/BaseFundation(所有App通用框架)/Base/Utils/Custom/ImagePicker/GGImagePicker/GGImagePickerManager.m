//
//  GGImagePickerManager.m
//  RKMedicineReach
//
//  Created by 潘儒贞 on 2020/9/25.
//  Copyright © 2020 ruikang. All rights reserved.
//

#import "GGImagePickerManager.h"
#import "QDMultipleImagePickerPreviewViewController.h"
#import "QDSingleImagePickerPreviewViewController.h"
#import "GGAppManager.h"
#import "UIWindow+GG.h"
#import "UIViewController+GG.h"

#define MaxSelectedImageCount 9
//#define NormalImagePickingTag 1045
//#define ModifiedImagePickingTag 1046
#define MultipleImagePickingTag 1047
#define SingleImagePickingTag 1048

@interface GGImagePickerManager ()<QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate,QDMultipleImagePickerPreviewViewControllerDelegate,QDSingleImagePickerPreviewViewControllerDelegate>

@property (nonatomic, strong) QMUIAlbumViewController *albumViewController;

@property (nonatomic, copy) GGImagePickerManagerDownBlock block;

@end

@implementation GGImagePickerManager

- (instancetype)init {
    if (self = [super init]) {
//        _albumViewController = [[QMUIAlbumViewController alloc] init];
//        _albumViewController.albumViewControllerDelegate = self;
//        _albumViewController.contentType = QMUIAlbumContentTypeOnlyPhoto;
    }
    return self;
}

#pragma mark ------------------------- Interface -------------------------
- (void)showalbumViewConrtollerWithBlock:(GGImagePickerManagerDownBlock)block {
    _block = block;
    
    _albumViewController = [[QMUIAlbumViewController alloc] init];
    _albumViewController.albumViewControllerDelegate = self;
    _albumViewController.contentType = QMUIAlbumContentTypeOnlyPhoto;
    
    if (!_isMutiSelect) {
        _albumViewController.view.tag = SingleImagePickingTag;
    } else {
        _albumViewController.view.tag = MultipleImagePickingTag;
    }
    
    QMUINavigationController *navigationController = [[QMUINavigationController alloc] initWithRootViewController:_albumViewController];
    
    // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
    [_albumViewController pickLastAlbumGroupDirectlyIfCan];
    
    UIViewController *topVC = [QMUIHelper visibleViewController];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [topVC presentViewController:navigationController animated:YES completion:nil];
        [topVC fullScreenPresentViewController:navigationController animated:YES completion:nil];
    });
}

#pragma mark ------------------------- Delegate -------------------------
#pragma mark - <QMUIAlbumViewControllerDelegate>
- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *imagePickerViewController = [[QMUIImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.maximumSelectImageCount = MaxSelectedImageCount;
    imagePickerViewController.view.tag = albumViewController.view.tag;
    if (albumViewController.view.tag == SingleImagePickingTag) {
        imagePickerViewController.allowsMultipleSelection = NO;
    }
//    if (albumViewController.view.tag == ModifiedImagePickingTag) {
//        imagePickerViewController.minimumImageWidth = 65;
//    }
    return imagePickerViewController;
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>

- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerViewController.assetsGroup ablumContentType:_albumViewController.contentType userIdentify:nil];
    
    if (self.block) {
        self.block(imagesAssetArray);
    }
}

- (QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController {
    if (imagePickerViewController.view.tag == MultipleImagePickingTag) {
        QDMultipleImagePickerPreviewViewController *imagePickerPreviewViewController = [[QDMultipleImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.maximumSelectImageCount = MaxSelectedImageCount;
        imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    } else if (imagePickerViewController.view.tag == SingleImagePickingTag) {
        QDSingleImagePickerPreviewViewController *imagePickerPreviewViewController = [[QDSingleImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    }
    
    return nil;
//    else if (imagePickerViewController.view.tag == ModifiedImagePickingTag) {
//        QMUIImagePickerPreviewViewController *imagePickerPreviewViewController = [[QMUIImagePickerPreviewViewController alloc] init];
//        imagePickerPreviewViewController.delegate = self;
//        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
//        imagePickerPreviewViewController.toolBarBackgroundColor = UIColorMake(66, 66, 66);
//        return imagePickerPreviewViewController;
//    } else {
//        QMUIImagePickerPreviewViewController *imagePickerPreviewViewController = [[QMUIImagePickerPreviewViewController alloc] init];
//        imagePickerPreviewViewController.delegate = self;
//        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
//        return imagePickerPreviewViewController;
//    }
}

#pragma mark - <QMUIImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didUncheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

// 更新选中的图片数量
- (void)updateImageCountLabelForPreviewView:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController {
    if (imagePickerPreviewViewController.view.tag == MultipleImagePickingTag) {
        QDMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (QDMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
        NSUInteger selectedCount = [imagePickerPreviewViewController.selectedImageAssetArray count];
        if (selectedCount > 0) {
            customImagePickerPreviewViewController.imageCountLabel.text = [[NSString alloc] initWithFormat:@"%@", @(selectedCount)];
            customImagePickerPreviewViewController.imageCountLabel.hidden = NO;
            [QMUIImagePickerHelper springAnimationOfImageSelectedCountChangeWithCountLabel:customImagePickerPreviewViewController.imageCountLabel];
        } else {
            customImagePickerPreviewViewController.imageCountLabel.hidden = YES;
        }
    }
}

#pragma mark - <QDSingleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QDSingleImagePickerPreviewViewController *)imagePickerPreviewViewController didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup ablumContentType:_albumViewController.contentType userIdentify:nil];
    // 显示 loading
//    [self startLoading];
    [imageAsset requestImageData:^(NSData *imageData, NSDictionary<NSString *,id> *info, BOOL isGif, BOOL isHEIC) {
        UIImage *targetImage = nil;
        if (isGif) {
            targetImage = [UIImage qmui_animatedImageWithData:imageData];
        } else {
            targetImage = [UIImage imageWithData:imageData];
            if (isHEIC) {
                // iOS 11 中新增 HEIF/HEVC 格式的资源，直接发送新格式的照片到不支持新格式的设备，照片可能会无法识别，可以先转换为通用的 JPEG 格式再进行使用。
                // 详细请浏览：https://github.com/Tencent/QMUI_iOS/issues/224
                targetImage = [UIImage imageWithData:UIImageJPEGRepresentation(targetImage, 1)];
            }
        }
        if (self.block) {
            self.block(@[targetImage ? : [UIImage new]]);
        }
    }];
}

#pragma mark - <QDMultipleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QDMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup ablumContentType:_albumViewController.contentType userIdentify:nil];
    
     [self sendImageWithImagesAssetArray:imagesAssetArray];
}

#pragma mark - 业务方法

- (void)startLoading {
    [QMUITips showLoadingInView:[UIWindow getKeyWindow]];
}

- (void)startLoadingWithText:(NSString *)text {
    [QMUITips showLoading:text inView:[UIWindow getKeyWindow]];
}

- (void)stopLoading {
    [QMUITips hideAllToastInView:[UIWindow getKeyWindow] animated:YES];
}

- (void)showTipLabelWithText:(NSString *)text {
    [self stopLoading];
    [QMUITips showWithText:text inView:[UIWindow getKeyWindow] hideAfterDelay:1.0];
}

- (void)hideTipLabel {
    [QMUITips hideAllToastInView:[UIWindow getKeyWindow] animated:YES];
}

- (void)sendImageWithImagesAssetArrayIfDownloadStatusSucceed:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    if ([QMUIImagePickerHelper imageAssetsDownloaded:imagesAssetArray]) {
        // 所有资源从 iCloud 下载成功，模拟发送图片到服务器
        // 显示发送中
//        [self showTipLabelWithText:@"发送中"];
        // 使用 delay 模拟网络请求时长
//        [self performSelector:@selector(showTipLabelWithText:) withObject:[NSString stringWithFormat:@"成功发送%@个资源", @([imagesAssetArray count])] afterDelay:1.5];
        NSMutableArray *marr = [NSMutableArray array];
        for (QMUIAsset *asset in imagesAssetArray) {
            [marr addObject:asset.originImage ? : [UIImage new]];
        }
        if (self.block) {
            self.block(marr);
        }
    }
}

- (void)sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    __weak __typeof(self)weakSelf = self;
    
    for (QMUIAsset *asset in imagesAssetArray) {
        [QMUIImagePickerHelper requestImageAssetIfNeeded:asset completion:^(QMUIAssetDownloadStatus downloadStatus, NSError *error) {
            if (downloadStatus == QMUIAssetDownloadStatusDownloading) {
                [weakSelf startLoadingWithText:@"从 iCloud 加载中"];
            } else if (downloadStatus == QMUIAssetDownloadStatusSucceed) {
                [weakSelf sendImageWithImagesAssetArrayIfDownloadStatusSucceed:imagesAssetArray];
            } else {
                [weakSelf showTipLabelWithText:@"iCloud 下载错误，请重新选图"];
            }
        }];
    }
}

#pragma mark ------------------------- set / get -------------------------
- (QMUIAlbumViewController *)albumViewController {
    if (!_albumViewController) {
        _albumViewController = [[QMUIAlbumViewController alloc] init];
        _albumViewController.albumViewControllerDelegate = self;
    }
    return _albumViewController;
}

@end
