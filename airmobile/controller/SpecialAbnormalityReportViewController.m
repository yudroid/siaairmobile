//
//  SpecialAbnormalityReportViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SpecialAbnormalityReportViewController.h"
#import "HttpsUtils+Business.h"
#import "SpecialModel.h"
#import "AppDelegate.h"
#import "UIViewController+Reminder.h"

@interface SpecialAbnormalityReportViewController ()

@end

@implementation SpecialAbnormalityReportViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [HttpsUtils getDispatchAbns:_specialModel.id
                           type:1
                        success:^(id response) {
                            if ([response isKindOfClass:[NSArray class]]) {
                                self.abnormalityHistoryArray = response;
                                [self.abnormalityHistoryTableView reloadData];
                            }
                        }
                        failure:^(NSError *error) {
                            [self showAnimationTitle:@"获取历史列表失败"];
                        }];

}






- (IBAction)startReportDatClick:(id)sender {

    AppDelegate *appdelete = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    [HttpsUtils saveDispatchAbnStart:_specialModel.fid
                          dispatchId:_specialModel.id
                              userId:(int)appdelete.userInfoModel.id
                             eventId:0
                                memo:@""
                                flag:_specialModel.tag
                             imgPath:@""
                             success:^(id response) {
                                 [self showAnimationTitle:@"上报成功"];
                             }
                             failure:^(NSError *error) {
                                 [self showAnimationTitle:@"上报失败"];
                             }];

    //    [self setupDateView];
}

- (IBAction)endReportDate:(id)sender {
    AppDelegate *appdelete = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [HttpsUtils saveDispatchAbnEnd:_specialModel.id
                            userId:(int)appdelete.userInfoModel.id
                           success:^(id response) {
                               [self showAnimationTitle:@"上报成功"];
                           }
                           failure:^(NSError *error) {
                               [self showAnimationTitle:@"上报失败"];
                           }];

}
@end
