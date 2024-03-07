//
//  WCLPictureViewController.m
//  WCLPictureClippingRotation
//
//  Created by wcl on 2016/12/28.
//  Copyright © 2016年 QianTangTechnology. All rights reserved.
//

#import "WCLPictureViewController.h"
#import "UIImage+FitInSize.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface WCLPictureViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImage *inputImage; //输入Image
@property (nonatomic,strong) UIImageView *imgView; //显示图片
@property (nonatomic,assign) CGRect cropRect; //裁剪的rect
@property (nonatomic,retain) UIView *cropperView; //裁剪边框
@property (nonatomic,assign) double imageScale; //裁剪与实际图片比例
@property (nonatomic, retain) UIView *overlayView; //覆盖的黑色透明遮罩
@property (nonatomic,assign) double translateX;
@property (nonatomic,assign) double translateY;

@end

@implementation WCLPictureViewController

- (id)initWithImage:(UIImage *)originalImage cropFrame:(CGRect)cropFrame{
    self = [super init];
    if (self) {
        _translateX =0;
        _translateY =0;
        self.cropRect = cropFrame;
        self.inputImage = originalImage;
        _imageScale = cropFrame.size.width/self.inputImage.size.width;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initView];
    [self initControlBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)initView{
    
    CGFloat oriWidth = self.cropRect.size.width;
    CGFloat oriHeight = self.inputImage.size.height * (oriWidth / self.inputImage.size.width);
    CGFloat oriX = self.cropRect.origin.x + (self.cropRect.size.width - oriWidth) / 2;
    CGFloat oriY = self.cropRect.origin.y + (self.cropRect.size.height - oriHeight) / 2;
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(oriX, oriY, oriWidth, oriHeight)];
    self.imgView.backgroundColor = [UIColor whiteColor];
    self.imgView.image = self.inputImage;
    [self.view addSubview:self.imgView];
    
    self.cropperView = [[UIView alloc] initWithFrame:self.cropRect];
    self.cropperView.backgroundColor = [UIColor clearColor];
    self.cropperView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.cropperView.layer.borderWidth = 1.5;
    [self.view addSubview:self.cropperView];
    
    self.overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.overlayView.alpha = 0.5f;
    self.overlayView.backgroundColor = [UIColor blackColor];
    self.overlayView.userInteractionEnabled = NO;
    self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.overlayView];
    [self overlayClipping];
    
    [self setupGestureRecognizer];
    
}

- (void)initControlBtn {
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50.0f, 100, 50)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.titleLabel.textColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [cancelBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [cancelBtn.titleLabel setNumberOfLines:0];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100.0f, self.view.frame.size.height - 50.0f, 100, 50)];
    confirmBtn.backgroundColor = [UIColor clearColor];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [confirmBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    [confirmBtn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [confirmBtn.titleLabel setNumberOfLines:0];
    [confirmBtn setTitleEdgeInsets:UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f)];
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    //旋转按钮
    if (_enableRotation) {
        UIImage *image = [UIImage imageNamed:@"rotate"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
        button.frame = CGRectMake(button.frame.origin.x, [[UIScreen mainScreen] bounds].size.height - 64 - button.frame.size.height - 28,50, 50);//button的frame
        button.center = CGPointMake(self.view.center.x, confirmBtn.center.y-60);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:image forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.imageEdgeInsets = UIEdgeInsetsMake(0,13,0,0);
        [button setTitle:@"旋转" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(30, -20, 0, 0);
        [button addTarget:self action:@selector(rotateCropViewClockwise:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

#pragma mark - Action
//取消
- (void)cancelAction:(id)sender {
    self.imgView.transform = CGAffineTransformIdentity;
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(WCLCutPictureDelegate)]) {
        [self.delegate imageCropperDidCancel:self];
    }
    
}

//完成裁剪
- (void)confirmAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(WCLCutPictureDelegate)]) {
        [self.delegate imageCropper:self didFinished:[self getCroppedImage]];
    }
    
}

//旋转
- (void)rotateCropViewClockwise:(id)senders {
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.imgView.transform = CGAffineTransformRotate(self.imgView.transform,-M_PI/2);
        
        if(self.imgView.frame.size.width < _cropperView.frame.size.width || self.imgView.frame.size.height < _cropperView.frame.size.height)
        {
            double scale = MAX(_cropperView.frame.size.width/self.imgView.frame.size.width,_cropperView.frame.size.height/self.imgView.frame.size.height) + 0.01;
            
            self.imgView.transform = CGAffineTransformScale(self.imgView.transform,scale, scale);
            
        }
    }];
    
}

