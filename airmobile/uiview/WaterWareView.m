//
//  WaterWareView.m
//  ios 动画
//
//  Created by tepusoft on 16/4/22.
//  Copyright © 2016年 tepusoft. All rights reserved.
//

#import "WaterWareView.h"

@interface WaterWareView()

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;



@end

@implementation WaterWareView
{
    CGFloat waveA;//水纹振幅
    CGFloat waveW ;//水纹周期
    CGFloat offsetX; //位移
    CGFloat currentK; //当前波浪高度Y
    CGFloat waveSpeed;//水纹速度
    CGFloat waterWaveWidth; //水纹宽度
}
-(id)initWithFrame:(CGRect)frame color:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        self.firstWaveColor = color;
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        self.layer.cornerRadius = self.frame.size.width/2.0;
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = _firstWaveColor.CGColor;

        [self setUp];
    }
    
    return self;
}


-(void)setUp
{
    //设置波浪的宽度
    waterWaveWidth = self.frame.size.width;
    //设置波浪的颜色
//    _firstWaveColor = [UIColor colorWithRed:223/255.0 green:22/255.0 blue:64/255.0 alpha:1];
    //设置波浪的速度
    waveSpeed = 0.4/M_PI;
    
    //初始化layer
    if (_firstWaveLayer == nil) {
        //初始化
        _firstWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        _firstWaveLayer.strokeColor = _firstWaveColor.CGColor;
        //设置边缘线的宽度
        _firstWaveLayer.lineWidth = 4.0;
        _firstWaveLayer.strokeStart = 0.0;
        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    //设置波浪流动速度
    waveSpeed = 0.1;
    //设置振幅
    waveA = 10;
    //设置周期
    waveW = 1/30.0;
    //设置波浪纵向位置
    currentK = self.frame.size.height/2;//屏幕居中
    //启动定时器
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    //实时的位移
    offsetX += waveSpeed;
    [self setCurrentFirstWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath
{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=waterWaveWidth; x++) {
        //正玄波浪公式
        y = waveA * sin(waveW * x+ offsetX)+currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
    CGPathRelease(path);
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth(self), viewHeight(self))];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
    }

    return _titleLabel;
}


-(void)updateStatus:(WaterWareStatus)status
{
    //颜色 正常e53dfc7a  小面积延误e5ffc32d 大面积延误e5FF3030
    switch (status) {
        case waterWareStatusZC:{
            _firstWaveColor = [CommonFunction colorFromHex:0xe53dfc7a];
            self.backgroundColor = [CommonFunction colorFromHex:0x553dfc7a];
            break;
        }
        case waterWareStatusXYW:
            _firstWaveColor = [CommonFunction colorFromHex:0xe5ffc32d];
            self.backgroundColor = [CommonFunction colorFromHex:0x55ffc32d];
            break;
        case waterWareStatusDYW:
            _firstWaveColor = [CommonFunction colorFromHex:0xe5FF3030];
            self.backgroundColor = [CommonFunction colorFromHex:0x55FF3030];
            break;

        default:
            break;
    }

    self.layer.borderColor = _firstWaveColor.CGColor;
    //设置闭环的颜色
    _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
    //设置边缘线的颜色
    _firstWaveLayer.strokeColor = _firstWaveColor.CGColor;


}
-(void)dealloc
{
    [_waveDisplaylink invalidate];
}

@end
