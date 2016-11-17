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
        
        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"PsnGeneralChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, viewWidth(topBgView)-100, 10)];
        passengerTtitle.text = @"旅客进出港统计";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UILabel *arrPsn = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2, 8, topBgView.frame.size.width/4, 23) text:@"1350" font:18 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:arrPsn];
        
        UILabel *depPsn = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*3/4, viewY(arrPsn), topBgView.frame.size.width/4-20, 23) text:@"1500" font:18 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:depPsn];
        
        UIView *prTitleView = [[UIView alloc] initWithFrame:CGRectMake(16, viewBotton(arrPsn)+2, 120, 12)];
        [topBgView addSubview:prTitleView];

        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 10, 10)];
        planImageView.image = [UIImage imageNamed:@"PsnGeneralChartTag1"];
        [prTitleView addSubview:planImageView];
        [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2, 0, 40, 12) text:@"计划" font:27/2 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF]];

        UIImageView *realImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planImageView)+2+40+16, 2, 10, 10)];
        realImageView.image = [UIImage imageNamed:@"PsnGeneralChartTag2"];
        [prTitleView addSubview:realImageView];
        [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+2, 0, 40, 12) text:@"实际" font:27/2 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2, viewBotton(arrPsn)+4, topBgView.frame.size.width/4, 11) text:@"<30min 进港" font:11 textAlignment:NSTextAlignmentCenter colorFromHex:0x75FFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*3/4, viewBotton(arrPsn)+4, topBgView.frame.size.width/4-20, 11) text:@"<1h 出港" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];
        

        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, viewBotton(prTitleView)+8, viewWidth(topBgView)-32, 0.5)];
        lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,viewBotton(lineImageView)+4, 50, 12) text:@"2500" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
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
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-(35+15), topBgView.frame.size.width-40, 12) text:@"0" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];

        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, topBgView.frame.size.height-32, topBgView.frame.size.width-40, 0.5)];
        downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewX(arrBarView), topBgView.frame.size.height-35+8,viewWidth(arrBarView), 15) text:@"进港" font:29/2 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewX(depBarView), topBgView.frame.size.height-35+8,viewWidth(depBarView), 15) text:@"出港" font:29/2 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF]];

        UIImageView *arrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, viewBotton(topBgView)+30+21, 20, 15)];
        arrImageView.image = [UIImage imageNamed:@"ArrFlightTag"];
        [self addSubview:arrImageView];
        UILabel *arrLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(arrImageView)+16, viewY(arrImageView), 150,  viewHeight(arrImageView)) text:@"进港(计划/实际)" font:18 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"进港(计划/实际)"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF000000] range:NSMakeRange(2, 7)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:27/2] range:NSMakeRange(2, 7)];
        arrLabel.attributedText = attrStr;
        [self addSubview:arrLabel];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, viewY(arrImageView), kScreenWidth/2-20, viewHeight(arrImageView)) text:@"1520/1519" font:36/2 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000]];

        UIImageView *arrlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(arrLabel), viewBotton(arrLabel)+21, viewWidth(self)-viewX(arrLabel)-20, 0.5)];
        arrlineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:arrlineImageView];

        UIImageView *depImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, viewBotton(arrlineImageView)+21, 20, 15)];
        depImageView.image = [UIImage imageNamed:@"DepFlightTag"];
        [self addSubview:depImageView];
        
        UILabel *depLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(depImageView)+16, viewY(depImageView), 150, viewHeight(depImageView)) text:@"出港(计划/实际)" font:18 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000];
        NSMutableAttributedString* attrStrD = [[NSMutableAttributedString alloc] initWithString:@"出港(计划/实际)"];
        [attrStrD addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF000000] range:NSMakeRange(2, 7)];
        [attrStrD addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:27/2] range:NSMakeRange(2, 7)];
        depLabel.attributedText = attrStrD;
        [self addSubview:depLabel];


        UILabel *depValueLabel =[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, viewY(depImageView), kScreenWidth/2-20, 20) text:@"1568/1562" font:36/2 textAlignment:NSTextAlignmentRight colorFromHex:0xFF000000];
        [self addSubview:depValueLabel];

        UIButton * depValueButton = [[UIButton alloc]initWithFrame:depValueLabel.frame];
        [depValueButton addTarget:self action:@selector(showPassengerHourView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:depValueButton];

        UIImageView *deplineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(arrLabel), viewBotton(depLabel)+21, viewWidth(self)-viewX(arrLabel)-20, 0.5)];
        deplineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:deplineImageView];
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(20,viewBotton(deplineImageView), kScreenWidth-40, viewHeight(self)- viewBotton(deplineImageView)) text:[NSString stringWithFormat:@"隔离区%@人",@"1231"] font:33/2 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF17B9E8]];
        UIImageView *DMZNumBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake((viewWidth(self)-199)/2, (viewHeight(self)-viewBotton(deplineImageView)-42)/2+viewBotton(deplineImageView), 199, 42)];
        DMZNumBackgroundImageView.image = [UIImage imageNamed:@"DMZNumBackground"];
        [self addSubview:DMZNumBackgroundImageView];
        UIButton *DMZNumButton = [[UIButton alloc] initWithFrame:DMZNumBackgroundImageView.frame];
        [DMZNumButton addTarget:self action:@selector(showSafetyPassenger:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:DMZNumButton];

        
//        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+30+90, kScreenWidth/2-20, 20) text:@"1568人" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000]];

        
    }
    
    return self;
}

-(void)showPassengerHourView:(NSNotification *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSafetyPassenger" object:nil];
}

-(void)showSafetyPassenger:(NSNotification *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSafetyPassenger" object:nil];
}

@end
