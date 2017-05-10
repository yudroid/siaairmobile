//
//  ZYShowPictureView.m
//  ZYPictureChange
//
//  Created by 赵越 on 16/3/7.
//  Copyright © 2016年 赵越. All rights reserved.
//

//
//  LYHShowPictureView.m
//  Liangyihui
//
//  Created by 方春高 on 15/12/9.
//  Copyright © 2015年 Liangyihui. All rights reserved.
//

#import "ZYShowPictureView.h"

@interface ZYShowPictureView()
@property (nonatomic, assign) CGPoint origin;//临时储存截止
@property (nonatomic, assign) CGSize size;//临时储存截止
@property (nonatomic, assign) CGAffineTransform transformStart;//第一次缩放时候记录
@property (nonatomic, assign) BOOL needLimit;//是否需要限制大小什么的
@property (nonatomic, assign) CGFloat maxScale;//限制的最大比例
@property (nonatomic, assign) CGFloat minScale;//限制的最小比例
@property (nonatomic, assign) CGAffineTransform transformUse;//每次缩放时候记录
@property (nonatomic, assign) CGFloat imageScale;
@property (nonatomic, assign) CGRect originFrame;//初次大小
@property (nonatomic, assign) BOOL hasChanged;//是否移动或缩放过
@end

@implementation ZYShowPictureView

#define SCREENSIZE [UIScreen mainScreen].bounds.size

- (instancetype)init {
    self = [super init];
    if (self) {
        //添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEvent:)];
        [self addGestureRecognizer:pan];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchEvent:)];
        [self addGestureRecognizer:pinch];
        self.userInteractionEnabled = YES;
        self.imageScale = 1.;
    }
    return self;
}

- (void)setLimitWithMaxScale:(CGFloat)maxScale minScale:(CGFloat)minScale {
    if (maxScale <= minScale || minScale < 0 || minScale > 1) {
        return;
    }
    self.maxScale = maxScale;
    self.minScale = minScale;
    self.needLimit = YES;
}

