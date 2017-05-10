//
//  ContingencyAddressBookViewController.m
//  airmobile
//
//  Created by xuesong on 17/4/13.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ContingencyAddressBookViewController.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "AddressBookTableViewCell.h"
#import "ContingencyAddressBookModel.h"
//#import "<#header#>"



static const NSString *ADDRESSBOOK_TABLECELL_IDENTIFIER         = @"CONTINGENCYADDRESSBOOK_TABLECELL_IDENTIFIER";


@interface ContingencyAddressBookViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray  *tableArray;

@end

@implementation ContingencyAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    [self titleViewAddTitleText:@"应急通讯录"];



    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"AddressBookTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];


    _tableArray = [NSMutableArray array];


    [self UpdateNetwork];
    // Do any additional setup after loading the view from its nib.
}

-(void)UpdateNetwork
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"%@",currentDateStr);

    [self starNetWorking];
//    [HttpsUtils getDutyTableByDay:currentDateStr success:^(NSArray *responseObj) {
//        if ([responseObj isKindOfClass:[NSArray class]]) {
//            _tableArray = [responseObj DictionaryToModel:[DutyModel class]];
//            _tableArray= [_tableArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//
//                NSInteger x1 = ((DutyModel *)obj1).sort;
//                NSInteger x2 = ((DutyModel *)obj2).sort;
//                return  x1>x2;
//            }];
//            [_tableView reloadData];
//        }
//        [self stopNetWorking];
//    } failure:^(NSError *error) {
//        [self stopNetWorking];
//    }];
    [HttpsUtils queryMobileEmergencySucess:^(NSArray *responseObj) {
        [self stopNetWorking];
        NSArray *array = [responseObj DictionaryToModel:[ContingencyAddressBookModel class]];
//        _tableArray =
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (ContingencyAddressBookModel *model in array) {
             int tag = 1;
            for (ContingencyAddressBookModel *subModel in mutableArray) {

                if ([subModel.name isEqualToString:model.name]) {
                    tag = 0;
                    NSString *string = [NSString stringWithFormat:@"%@/%@",subModel.phone,model.phone];
                    subModel.phone = string;
                }
            }
            if (tag) {
                [mutableArray addObject:model];
            }
        }
        _tableArray = [mutableArray copy];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [self showAnimationTitle:@"失败"];
        [self stopNetWorking];
    }];
}



#pragma mark - UITableViewDelegate UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}



-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
    ContingencyAddressBookModel *model = _tableArray[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", model.name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContingencyAddressBookModel *model = _tableArray[indexPath.row];
    NSArray *phoneArray = [model.phone componentsSeparatedByString:@"/"];
    if (phoneArray.count ==1) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneArray[0]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if (phoneArray.count > 1){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"电话" message:nil preferredStyle:UIAlertControllerStyleAlert];
        for (int i = 0; i<phoneArray.count; i++) {
            [alertController addAction:[UIAlertAction actionWithTitle:phoneArray[i]
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneArray[i]];
                                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

            }]];
        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel handler:nil]];

        [self presentViewController:alertController animated:YES completion:nil];
    }
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dutyModel.phone];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

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
