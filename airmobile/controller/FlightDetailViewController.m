//
//  FlightDetailViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailViewController.h"
#import "FlightDetailTableViewCell.h"
#import "AbnormalityReportViewController.h"
#import "FlightDetailSpecialTableViewCell.h"
#import "FlightDetailAirLineCollectionViewCell.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "FlightDetailModel.h"
#import "SafeguardModel.h"
#import "SpecialModel.h"
#import "AppDelegate.h"
#import "ConcernModel.h"
#import "DateUtils.h"
#import "FlightDetailHeaderFooterView.h"

static const NSString *FLIGHTDETAIL_TABLECELL_IDENTIFIER = @"FLIGHTDETAIL_TABLECELL_IDENTIFIER";
static const NSString *FLIGHTDETAIL_TABLEHEADER_IDENTIFIER = @"FLIGHTDETAIL_TABLEHEADER_IDENTIFIER";
static const NSString *FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER = @"FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER";
static const NSString * FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER = @"FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER";


@interface FlightDetailViewController ()<UITableViewDataSource,
                                        UITableViewDelegate,
                                        FlightDetailTableViewCellDelegate,
                                        UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout,
                                        FlightDetailHeaderFooterViewDelegate,
                                        FlightDetailSpecialTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet    UITableView         *safeguardTableView;//特殊保障 tableview
@property (weak, nonatomic) IBOutlet    UICollectionView    *AirlineCollectionView;

@property (nonatomic, copy) NSArray     *airLineCollectionArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeguardTableViewHeight;
@property (weak, nonatomic) IBOutlet UIView *airlineView;
@property (weak, nonatomic) IBOutlet UILabel *inFNumLabel;//进港航班号
@property (weak, nonatomic) IBOutlet UILabel *arrStateLabel;//进港状态
@property (weak, nonatomic) IBOutlet UILabel *arrAirLineLabel;//进港航线

@property (weak, nonatomic) IBOutlet UILabel *arrDateLabel;//进港航班日期
@property (weak, nonatomic) IBOutlet UILabel *terminalLabel;//候机楼

@property (weak, nonatomic) IBOutlet UILabel *arrSeatLabel;//进港机位
@property (weak, nonatomic) IBOutlet UILabel *arrRegionLabel;//进港属性

@property (weak, nonatomic) IBOutlet UILabel *arrModelLabel;//机型
@property (weak, nonatomic) IBOutlet UILabel *arrBaggageLabel;
@property (weak, nonatomic) IBOutlet UILabel *preorderNumLabel;//前序航班
@property (weak, nonatomic) IBOutlet UILabel *arrPersonLabel;

@property (weak, nonatomic) IBOutlet UILabel *aboveTakeoffPlanLabel;//前方起飞  计划
@property (weak, nonatomic) IBOutlet UILabel *aboveTakeoffExpLabel;//前方起飞  预计
@property (weak, nonatomic) IBOutlet UILabel *aboveTakeoffReal;//前方起飞  实际
@property (weak, nonatomic) IBOutlet UILabel *thisArrivePlanLabel;//本站到达 计划
@property (weak, nonatomic) IBOutlet UILabel *thisArriveExpLabel;//本站到达 预计
@property (weak, nonatomic) IBOutlet UILabel *thisArriveReal;//本站到达 实际
@property (weak, nonatomic) IBOutlet UILabel *depStateLabel;//出港状态
@property (weak, nonatomic) IBOutlet UILabel *depAirLineLabel;//出港航线
@property (weak, nonatomic) IBOutlet UILabel *outFNumLabel;//出港航班号
@property (weak, nonatomic) IBOutlet UILabel *depDateLabel;//出港航班日期
@property (weak, nonatomic) IBOutlet UILabel *depTerminalLabel;//候机楼
@property (weak, nonatomic) IBOutlet UILabel *depSeatLabel;//出港机型
@property (weak, nonatomic) IBOutlet UILabel *depGateLabel;//出港登机口
@property (weak, nonatomic) IBOutlet UILabel *checkCounterLabel;//值机柜台
@property (weak, nonatomic) IBOutlet UILabel *depPersonLabel;//出港人数
@property (weak, nonatomic) IBOutlet UILabel *removeGearDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *thisTakeoffPlanLabel;//本站起飞  计划
@property (weak, nonatomic) IBOutlet UILabel *thisTakeoffExpLabel;//本站起飞  预计
@property (weak, nonatomic) IBOutlet UILabel *thisTakeoffRealLabel;//本站起飞  实际
@property (weak, nonatomic) IBOutlet UILabel *afterArrivePlanLabel;//下站到达 计划
@property (weak, nonatomic) IBOutlet UILabel *afterArriveExpLabel;//下站到达 预计
@property (weak, nonatomic) IBOutlet UILabel *afterArriveRealLabel;//下站到达 实际

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrFlightDetailViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *depFlightDetailViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *flightDetailViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *airlineViewHeight;

