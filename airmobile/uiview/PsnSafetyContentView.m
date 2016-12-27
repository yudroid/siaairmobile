//
//  PsnSafetyContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyContentView.h"
#import "ProgreesBarView.h"
#import "FlightHourModel.h"
#import "PsnSafetyContentViewTableViewCell.h"

const NSString *PSNSAFETYCONTEN_TABLEVIEW_IDENTIFER = @"PSNSAFETYCONTEN_TABLEVIEW_IDENTIFER";

@interface PsnSafetyContentView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,copy) NSArray<NSDictionary *> *dataArray;

@end

@implementation PsnSafetyContentView
{
    UIView *topBgView ;
    ProgreesBarView *lqBarProgress;
    ProgreesBarView *eqBarProgress;
    ProgreesBarView *dqBarProgress;

    UILabel *lessTagLabel;
    UILabel *equalTagLabel;
    UILabel *moreTagLabel;

    UILabel *lessLabel;
    UILabel *equalLabel;
    UILabel *moreLabel;

    UILabel *lessValueLabel;
    UILabel *equalValueLabel;
    UILabel *moreValueLabel;

}

-(instancetype)initWithFrame:(CGRect)frame
                   dataArray:(NSArray<NSDictionary *> *)dataArray
{
    self = [super initWithFrame:frame];
    
    if(self){
        _dataArray = dataArray;

        CGFloat topBgViewWidth  = kScreenWidth-2*px2(22);
        topBgView       = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"PsnSafetyChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];
        
        UILabel *passengerTtitle    = [[UILabel alloc] initWithFrame:CGRectMake(px_px_2_3(33, 55),
                                                                                px_px_2_3(13, 21),
                                                                                topBgView.frame.size.width-20,
                                                                                21)];
        passengerTtitle.text        = @"机上等待时间";
        passengerTtitle.font        = [UIFont fontWithName:@"PingFangSC-Regular" size:px_px_2_3(27, 42)];
        passengerTtitle.textColor   = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UIImageView *lineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                   viewBotton(passengerTtitle)+px_px_2_3(51, 79),
                                                                                   viewWidth(topBgView)-viewX(passengerTtitle)-px_px_2_3(33, 55) *2,
                                                                                   0.5)];
        lineImageView.image         = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];

        
        UILabel *maxLabel  = [CommonFunction addLabelFrame:CGRectMake(px_px_2_3(33, 55),
                                                                      viewBotton(lineImageView)+px_px_2_3(9, 15),
                                                                      viewWidth(lineImageView),
                                                                      9)
                                                      text:[NSString stringWithFormat:@"%ld",@([self maxValue] * 1.2).integerValue]
                                                      font:11
                                             textAlignment:NSTextAlignmentRight
                                              colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(px_px_2_3(33, 55),
                                                                       topBgView.frame.size.height-(35+15),
                                                                       topBgView.frame.size.width-px_px_2_3(33, 55)*2,
                                                                       12)
                                                       text:@"0"
                                                       font:11
                                              textAlignment:NSTextAlignmentRight
                                               colorFromHex:0x75FFFFFF]];
        //柱状图
