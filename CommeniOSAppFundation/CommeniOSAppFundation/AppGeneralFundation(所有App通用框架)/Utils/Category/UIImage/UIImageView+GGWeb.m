//
//  UIImageView+GGWeb.m
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/13.
//

#import "UIImageView+GGWeb.h"
#import <UIImage+QMUI.h>
#import "GGCommenDefine.h"

@implementation UIImageView (GGWeb)

- (void)gg_setImageWithURL:(NSString *)urlStr placeholderImage:(id)placeholder {
    [self gg_setImageWithURL:urlStr placeholderImage:placeholder cornerRadius:0.f];
}

- (void)gg_setImageWithURL:(NSString *)urlStr placeholderImage:(id)placeholder cornerRadius:(CGFloat)cornerRadius {
    @ggweakify(self)
    UIImage *placeImage = nil;
    if ([placeholder isKindOfClass:[UIImage class]]) {
        placeImage = placeholder;
    } else if ([placeholder isKindOfClass:[NSString class]]) {
        placeImage = UIImageMake(placeholder);
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @ggstrongify(self)
        if (!error && cornerRadius) {
            image = [image qmui_imageWithClippedCornerRadius:cornerRadius];
            
            self.image = image;
        }
    }];
}

@end
