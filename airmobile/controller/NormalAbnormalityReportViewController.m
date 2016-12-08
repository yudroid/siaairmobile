//
//  NormalAbnormalityReportViewController.m
//  airmobile
//
//  Created by xuesong on 16/12/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "NormalAbnormalityReportViewController.h"
#import "HttpsUtils+Business.h"
#import "AppDelegate.h"
#import "SafeguardModel.h"
#import "UIViewController+Reminder.h"

@interface NormalAbnormalityReportViewController ()

@end

@implementation NormalAbnormalityReportViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [HttpsUtils getDispatchAbns:(int)_safefuardModel.id
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

    [HttpsUtils saveDispatchAbnStart:(int)_safefuardModel.fid
                          dispatchId:(int)_safefuardModel.id
                              userId:(int)appdelete.userInfoModel.id
                             eventId:0
                                memo:@""
                                flag:0
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
    [HttpsUtils saveDispatchAbnEnd:(int)_safefuardModel.id
                            userId:(int)appdelete.userInfoModel.id
                           success:^(id response) {
                               [self showAnimationTitle:@"上报成功"];
                           }
                           failure:^(NSError *error) {
                               [self showAnimationTitle:@"上报失败"];
                           }];
}


@end
