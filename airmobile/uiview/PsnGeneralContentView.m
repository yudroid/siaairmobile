//
//  PsnGeneralContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnGeneralContentView.h"
#import "PassengerModel.h"

@interface PsnGeneralContentView()

@property (nonatomic ,strong) PassengerModel *passengerModel;

@end

@implementation PsnGeneralContentView
{
    UILabel *arrPsn;
    UILabel *depPsn;
    UILabel *maxLabel;
    UIView *arrBarView ;
    ProgreesBarView *arrPlan;
    ProgreesBarView *arrReal;
    UIView *depBarView;
    ProgreesBarView *depPlan;
    ProgreesBarView *depReal ;
    UILabel *minLabel;
    UILabel *arrValueLabel ;
    UILabel *depValueLabel;
    UILabel *DMZPeopleLabel;

}

-(instancetype)initWithFrame:(CGRect)frame passengerModel:(PassengerModel *)passengerModel
{
    self = [super initWithFrame:frame];
    
    if(self){

        _passengerModel = passengerModel;
        
        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                     0,
                                                                     topBgViewWidth,
                                                                     topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                             0,
                                                                                             viewWidth(topBgView),
                                                                                             viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"PsnGeneralChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16,
                                                                             8,
                                                                             viewWidth(topBgView)-100,
                                                                             13)];
        passengerTtitle.text = @"旅客进出港统计";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                               size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        arrPsn = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2,
                                                                   8,
                                                                   topBgView.frame.size.width/4,
                                                                   23)
                                                   text:@(_passengerModel.hourInCount).stringValue
                                                   font:18
                                          textAlignment:NSTextAlignmentCenter
                                           colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:arrPsn];
        
        depPsn = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*3/4,
                                                                   viewY(arrPsn),
                                                                   topBgView.frame.size.width/4-20,
                                                                   23)
                                                   text:@(_passengerModel.hourOutCount).stringValue
                                                   font:18
                                          textAlignment:NSTextAlignmentRight
                                           colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:depPsn];
        
        UIView *prTitleView = [[UIView alloc] initWithFrame:CGRectMake(16,
                                                                       viewBotton(arrPsn)+2,
                                                                       120,
                                                                       12)];
        [topBgView addSubview:prTitleView];

        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                  2,
                                                                                  11,
                                                                                  11)];
        planImageView.image = [UIImage imageNamed:@"PsnGeneralChartTag1"];
        [prTitleView addSubview:planImageView];
        [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2,
                                                                         0,
                                                                         40,
                                                                         12)
                                                         text:@"计划"
                                                         font:27/2
                                                textAlignment:NSTextAlignmentLeft
                                                 colorFromHex:0xFFFFFFFF]];

        UIImageView *realImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planImageView)+2+40+16,
                                                                                  1,
                                                                                  12,
                                                                                  12)];
        realImageView.image         = [UIImage imageNamed:@"PsnGeneralChartTag2"];
        realImageView.alpha         = 0.8;
        [prTitleView addSubview:realImageView];
        [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+2,
                                                                         0,
                                                                         40,
                                                                         12)
                                                         text:@"实际"
                                                         font:27/2
                                                textAlignment:NSTextAlignmentLeft
                                                 colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/2,
                                                                       viewBotton(arrPsn)+4,
                                                                       topBgView.frame.size.width/4,
                                                                       11) text:@"<30min 进港"
                                                       font:11
                                              textAlignment:NSTextAlignmentCenter
                                               colorFromHex:0x95FFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*3/4,
                                                                       viewBotton(arrPsn)+4,
                                                                       topBgView.frame.size.width/4-20,
                                                                       11)
                                                       text:@"<1h 出港"
                                                       font:11
                                              textAlignment:NSTextAlignmentRight
                                               colorFromHex:0x95FFFFFF]];
        

        UIImageView *lineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(16,
                                                                                  viewBotton(prTitleView)+8,
                                                                                  viewWidth(topBgView)-32,
                                                                                  0.5)];
        lineImageView.image         = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];
        
        maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,viewBotton(lineImageView)+4, 50, 12)
                                                     text:@([self maxValue]*1.2).stringValue
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x95FFFFFF];
        [topBgView addSubview:maxLabel];
        
        arrBarView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      40,
                                                                      topBgView.frame.size.height-60-35)];
        arrBarView.center = CGPointMake(topBgView.frame.size.width/4,
                                        (60+topBgView.frame.size.height-35)/2);
        [topBgView addSubview:arrBarView];
        
        arrPlan = [[ProgreesBarView alloc] initWithCenter:CGPointMake(arrBarView.frame.size.width/4,
                                                                                       arrBarView.frame.size.height/2)
                                                                      size:CGSizeMake(15, arrBarView.frame.size.height)
                                                                 direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF9BEEDA].CGColor,
                                                                                      (__bridge id)[CommonFunction colorFromHex:0XFF94E1EB].CGColor ]
                                               proportion:_passengerModel.planInCount/([self maxValue]*1.2)];
        [arrBarView addSubview:arrPlan];
        
        arrReal = [[ProgreesBarView alloc] initWithCenter:CGPointMake(arrBarView.frame.size.width*3/4,
                                                                                       arrBarView.frame.size.height/2)
                                                                      size:CGSizeMake(15, arrBarView.frame.size.height)
                                                                 direction:4
                                                                    colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF4A9EB8].CGColor,
                                                                             (__bridge id)[CommonFunction colorFromHex:0XFF4991CB].CGColor ]
                                                                proportion:_passengerModel.realInCount/([self maxValue]*1.2)];
        [arrBarView addSubview:arrReal];
        
        
        depBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, topBgView.frame.size.height-60-35)];
        depBarView.center = CGPointMake(topBgView.frame.size.width*3/4, (60+topBgView.frame.size.height-35)/2);
        [topBgView addSubview:depBarView];
        
        depPlan = [[ProgreesBarView alloc] initWithCenter:CGPointMake(depBarView.frame.size.width/4,
                                                                                       depBarView.frame.size.height/2)
                                                                      size:CGSizeMake(15, depBarView.frame.size.height)
                                                                 direction:4
                                                                    colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF9BEEDA].CGColor,
                                                                             (__bridge id)[CommonFunction colorFromHex:0XFF94E1EB].CGColor ]
                                                                proportion:_passengerModel.planOutCount/([self maxValue]*1.2)];
        [depBarView addSubview:depPlan];
        
        depReal = [[ProgreesBarView alloc] initWithCenter:CGPointMake(depBarView.frame.size.width*3/4,
                                                                                       depBarView.frame.size.height/2)
                                                                      size:CGSizeMake(15, depBarView.frame.size.height)
                                                                 direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF4A9EB8].CGColor,
                                                                                      (__bridge id)[CommonFunction colorFromHex:0XFF4991CB].CGColor ]
                                                                proportion:_passengerModel.realOutCount/([self maxValue]*1.2)];
        
        [depBarView addSubview:depReal];

        minLabel =[CommonFunction addLabelFrame:CGRectMake(20,
                                                                    topBgView.frame.size.height-(35+15),
                                                                    topBgView.frame.size.width-40,
                                                                    12)
                                                    text:@(_passengerModel.minCount).stringValue
                                                    font:11
                                           textAlignment:NSTextAlignmentRight
                                            colorFromHex:0x75FFFFFF];

        [topBgView addSubview:minLabel];

        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,
                                                                                      topBgView.frame.size.height-32,
                                                                                      topBgView.frame.size.width-40,
                                                                                      0.5)];
        downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewX(arrBarView),
                                                                       topBgView.frame.size.height-35+8,
                                                                       viewWidth(arrBarView),
                                                                       15)
                                                       text:@"进港"
                                                       font:29/2
                                              textAlignment:NSTextAlignmentCenter
                                               colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewX(depBarView),
                                                                       topBgView.frame.size.height-35+8,
                                                                       viewWidth(depBarView),
                                                                       15)
                                                       text:@"出港"
                                                       font:29/2
                                              textAlignment:NSTextAlignmentCenter
                                               colorFromHex:0xFFFFFFFF]];

        UIImageView *arrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,
                                                                                 viewBotton(topBgView)+30+21,
                                                                                 20,
                                                                                 15)];
        arrImageView.image = [UIImage imageNamed:@"ArrFlightTag"];
        [self addSubview:arrImageView];
        UILabel *arrLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(arrImageView)+16,
                                                                     viewY(arrImageView),
                                                                     150,
                                                                     viewHeight(arrImageView))
                                                     text:@"进港(计划/实际)"
                                                     font:18
                                            textAlignment:NSTextAlignmentLeft
                                             colorFromHex:0xFF000000];

        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"进港(计划/实际)"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF000000] range:NSMakeRange(2, 7)];
        [attrStr addAttribute:NSFontAttributeName            value:[UIFont fontWithName:@"PingFangSC-Regular" size:27/2] range:NSMakeRange(2, 7)];
        arrLabel.attributedText = attrStr;
        [self addSubview:arrLabel];

        arrValueLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                          viewY(arrImageView),
                                                                          kScreenWidth/2-20,
                                                                          viewHeight(arrImageView))
                                                          text:[NSString stringWithFormat:@"%d/%d",_passengerModel.planInCount,_passengerModel.realInCount]
                                                          font:36/2
                                                 textAlignment:NSTextAlignmentRight
                                                  colorFromHex:0xFF000000];
        [self addSubview:arrValueLabel];

        UIImageView *arrlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(arrLabel),
                                                                                     viewBotton(arrLabel)+21,
                                                                                     viewWidth(self)-viewX(arrLabel)-20,
                                                                                     0.5)];
        arrlineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:arrlineImageView];

        UIImageView *depImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,
                                                                                 viewBotton(arrlineImageView)+21,
                                                                                 20,
                                                                                 15)];
        depImageView.image = [UIImage imageNamed:@"DepFlightTag"];
        [self addSubview:depImageView];
        
        UILabel *depLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(depImageView)+16,
                                                                     viewY(depImageView),
                                                                     150,
                                                                     viewHeight(depImageView))
                                                     text:@"出港(计划/实际)"
                                                     font:18
                                            textAlignment:NSTextAlignmentLeft
                                             colorFromHex:0xFF000000];
        NSMutableAttributedString* attrStrD = [[NSMutableAttributedString alloc] initWithString:@"出港(计划/实际)"];
        [attrStrD addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF000000]
                         range:NSMakeRange(2, 7)];
        [attrStrD addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:27/2]
                         range:NSMakeRange(2, 7)];
        depLabel.attributedText = attrStrD;
        [self addSubview:depLabel];


        depValueLabel =[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, viewY(depImageView), kScreenWidth/2-20, 20)
                                                         text:[NSString stringWithFormat:@"%d/%d",_passengerModel.planOutCount,_passengerModel.realOutCount]
                                                         font:36/2
                                                textAlignment:NSTextAlignmentRight
                                                 colorFromHex:0xFF000000];
        [self addSubview:depValueLabel];

        UIButton * depValueButton = [[UIButton alloc]initWithFrame:CGRectMake(viewX(arrValueLabel),
                                                                              viewY(arrImageView),
                                                                              viewWidth(arrValueLabel),
                                                                              viewBotton(depValueLabel)-viewY(arrValueLabel))];
        [depValueButton addTarget:self
                           action:@selector(showPassengerHourView:)
                 forControlEvents:UIControlEventTouchUpInside];
