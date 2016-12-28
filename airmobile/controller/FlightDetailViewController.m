//
//  FlightDetailViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailViewController.h"
#import "FlightDetailTableViewCell.h"
#import "CommonAbnormalityReportViewController.h"
#import "SpecialAbnormalityReportViewController.h"
#import "FlightDetailSafeguardTableViewCell.h"
#import "FlightDetailAirLineCollectionViewCell.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "FlightDetailModel.h"
#import "SafeguardModel.h"
#import "SpecialModel.h"
#import "AppDelegate.h"
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
FlightDetailSafeguardTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet    UITableView         *tableView;
@property (weak, nonatomic) IBOutlet    NSLayoutConstraint  *tableViewHeight;
@property (weak, nonatomic) IBOutlet    UITableView         *safeguardTableView;//特殊保障 tableview
@property (weak, nonatomic) IBOutlet    UICollectionView    *AirlineCollectionView;

@property (nonatomic, copy) NSArray     *airLineCollectionArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeguardTableViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *flightDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalLabel;
@property (weak, nonatomic) IBOutlet UILabel *gateLabel;
@property (weak, nonatomic) IBOutlet UILabel *baggagelabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionlabel;

@property (weak, nonatomic) IBOutlet UILabel *arrTime;
@property (weak, nonatomic) IBOutlet UILabel *depTime;
@property (weak, nonatomic) IBOutlet UILabel *frontFlightNo;
@property (weak, nonatomic) IBOutlet UILabel *frontFlightStatus;

@end

@implementation FlightDetailViewController
{
    FlightDetailModel *flight;
    NSMutableArray<SafeguardModel *> *dispatches;
    NSMutableArray<SpecialModel *> *specicals;

    NSString *DispatchType;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    flight = [[FlightDetailModel alloc]init];
    dispatches = [NSMutableArray array];
    specicals = [NSMutableArray array];
    

    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:_flightNo];
    [self titleViewAddBackBtn];
    UIButton *tagButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-30, 27, 30, 30)];
    if (1) {
        [tagButton setImage:[UIImage imageNamed:@"Concern1"] forState:UIControlStateNormal];
        tagButton.tag = 1;
    }else{
        [tagButton setImage:[UIImage imageNamed:@"Concern2"] forState:UIControlStateNormal];
        tagButton.tag = 2;
    }

    [tagButton addTarget: self action:@selector(concernButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:tagButton];

    
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    // 航班保障信息相关
    _tableView.dataSource       = self;
    _tableView.delegate         = self;
    _tableViewHeight.constant   = 1000;
    _tableView.allowsSelection  = NO;
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

    _tableViewHeight.constant = 103*dispatches.count+37;
    _safeguardTableViewHeight.constant = 90 * specicals.count +37;
    [self basicInfo];
    [self loadData];

    
}
-(void)viewDidAppear:(BOOL)animated{
    [_safeguardTableView reloadData];


}

-(void)viewWillAppear:(BOOL)animated
{
    if (![CommonFunction hasFunction:FL_SPETIAL]||!_isSpecial) {
        _safeguardTableViewHeight.constant = 0;
    }
    if (![CommonFunction hasFunction:FL_NORMAL]) {
        _tableViewHeight.constant = 0;
        _tableView.hidden = YES;
    }

}

-(void)concernButtonClick:(UIButton *)sender
{
    if (sender.tag == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform =  CGAffineTransformMakeScale(0.5, 0.5);
            [sender setImage:[UIImage imageNamed:@"Concern2"] forState:UIControlStateNormal];
            sender.tag = 2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                sender.transform = CGAffineTransformScale(sender.transform, 2, 2);

            }];

        }];

    }else{
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform =  CGAffineTransformMakeScale(0.5, 0.5);
            [sender setImage:[UIImage imageNamed:@"Concern1"] forState:UIControlStateNormal];
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
    _safeguardTableViewHeight.constant = 90 * specicals.count +37;
    [_safeguardTableView reloadData];

}
-(void)updateDispatchesTableView
{
    if (![CommonFunction hasFunction:FL_NORMAL]) {
        return;
    }
    _tableViewHeight.constant = 103*dispatches.count+37;
    [_tableView reloadData];

}


