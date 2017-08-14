//
//  FlightViewController.m
//  KaiYa
//
//  Created by VIPUI_CC on 16/2/16.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "FlightSearchViewController.h"
#import "CityViewController.h"
#import "CalendarViewController.h"
#import "DateUtils.h"
#import "StringUtils.h"
#import "AirlineViewController.h"
#import "AirlineModel.h"
//#import "FlightConcernListViewController.h"
//#import "HttpUtils+BusinessHttpUtils.h"

//数字和字母
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface FlightSearchViewController ()<UITextFieldDelegate>

@end

@implementation FlightSearchViewController{
    UIButton    *airlineButton;
    UILabel     *airlineLabel;
    UIButton *airlineCancelButton ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.outCity = [[Airport alloc]initCn:@"深圳" iata:@"SZX" region:@"" first:@""];
    self.arriveCity = [[Airport alloc]initCn:@"北京" iata:@"PEK" region:@"" first:@""];
    _queryflag = true;
    
    //创建按航班号查询还是城市查询View
    [self createClassView];
    //创建查询条件View
    [self createSeekQualificationView];
    //创建日期View
    [self createSeekDateView];
    //创建查询Button
    [self createSeekButton];
    //titleView订制
    [self titleViewInit];

    [self createAirlineView];



    
}
//创建按航班号查询还是城市查询View
- (void)createClassView{

    NSArray *segmentedArray = @[@"按航班号",@"按城市名",@"按机号",@"按机位"];
    //初始化UISegmentedControl
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    _segmentedControl.frame = CGRectMake(34, 30 + 64, kScreenWidth - 34 *  2, 31);
    _segmentedControl.tintColor = [CommonFunction colorFromHex:0xff17B9E8];
    [_segmentedControl addTarget: self  action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segmentedControl];
}
//创建航空公司查询视图
-(void)createAirlineView{

    airlineLabel =[self AddLabelViewWithFrame:CGRectMake(34, 94+30+80+67 + 60, 100, 20)text:@"航空公司" font:12 isCity:NO];

    airlineButton = [[UIButton alloc]initWithFrame:CGRectMake(34,viewBotton(airlineLabel)+8, kScreenWidth - 34*2-50, 40)];
    airlineButton.titleLabel.font = [UIFont systemFontOfSize: 18];
    [airlineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [airlineButton setTitle:@"请选择航空公司" forState:UIControlStateNormal];
    [self.view addSubview:airlineButton];
    airlineButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [airlineButton addTarget:self action:@selector(airlineButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    airlineCancelButton = [[UIButton alloc]initWithFrame:CGRectMake(viewTrailing(airlineButton), viewY(airlineButton), 40, 40)];
    [airlineCancelButton setImage:[UIImage imageNamed:@"airline_clear"] forState:UIControlStateNormal];
    [airlineCancelButton addTarget:self action:@selector(airlineCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:airlineCancelButton];
}

-(void)airlineButtonClick:(UIButton *)sender
{
    AirlineViewController * airlineVC = [[AirlineViewController alloc]init];
    airlineVC.resetCity = ^(AirlineModel *model){
        self.airlineModel = model;
    };
    [self.navigationController pushViewController:airlineVC animated:YES];
    
}
-(void)airlineCancelButtonClick:(UIButton *)sender
{
    _airlineModel = nil;
    [airlineButton setTitle:@"请选择航空公司" forState:UIControlStateNormal];

}

-(void)setAirlineModel:(AirlineModel *)airlineModel
{
    _airlineModel = airlineModel;
    [airlineButton setTitle:airlineModel.nameChn forState:UIControlStateNormal];
}
- (void)clear{
    _arriveCityButton.hidden = YES;
    _outCityButton.hidden = YES;
    _arriveCityLabel.hidden = YES;
    _flightNumberTextF.hidden = YES;
    _flightImg.hidden = YES;
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)segmentedControl
{
    [self clear];
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            _outCityLabel.text = @"航班号";
            _flightNumberTextF.placeholder = @"请输入航班号";
            _flightNumberTextF.hidden = NO;
            _queryflag = FlightSearchTypeFlightNo;
            airlineLabel.hidden = NO;
            airlineButton.hidden = NO;
            airlineCancelButton.hidden = NO;
            break;
        }
        case 1:
        {
            _outCityLabel.hidden = NO;
            _outCityLabel.text = @"出发城市";
            _outCityButton.hidden = NO;
            _arriveCityLabel.hidden = NO;
            _arriveCityButton.hidden = NO;
            _flightImg.hidden = NO;
            _queryflag = FlightSearchTypeCity;
            airlineLabel.hidden = YES;
            airlineButton.hidden = YES;
            airlineCancelButton.hidden = YES;
            break;
        }
        case 2:
        {
            _outCityLabel.hidden = NO;
            _outCityLabel.text = @"机号";
            _outCityButton.hidden = YES;
            _arriveCityLabel.hidden = YES;
            _arriveCityButton.hidden = YES;
            _flightImg.hidden = YES;
            _queryflag = FlightSearchTypePlaneNo;
            airlineLabel.hidden = YES;
            airlineButton.hidden = YES;
            airlineCancelButton.hidden = YES;
            _flightNumberTextF.hidden = NO;
            _flightNumberTextF.placeholder = @"请输入机号";
            break;
        }
        case 3:
        {
            _outCityLabel.hidden = NO;
            _outCityLabel.text = @"机位";
            _outCityButton.hidden = YES;
            _arriveCityLabel.hidden = YES;
            _arriveCityButton.hidden = YES;
            _flightImg.hidden = YES;
            _queryflag = FlightSearchTypeSeat;
            airlineLabel.hidden = YES;
            airlineButton.hidden = YES;
            airlineCancelButton.hidden = YES;
            _flightNumberTextF.hidden = NO;
            _flightNumberTextF.placeholder = @"请输入机位";
            break;
        }
        default:
            break;
    }
}

//创建查询条件View
- (void)createSeekQualificationView{
    _outCityLabel = [self AddLabelViewWithFrame:CGRectMake(34, 94+31+24,( kScreenWidth - 34*2)/2, 35-24) text:@"航班号" font:12 isCity:NO];
    _arriveCityLabel = [self AddLabelViewWithFrame:CGRectMake(34 + ( kScreenWidth - 34*2)/2, 94+31+24,( kScreenWidth - 34*2)/2, 35-24) text:@"到达城市" font:12 isCity:YES];
    
    _flightNumberTextF = [[UITextField alloc]initWithFrame:CGRectMake(34, 94+31+35+5, kScreenWidth - 34*2, 40)];
    _flightNumberTextF.font = [UIFont systemFontOfSize: 18];
    _flightNumberTextF.placeholder = @"请输入航班号";
    _flightNumberTextF.delegate = self;
    _flightNumberTextF.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [self.view addSubview:_flightNumberTextF];
    
    _outCityButton = [self AddButtonViewWithFrame:CGRectMake(34, 94+31+35, ( kScreenWidth - 34*2 - 60)/2, 45) text:_outCity.cn?:@"" isCity:NO];
    _arriveCityButton = [self AddButtonViewWithFrame:CGRectMake(34 + ( kScreenWidth - 34*2 )/2 +30, 94+31+35, ( kScreenWidth - 34*2)/2 - 30, 45) text:_arriveCity.cn?: @"" isCity:YES];

    [self AddLineViewFrame:CGRectMake(34, 94+31+81, kScreenWidth - 34*2, 1)];

    _flightImg = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 34-30+4)/2, 94+31+35+5, 45, 45)];
    //小飞机图
    [_flightImg setImage:[UIImage imageNamed:@"flight_arrow"] forState:(UIControlStateNormal)];
    _flightImg.backgroundColor = [UIColor whiteColor];
    _flightImg.hidden = YES;
    [_flightImg addTarget:self action:@selector(flightImgButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_flightImg];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if([string isEqualToString:@""]){
        return YES;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return _flightNumberTextF.text.length>8?NO: canChange;
}

/**
 *  @author yangql, 16-02-25 18:02:47
 *  小飞机点击事件
 *  @brief 交换进出港航站顺序
 */
- (void)flightImgButtonClick
{
    Airport *temp = self.outCity;
    self.outCity = self.arriveCity;
    self.arriveCity = temp;
    [_outCityButton setTitle:self.outCity.cn forState:(UIControlStateNormal)];
    [_arriveCityButton setTitle:self.arriveCity.cn forState:(UIControlStateNormal)];
}

//创建日期View
- (void)createSeekDateView{
    [self AddLabelViewWithFrame:CGRectMake(34, 94+31+81+13, kScreenWidth - 34*2, 25-13) text:@"日期" font:12 isCity:NO];
    _dateLabel = [self AddLabelViewWithFrame:CGRectMake(34, 94+31+81+25, 130, 41) text:@"" font:15 isCity:NO];
    
    NSDate *date = [DateUtils getNow];
    _fltDate = [DateUtils convertToString:date format:@"yyyy-MM-dd"];
//    NSInteger day = [[DateUtils convertToString:date format:@"dd"] integerValue];
//    NSInteger month = [[DateUtils convertToString:date format:@"MM"] integerValue];
//    _dateLabel.attributedText = [self stringChangeAttributedString:month day:day];
    _dateLabel.attributedText = [self stringChangeAttributedString:[DateUtils convertToString:date format:@"MM"] day:[DateUtils convertToString:date format:@"dd"]];
    
    //34+65+40
    UIButton *chooseDateButton = [[UIButton alloc]initWithFrame:CGRectMake(34,94+34+81+25, 200, 41)];
    [chooseDateButton setImage:[UIImage imageNamed:@"btn_arrow"] forState:(UIControlStateNormal)];
    [chooseDateButton addTarget:self action:@selector(chooseDateButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    //[chooseDateButton setBackgroundColor:[CommonFunction colorFromHex:0XFFFF0000]];
    [self.view addSubview:chooseDateButton];
    
    [self AddLineViewFrame:CGRectMake(34, 94+31+81+67, kScreenWidth - 34*2, 1)];
}

/**
 *  @author yangql, 16-02-25 18:02:53
 *
 *  @brief 日期点击事件
 */
- (void)chooseDateButtonClick{
//    NSLog(@"%s",__func__);
    CalendarViewController *calVC = [[CalendarViewController alloc]init];
    calVC.resetDate = ^(NSDate *date){
//        NSInteger day = [[DateUtils convertToString:date format:@"dd"] integerValue];
//        NSInteger month = [[DateUtils convertToString:date format:@"MM"] integerValue];
//        _dateLabel.attributedText = [self stringChangeAttributedString:month day:day];
        _fltDate = [DateUtils convertToString:date format:@"yyyy-MM-dd"];
        _dateLabel.attributedText = [self stringChangeAttributedString:[DateUtils convertToString:date format:@"MM"] day:[DateUtils convertToString:date format:@"dd"]];

//        NSLog(@"当前选中日期%@",_fltDate);
    };
    [self.navigationController pushViewController:calVC animated:true];
}

//创建查询Button
- (void)createSeekButton{
    _seekButton = [[UIButton alloc]initWithFrame:CGRectMake(34, 94+30+80+67+100 + 60, kScreenWidth - 34*2, 36)];
    _seekButton.layer.cornerRadius = 5.0;
    _seekButton.backgroundColor  = [CommonFunction colorFromHex:0xff17B9E8];
    [_seekButton setTitle:@"查询" forState:UIControlStateNormal];
    [_seekButton addTarget:self action:@selector(seekButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_seekButton];
}

/**
 *  @author yangql, 16-02-25 18:02:36
 *
 *  @brief 查询按钮进行查询操作
 */
- (void)seekButtonClick{
//    NSLog(@"%s",__func__);
//    FlightConcernListViewController *flightConcernDetailVC = [[FlightConcernListViewController alloc]init];
//    flightConcernDetailVC.date = _fltDate;
//    if(_segmentedControl.selectedSegmentIndex == 0){
//        flightConcernDetailVC.type = UMEFlightStatusSearchTypeFlightNo;
//        flightConcernDetailVC.flightNo = _flightNumberTextF.text;
//    }else{
//        flightConcernDetailVC.type = UMEFlightStatusSearchTypeFlightCity;
//        flightConcernDetailVC.starCityCode = self.outCity.iata;
//        flightConcernDetailVC.endCityCode = self.arriveCity.iata;
//    }
//    [self.navigationController pushViewController:flightConcernDetailVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  @author yangql, 16-02-25 13:02:04
 *
 *  @brief 修改增加回调方法
 *
 *  @param button <#button description#>
 */
- (void)changeSeekCityClick:(UIButton *)button{

    // 判断是否本站位置，如果是，不能修改，只能点击图片进行切换

    if(button.tag == 1 && [self.arriveCity.cn isEqualToString:@"深圳"]){
        return;
    }else if(button.tag == 0 && [self.outCity.cn isEqualToString:@"深圳"]){
        return;
    }


    CityViewController *cityVC = [[CityViewController alloc]init];
    if (button == _outCityButton) {
        cityVC.titleStr = @"出发城市";
    }else{
        cityVC.titleStr = @"到达城市";
    }
    // 回调方法
    cityVC.resetCity = ^(Airport *airport){
        [button setTitle:airport.cn forState:UIControlStateNormal];
        if(button.tag == 1){
            self.arriveCity = airport;
        }else{
            self.outCity = airport;
        }
//        NSLog(@"起飞航站：%@ 到达航站:%@",self.outCity.cn,self.arriveCity.cn);
    };
    [self.navigationController pushViewController:cityVC animated:YES];


}
- (void)AddLineViewFrame:(CGRect)rect{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [CommonFunction colorFromHex:0XFFE6E6E6];
    lineView.frame = rect;
    [self.view addSubview:lineView];
}

- (UILabel *)AddLabelViewWithFrame:(CGRect)rect text:(NSString *)text font:(NSInteger)font isCity:(BOOL)isCity{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:rect];
    titleLabel.text = text;
    if (isCity) {
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.hidden = YES;
    }else{
        titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    titleLabel.font = [UIFont systemFontOfSize:font];
    titleLabel.textColor = [CommonFunction colorFromHex:0XFF1B1B1B];
    [self.view addSubview:titleLabel];
    
    return titleLabel;
}
- (UIButton *)AddButtonViewWithFrame:(CGRect)rect text:(NSString *)text  isCity:(BOOL)isCity{
    
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [button setTitle:text forState:(UIControlStateNormal)];
    if (isCity) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    }else{
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.hidden = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:24];
    [button setTitleColor:[CommonFunction colorFromHex:0XFF1B1B1B] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeSeekCityClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    // 标记该button的类型 0 起飞站 1 到达站
    [button setTag:isCity?1:0];
    
    return button;
}

- (NSMutableAttributedString *)stringChangeAttributedString:(NSString *)month day:(NSString *)day{
    NSMutableAttributedString *attrStr =[[ NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@月%@日",month,day]];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 2)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(3, 2)];
    return attrStr;
}

- (void)titleViewInit{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"航班查询"];
}



@end