//        depValueButton.backgroundColor = [UIColor redColor];
        [self addSubview:depValueButton];

        UIImageView *deplineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(arrLabel),
                                                                                     viewBotton(depLabel)+21,
                                                                                     viewWidth(self)-viewX(arrLabel)-20,
                                                                                     0.5)];
        deplineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:deplineImageView];

        DMZPeopleLabel = [CommonFunction addLabelFrame:CGRectMake(20,
                                                                           viewBotton(deplineImageView),
                                                                           kScreenWidth-40,
                                                                           viewHeight(self)- viewBotton(deplineImageView))
                                                           text:[NSString stringWithFormat:@"隔离区%@人",@(_passengerModel.safeCount)]
                                                           font:33/2
                                                  textAlignment:NSTextAlignmentCenter
                                                   colorFromHex:0xFF17B9E8];
        [self addSubview:DMZPeopleLabel];
        UIImageView *DMZNumBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake((viewWidth(self)-199)/2,
                                                                                              (viewHeight(self)-viewBotton(deplineImageView)-42)/2+viewBotton(deplineImageView),
                                                                                              199,
                                                                                              42)];
        DMZNumBackgroundImageView.image = [UIImage imageNamed:@"DMZNumBackground"];
        [self addSubview:DMZNumBackgroundImageView];
        UIButton *DMZNumButton = [[UIButton alloc] initWithFrame:DMZNumBackgroundImageView.frame];
        [DMZNumButton addTarget:self
                         action:@selector(showSafetyPassenger:)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:DMZNumButton];

        