-(void)basicInfo
{
    _flightDateLabel.text   = flight.fDate;
    _terminalLabel.text     = flight.terminal;
    _gateLabel.text         = flight.gate;
    _baggagelabel.text      = flight.baggage;
    _modelLabel.text        = flight.model;
    _regionlabel.text       = flight.region;
    _arrTime.text           = flight.sTime;
    _depTime.text           = flight.eTime;
    _frontFlightNo.text     = flight.preorderNum;
    _frontFlightStatus.text = flight.preorderState;
    _airLineCollectionArray = [flight.airLine componentsSeparatedByString:@"-"];

    if ([_airLineCollectionArray[0] isEqualToString:@"SZX"]) {
        DispatchType = @"始发保障";
    }else if([_airLineCollectionArray[_airLineCollectionArray.count-1] isEqualToString:@"SZX"]){
        DispatchType = @"过站保障";
    }else{
        DispatchType = @"航后保障";
    }
    [_AirlineCollectionView reloadData];

}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _safeguardTableView) {
        return specicals.count;
    }
    return dispatches.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 37.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        return 90;
    }
    return 103;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FlightDetailHeaderFooterView *headerView = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailHearderFooterView" owner:nil options:nil][0];
    headerView.delegate = self;
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 37);
    if (tableView == _tableView) {
        headerView.titleLabel.text = @"普通保障";
        headerView.tag = 0;
    }else{
        headerView.titleLabel.text = @"特殊保障";
        headerView.tag = 1;
    }
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        FlightDetailSafeguardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailSafeguardTableViewCell"
                                                 owner:nil
                                               options:nil][0];
        }
        cell.indexRow = indexPath.row;
        cell.specialModel = specicals[indexPath.row];
        cell.delegate = self;
        return  cell;
        
    }else{
        FlightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_TABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailTableViewCell"
                                                 owner:nil
                                               options:nil][0];
        }
        cell.safeguardModel = dispatches[indexPath.row];
        cell.indexRow = indexPath.row;
        if (indexPath.row == 0) {
            cell.type = FlightDetailTableViewCellTypeTypeFirst;
        }
        if (indexPath.row ==dispatches.count-1 ) {
            cell.type = FlightDetailTableViewCellTypeTypeLast;
        }
            cell.delegate = self;
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - FlightDetailTableViewCellDelegate
-(void)flightDetailTableViewCellUsualButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_NORMAL_REPORTABN]) {
        CommonAbnormalityReportViewController *abnormalityReportVC=[[CommonAbnormalityReportViewController alloc] initWithNibName:@"AbnormalityReportViewController" bundle:nil];
        abnormalityReportVC.title = @"异常上报";
        abnormalityReportVC.flightID = flight.id;
        abnormalityReportVC.SafeguardID = (int )dispatches[sender.tag].id;
        abnormalityReportVC.isKeyFlight = YES;
        abnormalityReportVC.DispatchType = DispatchType;
        [self.navigationController pushViewController:abnormalityReportVC
                                             animated:YES];
    }

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _airLineCollectionArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-50)/_airLineCollectionArray.count,
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



#pragma mark - FlightDetailSafeguardTableViewCellDelegate
-(void)flightDetailSafeguardTableViewCellAbnormalButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_SPETIAL_REPROTABN]) {
        SpecialAbnormalityReportViewController *abnormalityReportVC=[[SpecialAbnormalityReportViewController alloc]initWithNibName:@"AbnormalityReportViewController" bundle:nil];
        abnormalityReportVC.title = @"特殊上报";
        abnormalityReportVC.specialModel = specicals[sender.tag];
        abnormalityReportVC.DispatchType = DispatchType;
        abnormalityReportVC.isSpecial = self.isSpecial;
        [self.navigationController pushViewController:abnormalityReportVC
                                             animated:YES];

    }

}
-(void)flightDetailSafeguardTableViewCellNormalButtonClick:(UIButton *)sender
{
    if ([CommonFunction hasFunction:FL_SPETIAL_REPORTNOR]) {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [HttpsUtils saveDispatchNormal:flight.id
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
        if (view.tag == 0) {
            if (sender.tag == 1) {
                _tableViewHeight.constant = 37;
                [self.view layoutIfNeeded];

            }else{

                _tableViewHeight.constant = 37+ dispatches.count *103;
                [self.view layoutIfNeeded];
            }
        }else{
            if (sender.tag == 1) {
                _safeguardTableViewHeight.constant = 37;
                [self.view layoutIfNeeded];

            }else{
                _safeguardTableViewHeight.constant = 37+ specicals.count *103;
                [self.view layoutIfNeeded];
            }
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
            [self updateDispatchesTableView];
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