@property (weak, nonatomic) IBOutlet UIView *arrFlightDetailView;

@property (weak, nonatomic) IBOutlet UIView *depFlightDetailView;


@end

@implementation FlightDetailViewController
{
    FlightDetailModel *flight;
    NSMutableArray<SafeguardModel *> *dispatches;
    NSMutableArray<SpecialModel *> *specicals;
    NSArray *tableArray;

//    NSString *DispatchType;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    flight = [[FlightDetailModel alloc]init];
    specicals = [NSMutableArray array];
    dispatches = [NSMutableArray array];

    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:_flightNo];
    [self titleViewAddBackBtn];
    UIButton *tagButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-30, 27, 40, 30)];
    tagButton.titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size:13];
    if (![ConcernModel isconcern:self.flightNo]) {
//        [tagButton setImage:[UIImage imageNamed:@"Concern1"] forState:UIControlStateNormal];
        [tagButton setTitle:@"关注" forState:UIControlStateNormal];
        tagButton.tag = 1;
    }else{
//        [tagButton setImage:[UIImage imageNamed:@"Concern2"] forState:UIControlStateNormal];
        [tagButton setTitle:@"已关注" forState:UIControlStateNormal];
        tagButton.tag = 2;
    }

    [tagButton addTarget: self action:@selector(concernButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:tagButton];

    
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];

    // 航班特殊保障详情相关
    _safeguardTableView.dataSource      = self;
    _safeguardTableView.delegate        = self;
    _safeguardTableView.allowsSelection = NO;
    
    _AirlineCollectionView.delegate     = self;
    _AirlineCollectionView.dataSource   = self;


    [_AirlineCollectionView registerNib:[UINib nibWithNibName:@"FlightDetailAirLineCollectionViewCell"
                                                       bundle:nil]
             forCellWithReuseIdentifier:(NSString *)FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER];

//    [_tableView registerNib:[UINib nibWithNibName:@"FlightDetailHeaderFooterView" bundle:nil] forCellReuseIdentifier:(NSString *)FLIGHTDETAIL_TABLEHEADER_IDENTIFIER];

    _safeguardTableViewHeight.constant = 103 * tableArray.count +37;
   // [self basicInfo];
    [self loadData];

    
}
-(void)viewDidAppear:(BOOL)animated{
    [_safeguardTableView reloadData];
}


-(void)concernButtonClick:(UIButton *)sender
{
    if (sender.tag == 1) {
        [ConcernModel addConcernModel:self.flightNo];
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform =  CGAffineTransformMakeScale(0.5, 0.5);
//            [sender setImage:[UIImage imageNamed:@"Concern2"] forState:UIControlStateNormal];
            [sender setTitle:@"已关注" forState:UIControlStateNormal];
            sender.tag = 2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                sender.transform = CGAffineTransformScale(sender.transform, 2, 2);
            }];
        }];
    }else{
        [ConcernModel removeConcernModel: self.flightNo];
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform =  CGAffineTransformMakeScale(0.5, 0.5);
//            [sender setImage:[UIImage imageNamed:@"Concern1"] forState:UIControlStateNormal];
            [sender setTitle:@"关注" forState:UIControlStateNormal];
            sender.tag = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                sender.transform = CGAffineTransformScale(sender.transform, 2, 2);
            }];
        }];
    }
}

-(void)updateSpecialsTableView
{
    if (![CommonFunction hasFunction:FL_SPETIAL]) {
        return;
    }
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (id model in specicals) {
        [mutableArray addObject:model];
    }
    for (id model in dispatches) {
        [mutableArray addObject:model];
    }
    tableArray = [mutableArray copy];
    _safeguardTableViewHeight.constant = 103 * (tableArray.count) +37;

    [_safeguardTableView reloadData];

}


-(void)setFlightType:(FlightType)flightType{
    _flightType = flightType;
    switch (flightType) {
        case FlightTypeIn:
            _depFlightDetailViewHeight.constant = 0;
            _depFlightDetailView.hidden = YES;
            _airlineViewHeight.constant = 0;
            _airlineView.hidden = YES;
            _arrFlightDetailViewHeight.constant = 330;
            _flightDetailViewHeight.constant = 330;
            break;
        case FlightTypeOut:
            _arrFlightDetailViewHeight.constant = 0;
            _flightDetailViewHeight.constant = 330;
            _arrFlightDetailView.hidden = YES;
            break;
        case FlightTypeInOut:
            
        default:
            break;
    }
}