- (void) setupGestureRecognizer
{
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomAction:)];
    [pinchGestureRecognizer setDelegate:self];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [panGestureRecognizer setMinimumNumberOfTouches:1];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [panGestureRecognizer setDelegate:self];
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleTapAction:)];
    [doubleTapGestureRecognizer setDelegate:self];
    doubleTapGestureRecognizer.numberOfTapsRequired =2;
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(RotationAction:)];
    [rotationGestureRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    [self.view addGestureRecognizer:panGestureRecognizer];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //默认为NO,这里设置为YES
    return YES;
}


- (void)zoomAction:(UIGestureRecognizer *)sender {
    
    CGFloat factor = [(UIPinchGestureRecognizer *)sender scale];
    static CGFloat lastScale=1;
    
    if([sender state] == UIGestureRecognizerStateBegan) {
        lastScale =1;
    }
    
    if ([sender state] == UIGestureRecognizerStateChanged
        || [sender state] == UIGestureRecognizerStateEnded) {
        CGRect imgViewFrame = _imgView.frame;
        CGFloat minX,minY,maxX,maxY,imgViewMaxX,imgViewMaxY;
        minX= CGRectGetMinX(_cropRect);
        minY= CGRectGetMinY(_cropRect);
        maxX= CGRectGetMaxX(_cropRect);
        maxY= CGRectGetMaxY(_cropRect);
        
        CGFloat currentScale = [[self.imgView.layer valueForKeyPath:@"transform.scale.x"] floatValue];
        const CGFloat kMaxScale = 3.0;
        CGFloat newScale = 1 -  (lastScale - factor);
        newScale = MIN(newScale, kMaxScale / currentScale);
        
        imgViewFrame.size.width = imgViewFrame.size.width * newScale;
        imgViewFrame.size.height = imgViewFrame.size.height * newScale;
        imgViewFrame.origin.x = self.imgView.center.x - imgViewFrame.size.width/2;
        imgViewFrame.origin.y = self.imgView.center.y - imgViewFrame.size.height/2;
        
        imgViewMaxX= CGRectGetMaxX(imgViewFrame);
        imgViewMaxY= CGRectGetMaxY(imgViewFrame);
        
        NSInteger collideState = 0;
        
        if(imgViewFrame.origin.x >= minX)
        {
            collideState = 1;
        }
        else if(imgViewFrame.origin.y >= minY)
        {
            collideState = 2;
        }
        else if(imgViewMaxX <= maxX)
        {
            collideState = 3;
        }
        else if(imgViewMaxY <= maxY)
        {
            collideState = 4;
        }
        
        if(collideState >0)
        {
            
            if(lastScale - factor <= 0)
            {
                lastScale = factor;
                CGAffineTransform transformN = CGAffineTransformScale(self.imgView.transform, newScale, newScale);
                self.imgView.transform = transformN;
            }
            else
            {
                lastScale = factor;
                
                CGPoint newcenter = _imgView.center;
                
                if(collideState ==1 || collideState ==3)
                {
                    newcenter.x = _cropperView.center.x;
                }
                else if(collideState ==2 || collideState ==4)
                {
                    newcenter.y = _cropperView.center.y;
                }
                
                [UIView animateWithDuration:0.5f animations:^(void) {
                    
                    self.imgView.center = newcenter;
                    [sender reset];
                    
                } ];
                
            }
            
        }
        else
        {
            CGAffineTransform transformN = CGAffineTransformScale(self.imgView.transform, newScale, newScale);
            self.imgView.transform = transformN;
            lastScale = factor;
        }
        
    }
    
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    
    static CGPoint prevLoc;
    CGPoint location = [gesture locationInView:self.view];
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        prevLoc = location;
    }
    
    if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded))
    {
        
        CGFloat minX,minY,maxX,maxY,imgViewMaxX,imgViewMaxY;
        
        _translateX =  (location.x - prevLoc.x);
        _translateY =  (location.y - prevLoc.y);
        
        CGPoint center = self.imgView.center;
        minX= CGRectGetMinX(_cropRect);
        minY= CGRectGetMinY(_cropRect);
        maxX= CGRectGetMaxX(_cropRect);
        maxY= CGRectGetMaxY(_cropRect);
        
        center.x =center.x +_translateX;
        center.y = center.y +_translateY;
        
        imgViewMaxX= center.x + _imgView.frame.size.width/2;
        imgViewMaxY= center.y+ _imgView.frame.size.height/2;
        
        if(  (center.x - (_imgView.frame.size.width/2) ) >= minX)
        {
            center.x = minX + (_imgView.frame.size.width/2) ;
        }
        if( center.y - (_imgView.frame.size.height/2) >= minY)
        {
            center.y = minY + (_imgView.frame.size.height/2) ;
        }
        if(imgViewMaxX <= maxX)
        {
            center.x = maxX - (_imgView.frame.size.width/2);
        }
        if(imgViewMaxY <= maxY)
        {
            center.y = maxY - (_imgView.frame.size.height/2);
        }
        
        self.imgView.center = center;
        prevLoc = location;
    }
}

