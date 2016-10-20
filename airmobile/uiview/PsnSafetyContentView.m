//
//  PsnSafetyContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyContentView.h"
#import "ProgreesBarView.h"

@implementation PsnSafetyContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        //        self.backgroundColor = [UIColor lightGrayColor];
        
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 200)];
        [self addSubview:topBgView];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = topBgView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFFFFA869] CGColor], (id)[[CommonFunction colorFromHex:0XFFFE5A99] CGColor], nil];
        [topBgView.layer insertSublayer:gradient atIndex:0];
        [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
        [topBgView.layer setMasksToBounds:YES];// 隐藏边界
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, topBgView.frame.size.width-20, 20)];
        passengerTtitle.text = @"旅客机上等待时间分段统计";
        passengerTtitle.font = [UIFont systemFontOfSize:18];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, 60, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFFFFB294]]];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, 60+2, topBgView.frame.size.width-40, 12) text:@"2500" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:maxLabel];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-(35+15), topBgView.frame.size.width-40, 12) text:@"0" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF]];
        
        ProgreesBarView *lqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/6, (60+topBgView.frame.size.height-35)/2) size:CGSizeMake(15, topBgView.frame.size.height-60-35) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]  proportion:0.8];
        
        [topBgView addSubview:lqBarProgress];
        
        ProgreesBarView *eqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/2, (60+topBgView.frame.size.height-35)/2) size:CGSizeMake(15, topBgView.frame.size.height-60-35) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]  proportion:0.3];
        
        [topBgView addSubview:eqBarProgress];
        
        ProgreesBarView *dqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width*5/6, (60+topBgView.frame.size.height-35)/2) size:CGSizeMake(15, topBgView.frame.size.height-60-35) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]  proportion:0.45];
        
        [topBgView addSubview:dqBarProgress];
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, topBgView.frame.size.height-35, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFFFE8DAD]]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-35+5, topBgView.frame.size.width/3-20, 15) text:@"小于1H" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/3, topBgView.frame.size.height-35+5, topBgView.frame.size.width/3, 15) text:@"1~2H" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*2/3, topBgView.frame.size.height-35+5, topBgView.frame.size.width/3-20, 15) text:@"大于2H" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        UILabel *lqLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30, kScreenWidth/2-20, 30) text:@"小于1H" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        [self addSubview:lqLabel];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30, kScreenWidth/2-20, 30) text:@"721" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        UILabel *eqLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+10, kScreenWidth/2-20, 30) text:@"1~2H" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        [self addSubview:eqLabel];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10, kScreenWidth/2-20, 30) text:@"350" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        UILabel *dqLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+10+30+10, kScreenWidth/2-20, 30) text:@"大于2H" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        [self addSubview:dqLabel];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10+30+10, kScreenWidth/2-20, 30) text:@"430" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+10+30+10+90, kScreenWidth/2-20, 20) text:@"隔离区" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10+30+10+90, kScreenWidth/2-20, 20) text:@"1568人" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000]];
        UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200+30+30+10+30+10+90, kScreenWidth-40, 20)];
        [showBtn addTarget:self action:@selector(showSafetyPassenger:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:showBtn];
        
    }
    
    return self;
}

-(void) showSafetyPassenger:(id)sender
{
   
}

@end
