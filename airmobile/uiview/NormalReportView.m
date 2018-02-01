//
//  NormalReportView.m
//  airmobile
//
//  Created by xuesong on 2018/1/19.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import "NormalReportView.h"
#import "HttpsUtils+Business.h"
#import "NormalReportTableViewCell.h"


const NSString *NORMALREPORT_TABLECELL_IDENTIFIER = @"SAFEGUARDTYPE_TABLECELL_IDENTIFIER";

@interface NormalReportView ()
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (copy, nonatomic) NSArray  *tableArray;
@property (strong, nonatomic) NSMutableArray  *selectArray;
@end

@implementation NormalReportView

-(void)awakeFromNib
{
    [super awakeFromNib];
    //    self.layer.cornerRadius = 10;
    //    self.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 10;
    _backgroundView.layer.masksToBounds = YES;

    _tableArray = [NSArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _selectArray = [NSMutableArray array];
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"NormalReportTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)NORMALREPORT_TABLECELL_IDENTIFIER];
    [self loadData];

}



- (IBAction)ensureClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(normalReportViewDidSelectDate:reports:)]) {
        NSDate *date = _timePicker.date;
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
        [_delegate normalReportViewDidSelectDate:localeDate reports:[_selectArray copy]];
    }
    [self removeFromSuperview];
}
- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)NORMALREPORT_TABLECELL_IDENTIFIER];
    NSDictionary *dic = _tableArray[indexPath.row];
    cell.nameLable.text = [dic objectForKey:@"name"];
    cell.isSelected = [self dictionary:dic isInArray:_selectArray];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalReportTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic = _tableArray[indexPath.row];
    if ( [self dictionary:dic isInArray:_selectArray]) {
        [_selectArray removeObject:dic];
        cell.isSelected = false;
    }else{
        [_selectArray addObject:dic];
        cell.isSelected = true;
    }
}

-(void)loadData{
    [HttpsUtils queryNarmolDispatchBaseListSucess:^(id responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            self.tableArray = responseObj;
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {


    }];
}


-(BOOL)dictionary:(NSDictionary *)dic isInArray:(NSArray *)array
{
    for (NSDictionary *fdic in array) {
        if (fdic[@"id"] == dic[@"id"]) {
            return true;
        }
    }
    return false;
}

@end