//        
//        lqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/6,
//                                                                                             (60+topBgView.frame.size.height-35)/2)
//                                                                            size:CGSizeMake(15, topBgView.frame.size.height-60-35)
//                                                                       direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
//                                                                                            (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
//                                                                      proportion:((NSNumber *)[dataArray[2] objectForKey:@"ratio"]).floatValue];
//        
//        [topBgView addSubview:lqBarProgress];
//        
//        eqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/2,
//                                                                                             (60+topBgView.frame.size.height-35)/2)
//                                                                            size:CGSizeMake(15, topBgView.frame.size.height-60-35)
//                                                                       direction:4
//                                                                          colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
//                                                                                   (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
//                                                                      proportion:((NSNumber *)[dataArray[2] objectForKey:@"ratio"]).floatValue];
//        
//        [topBgView addSubview:eqBarProgress];
//        
//        dqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width*5/6,
//                                                                                             (60+topBgView.frame.size.height-35)/2)
//                                                                            size:CGSizeMake(15, topBgView.frame.size.height-60-35)
//                                                                       direction:4
//                                                                          colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
//                                                                                   (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
//                                                                      proportion:((NSNumber *)[dataArray[2] objectForKey:@"ratio"]).floatValue];
//        
//        [topBgView addSubview:dqBarProgress];

        for (int i = 0 ;i<dataArray.count ;i++) {
            ProgreesBarView *barProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width*(i+1)/(dataArray.count+1),
                                                                                               (60+topBgView.frame.size.height-35)/2)
                                                                              size:CGSizeMake(15, topBgView.frame.size.height-60-35)
                                                                         direction:4
                                                                            colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
                                                                                     (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
                                                                        proportion:((NSNumber *)[dataArray[i] objectForKey:@"count"]).floatValue/([self maxValue]*1.2)];
            [topBgView addSubview:barProgress];

            UILabel  *tagLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*(i+1)/(dataArray.count+1)-30,
                                                                    topBgView.frame.size.height-35+5,
                                                                    60,
                                                                    15)
                                                    text:[dataArray[i] objectForKey:@"hour"]
                                                    font:20/2
                                           textAlignment:NSTextAlignmentCenter
                                            colorFromHex:0xFFFFFFFF];
            tagLabel.adjustsFontSizeToFitWidth = YES;
            [topBgView addSubview:tagLabel];

        }

        ////////////

        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                      topBgView.frame.size.height-32,
                                                                                      viewWidth(topBgView)-viewX(passengerTtitle)-px_px_2_3(33, 55) *2,
                                                                                      0.5)];
        downlineImageView.image        = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];
        
    

//        lessTagLabel = [CommonFunction addLabelFrame:CGRectMake(20,
//                                                                           topBgView.frame.size.height-35+5,
//                                                                           topBgView.frame.size.width/3-20,
//                                                                           15)
//                                                           text:[dataArray[0] objectForKey:@"hour"]
//                                                           font:29/2
//                                                  textAlignment:NSTextAlignmentCenter
//                                                   colorFromHex:0xFFFFFFFF];
//        [topBgView addSubview:lessTagLabel];
//
//        equalTagLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width/3,
//                                                                          topBgView.frame.size.height-35+5,
//                                                                          topBgView.frame.size.width/3,
//                                                                          29/2)
//                                                 text:[dataArray[1] objectForKey:@"hour"]
//                                                 font:15
//                                                 textAlignment:NSTextAlignmentCenter
//                                                  colorFromHex:0xFFFFFFFF];
//        [topBgView addSubview:equalTagLabel];
//
//        moreTagLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width*2/3,
//                                                                topBgView.frame.size.height-35+5,
//                                                                topBgView.frame.size.width/3-20,
//                                                                29/2)
//                                                text:[dataArray[2] objectForKey:@"hour"]
//                                                font:15
//                                       textAlignment:NSTextAlignmentCenter
//                                        colorFromHex:0xFFFFFFFF];
//
//        [topBgView addSubview:moreTagLabel];



        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(topBgView)+px_px_2_2_3(40, 62, 93), kScreenWidth, viewHeight(self)-viewBotton(topBgView) -8 - 49-40-25) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc]init];