- (void)DoubleTapAction:(UIGestureRecognizer *)sender
{
    //双击放大或者还原
    if (self.imgView.transform.a > 1 &&  self.imgView.transform.d > 1) {
        [UIView animateWithDuration:0.2f animations:^(void) {
            self.imgView.transform = CGAffineTransformIdentity;
            self.imgView.center = _cropperView.center;
        } ];
    } else {
        [UIView animateWithDuration:0.2f animations:^(void) {
            self.imgView.transform = CGAffineTransformScale(self.imgView.transform,2.0, 2.0);
            self.imgView.center = _cropperView.center;
        } ];
    }
}

- (void)RotationAction:(UIGestureRecognizer *)sender {
    if (!_enableRotation) {
        return;
    }
    
    UIRotationGestureRecognizer *recognizer = (UIRotationGestureRecognizer *) sender;
    static CGFloat rot=0;
    
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        rot = recognizer.rotation;
    }
    
    if(sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged)
    {
        self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, recognizer.rotation - rot);
        rot =recognizer.rotation;
        
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if(self.imgView.frame.size.width < _cropperView.frame.size.width || self.imgView.frame.size.height < _cropperView.frame.size.height)
        {
            double scale = MAX(_cropperView.frame.size.width/self.imgView.frame.size.width,_cropperView.frame.size.height/self.imgView.frame.size.height) + 0.01;
            
            self.imgView.transform = CGAffineTransformScale(self.imgView.transform,scale, scale);
        }
    }
}



- (void)overlayClipping
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    // Left side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(0, 0,
                                        self.cropperView.frame.origin.x,
                                        self.overlayView.frame.size.height));
    // Right side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(
                                        self.cropperView.frame.origin.x + self.cropperView.frame.size.width,
                                        0,
                                        self.overlayView.frame.size.width - self.cropperView.frame.origin.x - self.cropperView.frame.size.width,
                                        self.overlayView.frame.size.height));
    // Top side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(0, 0,
                                        self.overlayView.frame.size.width,
                                        self.cropperView.frame.origin.y));
    // Bottom side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(0,
                                        self.cropperView.frame.origin.y + self.cropperView.frame.size.height,
                                        self.overlayView.frame.size.width,
                                        self.overlayView.frame.size.height - self.cropperView.frame.origin.y + self.cropperView.frame.size.height));
    maskLayer.path = path;
    self.overlayView.layer.mask = maskLayer;
    CGPathRelease(path);
}


//获得裁剪图片
- (UIImage*) getCroppedImage {
    
    double zoomScale = [[self.imgView.layer valueForKeyPath:@"transform.scale.x"] floatValue];
    double rotationZ = [[self.imgView.layer valueForKeyPath:@"transform.rotation.z"] floatValue];
    
    CGPoint cropperViewOrigin = CGPointMake( (_cropperView.frame.origin.x - _imgView.frame.origin.x)  *1/zoomScale ,
                                            ( _cropperView.frame.origin.y - _imgView.frame.origin.y ) * 1/zoomScale
                                            );
    CGSize cropperViewSize = CGSizeMake(_cropperView.frame.size.width * (1/zoomScale) ,_cropperView.frame.size.height * (1/zoomScale));
    
    CGRect CropinView = CGRectMake(cropperViewOrigin.x, cropperViewOrigin.y, cropperViewSize.width  , cropperViewSize.height);
    
    CGSize CropinViewSize = CGSizeMake((CropinView.size.width*(1/_imageScale)),(CropinView.size.height*(1/_imageScale)));
    
    
    if((NSInteger)CropinViewSize.width % 2 == 1)
    {
        CropinViewSize.width = ceil(CropinViewSize.width);
    }
    if((NSInteger)CropinViewSize.height % 2 == 1)
    {
        CropinViewSize.height = ceil(CropinViewSize.height);
    }
    
    CGRect CropRectinImage = CGRectMake((NSInteger)(CropinView.origin.x * (1/_imageScale)) ,(NSInteger)( CropinView.origin.y * (1/_imageScale)), (NSInteger)CropinViewSize.width,(NSInteger)CropinViewSize.height);
    
    UIImage *rotInputImage = [[_inputImage fixOrientation] imageRotatedByRadians:rotationZ];
    UIImage *newImage = [rotInputImage cropImage:CropRectinImage];
    
    if(newImage.size.width != self.cropRect.size.width)
    {
        newImage = [newImage resizedImageToFitInSize:self.cropRect.size scaleIfSmaller:YES];
    }
    
    return newImage;
}

//保存图片
- (BOOL) saveCroppedImage:(NSString *) path {
    
    return [UIImagePNGRepresentation([self getCroppedImage]) writeToFile:path atomically:YES];
}

//复位
- (void) actionRestore {
    [UIView animateWithDuration:0.2 animations:^{
        self.imgView.transform = CGAffineTransformIdentity;
        self.imgView.center = _cropperView.center;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
