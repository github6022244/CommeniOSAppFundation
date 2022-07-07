//
//  UIImageView+GGWeb.h
//  GGCommenAppFundation
//
//  Created by GG on 2022/6/13.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GGWeb)

- (void)gg_setImageWithURL:(NSString *)urlStr placeholderImage:(id _Nullable)placeholder;

- (void)gg_setImageWithURL:(NSString *)urlStr placeholderImage:(id _Nullable)placeholder cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
