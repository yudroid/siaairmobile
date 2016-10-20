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
#import "FlightDetailSafeguardTableViewCell.h"
#import "FlightDetailAirLineCollectionViewCell.h"

static const NSString *FLIGHTDETAIL_TABLECELL_IDENTIFIER = @"FLIGHTDETAIL_TABLECELL_IDENTIFIER";
static const NSString *FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER = @"FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER";
static const NSString * FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER = @"FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER";


@interface FlightDetailViewController ()<UITableViewDataSource,
                                        UITableViewDelegate,
                                        FlightDetailTableViewCellDelegate,
                                        UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet    UITableView         *tableView;
@property (weak, nonatomic) IBOutlet    NSLayoutConstraint  *tableViewHeight;
@property (weak, nonatomic) IBOutlet    UITableView         *safeguardTableView;
@property (weak, nonatomic) IBOutlet    UICollectionView    *AirlineCollectionView;

@property (nonatomic, copy) NSArray     *safeguardTableViewArray;
@property (nonatomic, copy) NSArray     *airLineCollectionArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeguradViewHeight;

@end

@implementation FlightDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:@"航班详情"];
    [self titleViewAddBackBtn];
    
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    
    _tableView.dataSource       = self;
    _tableView.delegate         = self;
    _tableViewHeight.constant   = 1000;
    _tableView.allowsSelection  = NO;
    
    _safeguardTableView.dataSource      = self;
    _safeguardTableView.delegate        = self;
    _safeguardTableView.allowsSelection = NO;
    
    _AirlineCollectionView.delegate     = self;
    _AirlineCollectionView.dataSource   = self;
    
    _airLineCollectionArray     = @[@"上海虹桥",@"深圳宝安",@"北京首都"];
    _safeguardTableViewArray    = @[@"1",@""];
    
    
    [_AirlineCollectionView registerNib:[UINib nibWithNibName:@"FlightDetailAirLineCollectionViewCell" bundle:nil]
             forCellWithReuseIdentifier:(NSString *)FLIGHTDETAIL_AIRLINECOLLECTION_IDENTIFIER];
    
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _safeguardTableView) {
        return 2;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        return 30;
    }
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        FlightDetailSafeguardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailSafeguardTableViewCell" owner:nil options:nil][0];
        }
        return  cell;
        
    }else{
        FlightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_TABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailTableViewCell" owner:nil options:nil][0];
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
    AbnormalityReportViewController *abnormalityReportVC=[[AbnormalityReportViewController alloc]initWithNibName:@"AbnormalityReportViewController" bundle:nil];
    [self.navigationController pushViewController:abnormalityReportVC animated:YES];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _airLineCollectionArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-59)/_airLineCollectionArray.count, collectionView.frame.size.height);
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
            _safeguradViewHeight.constant = 30;
            [self.view layoutIfNeeded];
        }];
    }else{
        sender.tag = 0;
        [UIView animateWithDuration:0.3 animations:^{
            _safeguradViewHeight.constant = _safeguardTableViewArray.count *30+30;
            [self.view layoutIfNeeded];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