//        tableView.backgroundColor = [UIColor redColor];
        tableView.allowsSelection = NO;
        [self addSubview:tableView];

        [tableView registerNib:[UINib nibWithNibName:@"PsnSafetyContentViewTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)PSNSAFETYCONTEN_TABLEVIEW_IDENTIFER];

//        //less
//        UIImageView *lessImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(54, 89),
//                                                                                  viewBotton(topBgView)+px_px_2_2_3(40, 62, 93),
//                                                                                  19/2,
//                                                                                  37/2)];
//        lessImageView.image = [UIImage imageNamed:@"PsnSafetyLess"];
//        //        arrImageView.backgroundColor = [UIColor redColor];
//        [self addSubview:lessImageView];
//        lessLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(lessImageView)+16,
//                                                                      viewY(lessImageView),
//                                                                      150,
//                                                                      viewHeight(lessImageView))
//                                                      text:[dataArray[0] objectForKey:@"hour"]
//                                                      font:18
//                                             textAlignment:NSTextAlignmentLeft
//                                              colorFromHex:0xFF000000];
//        [self addSubview:lessLabel];
//
//
//        lessValueLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
//                                                                           viewY(lessImageView),
//                                                                           kScreenWidth/2-20,
//                                                                           viewHeight(lessImageView))
//                                                           text:((NSNumber *)[dataArray[0] objectForKey:@"count"]).stringValue
//                                                           font:36/2
//                                                  textAlignment:NSTextAlignmentRight
//                                                   colorFromHex:0xFF000000];
//        [self addSubview:lessValueLabel];
//
//        UIImageView *lesslineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(lessLabel),
//                                                                                      viewBotton(lessLabel)+px_px_2_2_3(30, 42, 63),
//                                                                                      viewWidth(self)-viewX(lessLabel)-20,
//                                                                                      0.5)];
//        lesslineImageView.image         = [UIImage imageNamed:@"Line"];
//        [self addSubview:lesslineImageView];
//
//        //equal
//        UIImageView *equalImageView     = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(54, 89), viewBotton(lesslineImageView)+px_px_2_2_3(30, 42, 63)+7, 32/2,11/2)];
//        equalImageView.image            = [UIImage imageNamed:@"PsnSafetyEqual"];
//        [self addSubview:equalImageView];
//
//        equalLabel             = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(equalImageView)+16,
//                                                                                   viewY(equalImageView)-7,
//                                                                                   150,
//                                                                                   viewHeight(lessImageView))
//                                                                   text:[dataArray[1] objectForKey:@"hour"]
//                                                                   font:18
//                                                          textAlignment:NSTextAlignmentLeft
//                                                           colorFromHex:0xFF000000];
//        [self addSubview:equalLabel];
//
//        equalValueLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
//                                                                   viewY(equalLabel),
//                                                                   kScreenWidth/2-20,
//                                                                   20)
//                                                   text:((NSNumber *)[dataArray[1] objectForKey:@"count"]).stringValue
//                                                   font:36/2
//                                          textAlignment:NSTextAlignmentRight
//                                           colorFromHex:0xFF000000];
//        [self addSubview:equalValueLabel];
//
//        UIImageView *equallineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(equalLabel),
//                                                                                       viewBotton(equalLabel)+px_px_2_2_3(30, 42, 63),
//                                                                                       viewWidth(self)-viewX(equalLabel)-20,
//                                                                                       0.5)];
//        equallineImageView.image        = [UIImage imageNamed:@"Line"];
//        [self addSubview:equallineImageView];
//
//        //more
//
//        UIImageView *moreImageView      = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(54, 89),
//                                                                                       viewBotton(equallineImageView)+px_px_2_2_3(30, 42, 63),
//                                                                                       19/2,
//                                                                                       37/2)];
//        moreImageView.image             = [UIImage imageNamed:@"PsnSafetyMore"];
//        [self addSubview:moreImageView];
//
//        moreLabel              = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(equalImageView)+16,
//                                                                                   viewY(moreImageView),
//                                                                                   150,
//                                                                                   viewHeight(moreImageView))
//                                                                   text:[dataArray[2] objectForKey:@"hour"]
//                                                                   font:18
//                                                          textAlignment:NSTextAlignmentLeft
//                                                           colorFromHex:0xFF000000];
//        [self addSubview:moreLabel];
//
//
//        moreValueLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
//                                                                  viewY(moreImageView),
//                                                                  kScreenWidth/2-20, 20)
//                                                  text:((NSNumber *)[dataArray[2] objectForKey:@"count"] ).stringValue
//                                                  font:36/2
//                                         textAlignment:NSTextAlignmentRight
//                                          colorFromHex:0xFF000000];
//        [self addSubview:moreValueLabel];
//
//        UIImageView *morelineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(moreLabel),
//                                                                                      viewBotton(moreImageView)+px_px_2_2_3(30, 42, 63),
//                                                                                      viewWidth(self)-viewX(moreImageView)-20,
//                                                                                      0.5)];
//        morelineImageView.image         = [UIImage imageNamed:@"Line"];
//        [self addSubview:morelineImageView];
//

        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(20,
                                                                  viewBotton(tableView),
                                                                  kScreenWidth-40,
                                                                  viewHeight(self)- viewBotton(tableView))
                                                  text:[NSString stringWithFormat:@"高峰旅客日排名"]
                                                  font:33/2 textAlignment:NSTextAlignmentCenter
                                          colorFromHex:0xFF17B9E8]];

        UIImageView *DMZNumBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake((viewWidth(self)-199)/2,
                                                                                              (viewHeight(self)-viewBotton(tableView)-42)/2+viewBotton(tableView),
                                                                                              199,
                                                                                              42)];
        DMZNumBackgroundImageView.image = [UIImage imageNamed:@"DMZNumBackground"];
        [self addSubview:DMZNumBackgroundImageView];

        UIButton *DMZNumButton = [[UIButton alloc] initWithFrame:DMZNumBackgroundImageView.frame];
        [DMZNumButton addTarget:self
                         action:@selector(showTop5DaysView:)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:DMZNumButton];


        
        //[self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 200+30+30+10+30+10+90, kScreenWidth/2-20, 20) text:@"" font:25 textAlignment:NSTextAlignmentLeft colorFromHex:0xFF000000]];
        
    }
    
    return self;
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PsnSafetyContentViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)PSNSAFETYCONTEN_TABLEVIEW_IDENTIFER];
    cell.content = _dataArray[indexPath.row];
    if (indexPath.row == _dataArray.count-1) {
        cell.headImageView.image = [UIImage imageNamed:@"PsnSafetyMore"];
    }else if (indexPath.row == 0){
        cell.headImageView.image = [UIImage imageNamed:@"PsnSafetyLess"];
    }else{
        cell.headImageView.image = [UIImage imageNamed:@"PsnSafetyEqual"];
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        _dataArray = notification.object;

        lqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/6,
                                                                            (60+topBgView.frame.size.height-35)/2)
                                                           size:CGSizeMake(15, topBgView.frame.size.height-60-35)
                                                      direction:4 colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
                                                                           (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
                                                     proportion:((NSNumber *)[_dataArray[2] objectForKey:@"ratio"]).floatValue];

        eqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width/2,
                                                                            (60+topBgView.frame.size.height-35)/2)
                                                           size:CGSizeMake(15, topBgView.frame.size.height-60-35)
                                                      direction:4
                                                         colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
                                                                  (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
                                                     proportion:((NSNumber *)[_dataArray[2] objectForKey:@"ratio"]).floatValue];

        dqBarProgress = [[ProgreesBarView alloc] initWithCenter:CGPointMake(topBgView.frame.size.width*5/6,
                                                                            (60+topBgView.frame.size.height-35)/2)
                                                           size:CGSizeMake(15, topBgView.frame.size.height-60-35)
                                                      direction:4
                                                         colors:@[(__bridge id)[CommonFunction colorFromHex:0XFFFDD4C3].CGColor,
                                                                  (__bridge id)[CommonFunction colorFromHex:0XFFFDC4D5].CGColor ]
                                                     proportion:((NSNumber *)[_dataArray[2] objectForKey:@"ratio"]).floatValue];

        lessTagLabel.text   = [_dataArray[0] objectForKey:@"hour"];
        equalTagLabel.text  = [_dataArray[1] objectForKey:@"hour"];
        moreTagLabel.text   = [_dataArray[2] objectForKey:@"hour"];
        lessLabel.text      = [_dataArray[0] objectForKey:@"hour"];
        equalLabel.text     = [_dataArray[1] objectForKey:@"hour"];
        moreLabel.text      = [_dataArray[2] objectForKey:@"hour"];
        lessValueLabel.text = [_dataArray[0] objectForKey:@"count"];
        equalValueLabel.text= [_dataArray[1] objectForKey:@"count"];
        moreValueLabel.text = [_dataArray[2] objectForKey:@"count"];

    }
}

-(void)showTop5DaysView:(NSNotification *)sender
{
    if([CommonFunction hasFunction:OV_PASSENGER_TOPFIVE]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showTop5DaysView"
                                                            object:nil];
    }

}

-(CGFloat)maxValue
{
    float maxValue = 0;
    for (NSDictionary *dic in _dataArray) {
        if (((NSNumber *)[dic objectForKey:@"count"]).floatValue>maxValue) {
            maxValue = ((NSNumber *)[dic objectForKey:@"count"]).floatValue;
        }

    }
    return maxValue==0?1:maxValue;
}



@end
