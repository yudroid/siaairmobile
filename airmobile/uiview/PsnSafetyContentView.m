//
//  PsnSafetyContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyContentView.h"
#import "ProgreesBarView.h"

@interface PsnSafetyContentView()

@property (nonatomic ,copy) NSArray<NSDictionary *> *dataArray;

@end

@implementation PsnSafetyContentView

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray<NSDictionary *> *)dataArray
{
    self = [super initWithFrame:frame];
    
    if(self){

        _dataArray = dataArray;
        
        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"PsnSafetyChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(px_px_2_3(33, 55), px_px_2_3(13, 21), topBgView.frame.size.width-20, 21)];
        passengerTtitle.text = @"旅客机上等待时间分段统计";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:px_px_2_3(27, 42)];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle), viewBotton(passengerTtitle)+px_px_2_3(51, 79), viewWidth(topBgView)-viewX(passengerTtitle)-px_px_2_3(33, 55) *2, 0.5)];
        lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];

        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(px_px_2_3(33, 55),viewBotton(lineImageView)+px_px_2_3(9, 15), viewWidth(lineImageView), 9) text:@"2500" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(px_px_2_3(33, 55), topBgView.frame.size.height-(35+15), topBgView.frame.size.width-px_px_2_3(33, 55)*2, 12) text:@"0" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];
        
        ProgreesBarView *lqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/6, (60+topBgView.frame.size.height-35)/2) size:CGSizeMake(15, topBgView.frame.size.height-60-35) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]  proportion:0.8];
        
        [topBgView addSubview:lqBarProgress];
        
        ProgreesBarView *eqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/2, (60+topBgView.frame.size.height-35)/2) size:CGSizeMake(15, topBgView.frame.size.height-60-35) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]  proportion:0.3];
        
        [topBgView addSubview:eqBarProgress];
        
        ProgreesBarView *dqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width*5/6, (60+topBgView.frame.size.height-35)/2) size:CGSizeMake(15, topBgView.frame.size.height-60-35) direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]  proportion:0.45];
        
        [topBgView addSubview:dqBarProgress];

        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle), topBgView.frame.size.height-32, viewWidth(topBgView)-viewX(passengerTtitle)-px_px_2_3(33, 55) *2, 0.5)];
        downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];
        
    
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-35+5, topBgView.frame.size.width/3-20, 15) text:@"小于1H" font:29/2 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/3, topBgView.frame.size.height-35+5, topBgView.frame.size.width/3, 29/2) text:@"1~2H" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*2/3, topBgView.frame.size.height-35+5, topBgView.frame.size.width/3-20, 29/2) text:@"大于2H" font:15 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
//        UILabel *lqLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30, kScreenWidth/2-20, 30) text:@"小于1H" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
//        [self addSubview:lqLabel];
//        
//        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30, kScreenWidth/2-20, 30) text:@"721" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
//        
//        UILabel *eqLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+10, kScreenWidth/2-20, 30) text:@"1~2H" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
//        [self addSubview:eqLabel];
//        
//        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10, kScreenWidth/2-20, 30) text:@"350" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
//        
//        UILabel *dqLabel = [CommonFunction addLabelFrame:CGRectMake(20, 200+30+30+10+30+10, kScreenWidth/2-20, 30) text:@"大于2H" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
//        [self addSubview:dqLabel];
//        
//        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10+30+10, kScreenWidth/2-20, 30) text:@"430" font:25 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];
//        

        //less
        UIImageView *lessImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(54, 89), viewBotton(topBgView)+px_px_2_2_3(40, 62, 93), 19/2,37/2)];
        lessImageView.image = [UIImage imageNamed:@"PsnSafetyLess"];
        //        arrImageView.backgroundColor = [UIColor redColor];
        [self addSubview:lessImageView];
        UILabel *lessLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(lessImageView)+16, viewY(lessImageView), 150,  viewHeight(lessImageView)) text:@"小于1h" font:18 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        [self addSubview:lessLabel];

        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, viewY(lessImageView), kScreenWidth/2-20, viewHeight(lessImageView)) text:@"100" font:36/2 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];

        UIImageView *lesslineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(lessLabel), viewBotton(lessLabel)+px_px_2_2_3(30, 42, 63), viewWidth(self)-viewX(lessLabel)-20, 0.5)];
        lesslineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:lesslineImageView];

        //equal
        UIImageView *equalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(54, 89), viewBotton(lesslineImageView)+px_px_2_2_3(30, 42, 63)+7, 32/2,11/2)];
        equalImageView.image = [UIImage imageNamed:@"PsnSafetyEqual"];
        [self addSubview:equalImageView];

        UILabel *equalLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(equalImageView)+16, viewY(equalImageView)-7, 150, viewHeight(lessImageView)) text:@"1-2h" font:18 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        [self addSubview:equalLabel];


        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, viewY(equalLabel), kScreenWidth/2-20, 20) text:@"99" font:36/2 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];

        UIImageView *equallineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(equalLabel), viewBotton(equalLabel)+px_px_2_2_3(30, 42, 63), viewWidth(self)-viewX(equalLabel)-20, 0.5)];
        equallineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:equallineImageView];

        //more

        UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(54, 89), viewBotton(equallineImageView)+px_px_2_2_3(30, 42, 63), 19/2,37/2)];
        moreImageView.image = [UIImage imageNamed:@"PsnSafetyMore"];
        [self addSubview:moreImageView];

        UILabel *moreLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(equalImageView)+16, viewY(moreImageView), 150, viewHeight(moreImageView)) text:@"1-2h" font:18 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        [self addSubview:moreLabel];


        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, viewY(moreImageView), kScreenWidth/2-20, 20) text:@"99" font:36/2 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];

        UIImageView *morelineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(moreLabel), viewBotton(moreImageView)+px_px_2_2_3(30, 42, 63), viewWidth(self)-viewX(moreImageView)-20, 0.5)];
        morelineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:morelineImageView];


        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(20,viewBotton(morelineImageView), kScreenWidth-40, viewHeight(self)- viewBotton(morelineImageView)) text:[NSString stringWithFormat:@"高峰旅客日排名"] font:33/2 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF17B9E8]];

        UIImageView *DMZNumBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake((viewWidth(self)-199)/2, (viewHeight(self)-viewBotton(morelineImageView)-42)/2+viewBotton(morelineImageView), 199, 42)];
        DMZNumBackgroundImageView.image = [UIImage imageNamed:@"DMZNumBackground"];
        [self addSubview:DMZNumBackgroundImageView];
        UIButton *DMZNumButton = [[UIButton alloc] initWithFrame:DMZNumBackgroundImageView.frame];
        [DMZNumButton addTarget:self action:@selector(showTop5DaysView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:DMZNumButton];


        
        //[self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10+30+10+90, kScreenWidth/2-20, 20) text:@"" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000]];
        
    }
    
    return self;
}

-(void)showTop5DaysView:(NSNotification *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTop5DaysView" object:nil];
}


@end