//pan动作在过程中是不连续的，需要介质重置
- (void)panEvent:(UIPanGestureRecognizer *)pan {
    CGPoint changePoint = [pan translationInView:self.superview];//获取动作捕捉时手指的位置，不要放在self上，否则缩小后会乱飞
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (!self.hasChanged) {
            self.originFrame = self.frame;
            self.hasChanged = YES;
        }
        self.origin = self.frame.origin;
        self.size = self.frame.size;
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat x = self.origin.x + changePoint.x;
        CGFloat y = self.origin.y + changePoint.y;
        CGFloat width = self.size.width;
        CGFloat height = self.size.height;
        CGFloat bottomX = x + width;
        CGFloat bottomY = y + height;
        CGFloat screenWidth = SCREENSIZE.width;
        CGFloat screenHeight = SCREENSIZE.height;
        if (self.frame.size.height > self.originFrame.size.height || self.frame.size.width > self.originFrame.size.width) {
            if (self.frame.size.width > screenWidth && self.frame.size.height > screenHeight) {
                if (x > 0 && y > 0) {
                    self.frame = CGRectMake(0, 0, width, height);
                }else if (x > 0 && bottomY < screenHeight) {
                    self.frame = CGRectMake(0, screenHeight - height, width, height);
                }else if (y > 0 && bottomX < screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, 0, width, height);
                }else if (bottomY < screenHeight && bottomX < screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, screenHeight - height, width, height);
                }else if (x > 0) {
                    self.frame = CGRectMake(0, y, width, height);
                }else if (bottomX < screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, y, width, height);
                }else if (y > 0) {
                    self.frame = CGRectMake(x, 0, width, height);
                }else if (bottomY < screenHeight) {
                    self.frame = CGRectMake(x, screenHeight - height, width, height);
                }else {
                    self.frame = CGRectMake(x, y, width, height);
                }
            }else if (self.frame.size.width > screenWidth) {
                if (x > 0 && y < 0) {
                    self.frame = CGRectMake(0, 0, width, height);
                }else if ((bottomX < screenWidth && y < 0)) {
                    self.frame = CGRectMake(screenWidth - width, 0, width, height);
                }else if (x > 0 && bottomY > screenHeight) {
                    self.frame = CGRectMake(0, screenHeight - height, width, height);
                }else if (bottomX < screenWidth && bottomY > screenHeight) {
                    self.frame = CGRectMake(screenWidth - width, screenHeight - height, width, height);
                }else if (y < 0) {
                    self.frame = CGRectMake(x, 0, width, height);
                }else if (bottomX < screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, y, width, height);
                }else if (x > 0) {
                    self.frame = CGRectMake(0, y, width, height);
                }else if (bottomY > screenHeight) {
                    self.frame = CGRectMake(x, screenHeight - height, width, height);
                }else {
                    self.frame = CGRectMake(x, y, width, height);
                }
            }else if (self.frame.size.height > screenHeight) {
                if (x < 0 && y > 0) {
                    self.frame = CGRectMake(0, 0, width, height);
                }else if ( x < 0 && bottomY < screenHeight) {
                    self.frame = CGRectMake(0, screenHeight - height, width, height);
                }else if (bottomX > screenWidth && bottomY < screenHeight) {
                    self.frame = CGRectMake(screenWidth - width, screenHeight - height, width, height);
                }else if (y > 0 && bottomX > screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, 0, width, height);
                }else if (y > 0) {
                    self.frame = CGRectMake(x, 0, width, height);
                }else if (x < 0) {
                    self.frame = CGRectMake(0, y, width, height);
                }else if (bottomY < screenHeight) {
                    self.frame = CGRectMake(x, screenHeight - height, width, height);
                }else if (bottomX > screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, y, width, height);
                }else {
                    self.frame = CGRectMake(x, y, width, height);
                }
            }else {
                if (x < 0 && y < 0) {
                    self.frame = CGRectMake(0, 0, width, height);
                }else if (x < 0 && bottomY > screenHeight) {
                    self.frame = CGRectMake(0, screenHeight - height, width, height);
                }else if (y < 0 && bottomX > screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, 0, width, height);
                }else if (bottomY > screenHeight && bottomX > screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, screenHeight - height, width, height);
                }else if (x < 0) {
                    self.frame = CGRectMake(0, y, width, height);
                }else if (y < 0) {
                    self.frame = CGRectMake(x, 0, width, height);
                }else if (bottomX > screenWidth) {
                    self.frame = CGRectMake(screenWidth - width, y, width, height);
                }else if (bottomY > screenHeight) {
                    self.frame = CGRectMake(x, screenHeight - height, width, height);
                }else {
                    self.frame = CGRectMake(x, y, width, height);
                }
            }
        }
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        self.origin = CGPointZero;
        self.size = CGSizeZero;
    }
}

//pinch动作在一次过程中是连续的，不需要重置任何参数
- (void)pinchEvent:(UIPinchGestureRecognizer *)pinch {
    if (pinch.state == UIGestureRecognizerStateBegan) {
        if (!self.hasChanged) {
            self.originFrame = self.frame;
            self.hasChanged = YES;
        }
        if (self.imageScale == 1. && self.needLimit) {
            self.transformStart = self.transform;
        }
        self.transformUse = self.transform;
    }else if (pinch.state == UIGestureRecognizerStateChanged) {
        CGFloat scale = pinch.scale;
        self.transform = CGAffineTransformScale(self.transformUse, scale, scale);
    }else if (pinch.state == UIGestureRecognizerStateEnded) {
        if (!self.needLimit) {
            return;
        }
        self.imageScale *= pinch.scale;
        if (self.imageScale > 2) {
            self.transform = CGAffineTransformScale(self.transformStart, 2, 2);
            self.imageScale = 2;
        }else if (self.imageScale < 1) {
            self.transform = CGAffineTransformScale(self.transformStart, 1, 1);
            self.imageScale = 1;
            self.frame = self.originFrame;
        }
    }
}

@end