//        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+30+90, kScreenWidth/2-20, 20) text:@"1568人" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000]];


    }
    
    return self;
}

-(void)showPassengerHourView:(NSNotification *)sender
{
    if([CommonFunction hasFunction:OV_PASSENGER_HOUR]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showPassengerHourView"
                                                            object:nil];
    }
}

-(void)showSafetyPassenger:(NSNotification *)sender
{
    if ([CommonFunction hasFunction:OV_PASSENGER_SAFTY]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showSafetyPassenger"
                                                            object:nil];
    }
}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[PassengerModel class]]) {
        _passengerModel = notification.object;
        arrPsn.text = @(_passengerModel.hourInCount).stringValue;
        depPsn.text = @(_passengerModel.hourOutCount).stringValue;
        maxLabel.text = @((int)([self maxValue]*1.2)).stringValue;
        CGPoint centerPoint = arrPlan.center;
        arrPlan = [[ProgreesBarView alloc] initWithCenter:CGPointMake(centerPoint.x,
                                                                      centerPoint.y)
                                                     size:CGSizeMake(15, arrBarView.frame.size.height)
                                                direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF9BEEDA].CGColor,
                                                                     (__bridge id)[CommonFunction colorFromHex:0XFF94E1EB].CGColor ]
                                               proportion:_passengerModel.planInCount/([self maxValue]*1.2)];

        arrReal = [[ProgreesBarView alloc] initWithCenter:CGPointMake(arrBarView.frame.size.width*3/4,
                                                                      arrBarView.frame.size.height/2)
                                                     size:CGSizeMake(15, arrBarView.frame.size.height)
                                                direction:4
                                                   colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF4A9EB8].CGColor,
                                                            (__bridge id)[CommonFunction colorFromHex:0XFF4991CB].CGColor ]
                                               proportion:_passengerModel.realInCount/([self maxValue]*1.2)];

        depPlan = [[ProgreesBarView alloc] initWithCenter:CGPointMake(depBarView.frame.size.width/4,
                                                                      depBarView.frame.size.height/2)
                                                     size:CGSizeMake(15, depBarView.frame.size.height)
                                                direction:4
                                                   colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF9BEEDA].CGColor,
                                                            (__bridge id)[CommonFunction colorFromHex:0XFF94E1EB].CGColor ]
                                               proportion:_passengerModel.planOutCount/([self maxValue]*1.2)];
        depReal = [[ProgreesBarView alloc] initWithCenter:CGPointMake(depBarView.frame.size.width*3/4,
                                                                      depBarView.frame.size.height/2)
                                                     size:CGSizeMake(15, depBarView.frame.size.height)
                                                direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFF4A9EB8].CGColor,
                                                                     (__bridge id)[CommonFunction colorFromHex:0XFF4991CB].CGColor ]
                                               proportion:_passengerModel.realOutCount/([self maxValue]*1.2)];

        minLabel.text = @(_passengerModel.minCount).stringValue;

        arrValueLabel.text = [NSString stringWithFormat:@"%d/%d",_passengerModel.planInCount,_passengerModel.realInCount];
        depValueLabel.text = [NSString stringWithFormat:@"%d/%d",_passengerModel.planOutCount,_passengerModel.realOutCount];
        DMZPeopleLabel.text = [NSString stringWithFormat:@"隔离区%@人",@(_passengerModel.safeCount)];
    }
}

-(int)maxValue
{
    int max = 0;

    if (_passengerModel.realOutCount>max) {
        max = _passengerModel.realOutCount;
    }
    if (_passengerModel.planOutCount>max) {
        max = _passengerModel.planOutCount;
    }
    if (_passengerModel.realInCount>max) {
        max = _passengerModel.realInCount;
    }
    if (_passengerModel.planInCount>max) {
        max = _passengerModel.planInCount;
    }
    return max==0?1:max;
}

@end
