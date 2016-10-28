//
//  PsnGeneralContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnGeneralContentView.h"

@implementation PsnGeneralContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        //        self.backgroundColor = [UIColor lightGrayColor];
        
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 200)];
        [self addSubview:topBgView];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = topBgView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF01DF94] CGColor], (id)[[CommonFunction colorFromHex:0XFF01ACDF] CGColor], nil];
        [topBgView.layer insertSublayer:gradient atIndex:0];
        [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
        [topBgView.layer setMasksToBounds:YES];// 隐藏边界
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, topBgView.frame.size.width/2-20, 20)];
        passengerTtitle.text = @"旅客进出港统计";
        passengerTtitle.font = [UIFont systemFontOfSize:18];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UILabel *arrPsn = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2, 15, topBgView.frame.size.width/4, 23) text:@"1350" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:arrPsn];
        
        UILabel *depPsn = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*3/4, 15, topBgView.frame.size.width/4-20, 23) text:@"1500" font:20 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:depPsn];
        
        UIView *prTitleView = [[UIView alloc] initWithFrame:CGRectMake(20, 15+23+5, 120, 18)];
        [topBgView addSubview:prTitleView];
        
        [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, prTitleView.frame.size.width/2, 12) text:@"计划" font:12 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF]];
        
        [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(prTitleView.frame.size.width/2, 0, prTitleView.frame.size.width/2, 12) text:@"实际" font:12 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2, 15+23+5, topBgView.frame.size.width/4, 12) text:@"<30min进港" font:12 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*3/4, 15+23+5, topBgView.frame.size.width/4-20, 12) text:@"<1h 出港" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, 60, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, 60+2, topBgView.frame.size.width-40, 12) text:@"2500" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:maxLabel];
        
        UIView *arrBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, topBgView.frame.size.height-60-35)];
        arrBarView.center = CGPointMake(topBgView.frame.size.width/4, (60+topBgView.frame.size.height-35)/2);
        
        [topBgView addSubview:arrBarView];
        
        ProgreesBarView *arrPlan = [[ProgreesBarView alloc] initWithCenter:CGPointMake(arrBarView.frame.size.width/4, arrBarView.frame.size.height/2) size:CGSizeMake(15, arrBarView.frame.size.height) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF9BEEDA].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF94E1EB].CGColor ]proportion:0.5];
        [arrBarView addSubview:arrPlan];
        
        ProgreesBarView *arrReal = [[ProgreesBarView alloc] initWithCenter:CGPointMake(arrBarView.frame.size.width*3/4, arrBarView.frame.size.height/2) size:CGSizeMake(15, arrBarView.frame.size.height) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF4A9EB8].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF4991CB].CGColor ]  proportion:0.55];
        
        [arrBarView addSubview:arrReal];
        
        
        UIView *depBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, topBgView.frame.size.height-60-35)];
        depBarView.center = CGPointMake(topBgView.frame.size.width*3/4, (60+topBgView.frame.size.height-35)/2);
        [topBgView addSubview:depBarView];
        
        ProgreesBarView *depPlan = [[ProgreesBarView alloc] initWithCenter:CGPointMake(depBarView.frame.size.width/4, depBarView.frame.size.height/2) size:CGSizeMake(15, depBarView.frame.size.height) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF9BEEDA].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF94E1EB].CGColor ] proportion:0.6];
        [depBarView addSubview:depPlan];
        
        ProgreesBarView *depReal = [[ProgreesBarView alloc] initWithCenter:CGPointMake(depBarView.frame.size.width*3/4, depBarView.frame.size.height/2) size:CGSizeMake(15, depBarView.frame.size.height) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF4A9EB8].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF4991CB].CGColor ] proportion:0.62];
        
        [depBarView addSubview:depReal];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-(35+15), topBgView.frame.size.width-40, 12) text:@"0" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, topBgView.frame.size.height-35, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF41C6DD]]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-35+5, topBgView.frame.size.width/2-20, 15) text:@"进港" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2, topBgView.frame.size.height-35+5, topBgView.frame.size.width/2-20, 15) text:@"出港" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        UILabel *arrLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30, kScreenWidth/2-20, 30) text:@"进港(计划/实际)" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"进港(计划/实际)"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF000000] range:NSMakeRange(2, 7)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(2, 7)];
        arrLabel.attributedText = attrStr;
        [self addSubview:arrLabel];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30, kScreenWidth/2-20, 30) text:@"1520/1519" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        UILabel *depLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+30, kScreenWidth/2-20, 20) text:@"出港(计划/实际)" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        NSMutableAttributedString* attrStrD = [[NSMutableAttributedString alloc] initWithString:@"出港(计划/实际)"];
        [attrStrD addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF000000] range:NSMakeRange(2, 7)];
        [attrStrD addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(2, 7)];
        depLabel.attributedText = attrStrD;
        [self addSubview:depLabel];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+30, kScreenWidth/2-20, 20) text:@"1568/1562" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+30+90, kScreenWidth/2-20, 20) text:@"隔离区" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+30+90, kScreenWidth/2-20, 20) text:@"1568人" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000]];

        
    }
    
    return self;
}

@end
