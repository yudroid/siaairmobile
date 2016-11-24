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
#import "FlightService.h"

static const NSString *FLIGHTDETAIL_TABLECELL_IDENTIFIER = @"FLIGHTDETAIL_TABLECELL_IDENTIFIER";
static const NSString *FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER = @"FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER";
static const NSString * FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER = @"FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER";


@interface FlightDetailViewController ()<UITableViewDataSource,
                                        UITableViewDelegate,
                                        FlightDetailTableViewCellDelegate,
                                        UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout,FlightDetailSafeguardTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet    UITableView         *tableView;
@property (weak, nonatomic) IBOutlet    NSLayoutConstraint  *tableViewHeight;
@property (weak, nonatomic) IBOutlet    UITableView         *safeguardTableView;
@property (weak, nonatomic) IBOutlet    UICollectionView    *AirlineCollectionView;

@property (nonatomic, copy) NSArray     *safeguardTableViewArray;
@property (nonatomic, copy) NSArray     *airLineCollectionArray;
@property (nonatomic, copy) NSArray     *tableArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeguradViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeguardTableViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *flightDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalLabel;
@property (weak, nonatomic) IBOutlet UILabel *gateLabel;
@property (weak, nonatomic) IBOutlet UILabel *baggagelabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionlabel;



@end

@implementation FlightDetailViewController
{
    FlightDetailModel *flight;
    NSMutableArray<SafeguardModel *> *dispatches;
    NSMutableArray<SafeguardModel *> *specicals;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    FlightService *flightService = [[FlightService alloc]init];
    [flightService startService];
    flight = [flightService getFlightDetailModel];

    dispatches = [NSMutableArray array];
    specicals = [NSMutableArray array];
    
    [self loadData];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:@"航班详情"];
    [self titleViewAddBackBtn];
    
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
    

    _safeguardTableViewArray    = [flightService getSafeguardArray];
    _safeguradViewHeight.constant = _safeguardTableViewArray.count *45+36;

    _tableArray = [flightService getSafeguardArray];

    [_AirlineCollectionView registerNib:[UINib nibWithNibName:@"FlightDetailAirLineCollectionViewCell" bundle:nil]
             forCellWithReuseIdentifier:(NSString *)FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER];

    _tableViewHeight.constant = 103*_tableArray.count;
    _safeguardTableViewHeight.constant = 45 * _safeguardTableViewArray.count +36;

    _flightDateLabel.text = flight.fDate;
    _terminalLabel.text = flight.terminal;
    _gateLabel.text = flight.gate;
    _baggagelabel.text = flight.baggage;
    _modelLabel.text = flight.model;
    _regionlabel.text = flight.region;

    _airLineCollectionArray = [flight.airLine componentsSeparatedByString:@"-"];
    
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _safeguardTableView) {
        return _safeguardTableViewArray.count;
    }
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        return 45;
    }
    return 103;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        FlightDetailSafeguardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailSafeguardTableViewCell" owner:nil options:nil][0];

        }

        cell.delegate = self;
        return  cell;
        
    }else{
        FlightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_TABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailTableViewCell" owner:nil options:nil][0];
        }
        cell.safeguardModel = _tableArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.type = FlightDetailTableViewCellTypeTypeFirst;
        }
        if (indexPath.row ==_tableArray.count-1 ) {
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
-(void)flightDetailTableViewCellUsualButtonClick
{
    CommonAbnormalityReportViewController *abnormalityReportVC=[[CommonAbnormalityReportViewController alloc]initWithNibName:@"AbnormalityReportViewController" bundle:nil];
    abnormalityReportVC.flightID = @"";
    abnormalityReportVC.SafeguardID = @"";
    abnormalityReportVC.isKeyFlight = YES;
    [self.navigationController pushViewController:abnormalityReportVC animated:YES];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _airLineCollectionArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-50)/_airLineCollectionArray.count, collectionView.frame.size.height);
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
    FlightDetailAirLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.type = FlightDetailAirLineCollectionViewCellTypeFirst;
    }else if(indexPath.row == _airLineCollectionArray.count-1){
        cell.type = FlightDetailAirLineCollectionViewCellTypeLast;
    }
    cell.titleNameLabel.text = _airLineCollectionArray[indexPath.row];
    return cell;

}

- (IBAction)safeguradContractButtonClick:(UIButton *)sender {
    if (sender.tag == 0) {
        
        sender.tag = 1;
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeRotation(M_PI);
            _safeguradViewHeight.constant = 36;
            [self.view layoutIfNeeded];
        }];
    }else{
        sender.tag = 0;
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeRotation(0);
            _safeguradViewHeight.constant = _safeguardTableViewArray.count *45+36;
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - FlightDetailSafeguardTableViewCellDelegate
-(void)flightDetailSafeguardTableViewCellAbnormalButtonClick:(UIButton *)sender
{
    SpecialAbnormalityReportViewController *abnormalityReportVC=[[SpecialAbnormalityReportViewController alloc]initWithNibName:@"AbnormalityReportViewController" bundle:nil];
    abnormalityReportVC.flightID = @"";
    abnormalityReportVC.SafeguardID = @"";
    [self.navigationController pushViewController:abnormalityReportVC animated:YES];
}
-(void)flightDetailSafeguardTableViewCellNormalButtonClick:(UIButton *)sender
{
    [self showAnimationTitle:@"已上报"];
    sender.enabled = NO;
    sender.backgroundColor = [UIColor grayColor];
}

-(void)loadData
{
    [HttpsUtils getFlightDetail:_flightId success:^(id responseObj) {
        [flight setValuesForKeysWithDictionary:responseObj];
    } failure:nil];
    
    [HttpsUtils getDispatchDetail:_flightId success:^(id responseObj) {
        [dispatches removeAllObjects];
        if([flight isNull:responseObj]){
            return;
        }
        
        for(id item in responseObj){
            [dispatches addObject:[[SafeguardModel alloc] initWithDictionary:item]];
        }
    } failure:nil];
    
    [HttpsUtils getSpecialDetail:_flightId success:^(id responseObj) {
        [specicals removeAllObjects];
        if([flight isNull:responseObj]){
            return;
        }
        
        for(id item in responseObj){
            [specicals addObject:[[SafeguardModel alloc] initWithDictionary:item]];
        }
    } failure:nil];
}

@end
