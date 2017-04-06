//
//  WaterWareView.h
//  ios 动画
//
//  Created by tepusoft on 16/4/22.
//  Copyright © 2016年 tepusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WaterWareStatus) {
    waterWareStatusZC, //正常
    waterWareStatusXYW,//小面积延误
    waterWareStatusDYW //大面积延误
};

@interface WaterWareView : UIView

@property (nonatomic, strong) UIColor *firstWaveColor;
@property (nonatomic, strong) UILabel *titleLabel;

-(id)initWithFrame:(CGRect)frame color:(UIColor *)color;

-(void)updateStatus:(WaterWareStatus)status;

@end