-(void)basicInfo
{

    [self setFlightType:_flightType];
    _inFNumLabel.text       = [[flight.fNum componentsSeparatedByString:@"/"] firstObject];
    _arrStateLabel.text     = flight.arrState;
    _arrAirLineLabel.text   =[NSString stringWithFormat:@"%@-SZX",[[flight.airLine componentsSeparatedByString:@"-SZX"] firstObject]];

    _arrDateLabel.text      = flight.arrDate;
    _terminalLabel.text     = flight.terminal;

    _arrSeatLabel.text      = flight.arrSeat;
    _arrRegionLabel.text    = flight.arrRegion;

    _arrModelLabel.text     = flight.model;
    _arrBaggageLabel.text   = flight.baggage;
    _preorderNumLabel.text  = flight.preorderNum;
    _arrPersonLabel.text    = flight.arrPerson;

    _aboveTakeoffPlanLabel.text     =[self timeStringConvert: flight.aboveTakeoffPlan];
    _aboveTakeoffExpLabel.text      =[self timeStringConvert: flight.aboveTakeoffExp];
    _aboveTakeoffReal.text          =[self timeStringConvert: flight.aboveTakeoffReal];
    _thisArrivePlanLabel.text       =[self timeStringConvert: flight.thisArrivePlan];
    _thisArriveExpLabel.text        =[self timeStringConvert: flight.thisArriveExp];
    _thisArriveReal.text            = [self timeStringConvert: flight.thisArriveReal];


    _depStateLabel.text     = flight.depState;
    _depAirLineLabel.text   = [NSString stringWithFormat:@"SZX-%@",[[flight.airLine componentsSeparatedByString:@"SZX-"] lastObject]];
    _outFNumLabel.text      = [[flight.fNum componentsSeparatedByString:@"/"] lastObject];
    _depDateLabel.text      = flight.depDate;
    _depTerminalLabel.text  = flight.terminal;
    _depSeatLabel.text      = flight.depSeat;
    _depGateLabel.text      = flight.gate;
    _checkCounterLabel.text = flight.checkCounter;
    _depPersonLabel.text    = flight.depPerson;
    _removeGearDateLabel.text   =[self timeStringConvert:flight.removeGearDate];
    _thisTakeoffPlanLabel.text  =[self timeStringConvert: flight.thisTakeoffPlan];
    _thisTakeoffExpLabel.text   =[self timeStringConvert: flight.thisTakeoffExp];
    _thisTakeoffRealLabel.text  =[self timeStringConvert: flight.thisTakeoffReal];
    _afterArrivePlanLabel.text  =[self timeStringConvert: flight.afterArrivePlan];
    _afterArriveExpLabel.text   =[self timeStringConvert: flight.afterArriveExp];
    _afterArriveRealLabel.text  =[self timeStringConvert: flight.afterArriveReal];



    _airLineCollectionArray = [flight.airLine componentsSeparatedByString:@"-"];

//    if ([_airLineCollectionArray[0] isEqualToString:@"SZX"]) {
//        DispatchType = @"始发保障";
//    }else if([_airLineCollectionArray[_airLineCollectionArray.count-1] isEqualToString:@"SZX"]){
//        DispatchType = @"过站保障";
//    }else{
//        DispatchType = @"航后保障";
//    }
    [_AirlineCollectionView reloadData];

}

-(NSString *)timeStringConvert:(NSString *)string
{
   NSDate *date = [DateUtils convertToDate:string format:@"yyyy-MM-dd HH:mm:ss.0"];

    return [DateUtils convertToString:date format:@"HH:mm"];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FlightDetailHeaderFooterView *headerView = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailHearderFooterView" owner:nil options:nil][0];
    headerView.delegate = self;
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 37);
    headerView.titleLabel.text = @"保障详情";
    headerView.tag = 1;
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    id model = tableArray[indexPath.row];
    if ([model isKindOfClass:[SafeguardModel class]]) {
        FlightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_TABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailTableViewCell"
                                                 owner:nil
                                               options:nil][0];
        }

        cell.safeguardModel = model;
        cell.indexRow = indexPath.row;
        if (indexPath.row == 0) {
            cell.type = FlightDetailTableViewCellTypeTypeFirst;
        }
        if (indexPath.row ==specicals.count-1 ) {
            cell.type = FlightDetailTableViewCellTypeTypeLast;
        }
        cell.delegate = self;
        return  cell;

    }else {  //if([model isKindOfClass:[SpecialModel class]])

        FlightDetailSpecialTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"FlightDetailSpecialTableViewCell" owner:nil options:nil][0];
        }
        cell.delegate = self;
        cell.specialModel = model;
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - FlightDetailTableViewCellDelegate

-(void)flightDetailTableViewCellUsualButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_NORMAL_REPORTABN]) {
        AbnormalityReportViewController *abnormalityReportVC=[[AbnormalityReportViewController alloc] initWithNibName:@"AbnormalityReportViewController" bundle:nil];
        abnormalityReportVC.title = @"异常上报";
        abnormalityReportVC.safefuardModel = tableArray[sender.tag];
        abnormalityReportVC.isSpecial = NO;
        [self.navigationController pushViewController:abnormalityReportVC
                                             animated:YES];
    }

}


-(void)flightDetailTableViewCellnormalButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_NORMAL_REPORTABN]) {
//       [HttpsUtils http]

        //正常上报接口
    }

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _airLineCollectionArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-54)/_airLineCollectionArray.count,
                      collectionView.frame.size.height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlightDetailAirLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER
                                                                                            forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.type = FlightDetailAirLineCollectionViewCellTypeFirst;
    }else if(indexPath.row == _airLineCollectionArray.count-1){
        cell.type = FlightDetailAirLineCollectionViewCellTypeLast;
    }
    cell.titleNameLabel.text = _airLineCollectionArray[indexPath.row];
    return cell;

}



//#pragma mark - FlightDetailSafeguardTableViewCellDelegate
-(void)flightDetailSpecialTableViewCellAbnormalButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_SPETIAL_REPROTABN]) {
        AbnormalityReportViewController *abnormalityReportVC=[[AbnormalityReportViewController alloc]initWithNibName:@"AbnormalityReportViewController" bundle:nil];
        abnormalityReportVC.title = @"特殊上报";
        abnormalityReportVC.specialModel = tableArray[sender.tag];
        abnormalityReportVC.isSpecial = YES;
        [self.navigationController pushViewController:abnormalityReportVC
                                             animated:YES];

    }

}
-(void)flightDetailSpecialTableViewCellNormalButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_SPETIAL_REPORTNOR]) {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [HttpsUtils saveDispatchNormal:(int)flight.id
                            dispatchId:specicals[sender.tag].id
                                userId:(int)delegate.userInfoModel.id
                               success:^(id responseObj) {
                                   [self showAnimationTitle:@"上报成功"];
                                   if (responseObj && [responseObj isKindOfClass:[NSString class]]) {
                                       specicals[sender.tag].normalTime = responseObj;
                                       specicals[sender.tag].tag = 1;
                                       [_safeguardTableView reloadData];
                                   }
                               } failure:^(NSError *error) {
                                   [self showAnimationTitle:@"上报失败"];
                                   
                               }];

    }



}


#pragma mark - FlightDetailHeaderFooterViewDelegate
-(void)flightDetailHeaderFooterView:(UITableViewHeaderFooterView *)view
                showAndHiddenButton:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
            if (sender.tag == 1) {
                _safeguardTableViewHeight.constant = 37;
                [self.view layoutIfNeeded];

            }else{
                _safeguardTableViewHeight.constant = 37+ tableArray.count *103;
                [self.view layoutIfNeeded];
            }

    }];

}

-(void)loadData
{
    [HttpsUtils getFlightDetail:_flightId success:^(id responseObj) {
        [flight setValuesForKeysWithDictionary:responseObj];
        [self basicInfo];
    } failure:nil];


    //普通保障环节
    if([CommonFunction hasFunction:FL_NORMAL]){
        [HttpsUtils getDispatchDetail:_flightId success:^(id responseObj) {
            [dispatches removeAllObjects];
            if([flight isNull:responseObj]){
                return;
            }

            for(id item in responseObj){
                [dispatches addObject:[[SafeguardModel alloc] initWithDictionary:item]];
            }
            [self updateSpecialsTableView];
        } failure:nil];

    }


    //特殊保障环节

    if([CommonFunction hasFunction:FL_SPETIAL]&&_isSpecial){
        [HttpsUtils getSpecialDetail:_flightId success:^(id responseObj) {
            [specicals removeAllObjects];
            if([flight isNull:responseObj]){
                return;
            }
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

            NSLog(@"%@",appDelegate.userInfoModel.deptName);
            for(id item in responseObj){
                SpecialModel *model = [[SpecialModel alloc] initWithDictionary:item];

                if ([model.safeguardDepart isEqualToString:appDelegate.userInfoModel.deptName]||
                    [CommonFunction hasFunction:FL_ALLDISPATCH]) {//自己部门或者有检查权限
                    [specicals addObject:model];
                }
                
            }
            [self updateSpecialsTableView];
        } failure:nil];

    }
}

@end
