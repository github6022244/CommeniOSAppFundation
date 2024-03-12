//
//  YYKitFix.h
//  ChangXiangGrain
//
//  Created by GG on 2023/11/2.
//  Copyright © 2023 ChangXiangCloud. All rights reserved.
//

/*
 问题:
 1.由于YYkit长时间不更新，老方法过期，导致闪退
 
 YYAsyncLayer.m 中 - (void)_displayAsync:(BOOL)async {}
 使用了 UIGraphicsBeginImageContextWithOptions(<#CGSize size#>, <#BOOL opaque#>, <#CGFloat scale#>)
 ①这个方法已经在 iOS4.0 废弃
 ②xCode15、iOS17 系统在这个函数加了断言，如果传入的size width 或者 height 其中一个为0，会直接 return 返回断言，之前会渲染出一张 0 size 的图片
 
 
 
 Fix:
 1.手动导入 YYKit
 2.在问题方法中提前判断 size 是否 width、height 不为 0，为 0 则不执行后续代码。时间有限，非常简单的处理
 以后可以替换为 UIGraphicsImageRenderer
 */
