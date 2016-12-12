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
#import "BasisInfoEventModel.h"
#import "AbnormalModel.h"
#import "PersistenceUtils+Business.h"
#import "BasisInfoDictionaryModel.h"
#import "BasisInfoEventModel.h"

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

                                if ([response isKindOfClass:[NSArray class]]) {
                                    NSMutableArray *mutableArray = [NSMutableArray array];
                                    for (NSDictionary *dic in response) {
                                        AbnormalModel *model = [[AbnormalModel alloc]initWithDictionary:dic];
                                        [mutableArray addObject:model];
                                    }
                                    self.abnormalityHistoryArray = [mutableArray copy];
                                    for (AbnormalModel *model in self.abnormalityHistoryArray) {
                                        if (model.startTime &&![model.startTime isEqualToString:@""]&&(!model.endTime||[model.endTime isEqualToString:@""])) {
                                            NSDictionary * dic = [[PersistenceUtils findBasisInfoEventWithEventId:model.event.intValue] lastObject];
                                            self.event = [[BasisInfoEventModel alloc]initWithDictionary:dic];
                                            NSDictionary *dic1= [[PersistenceUtils findBasisInfoDictionaryWithid:self.event.event_type] lastObject];
                                            self.eventType = [[BasisInfoDictionaryModel alloc] initWithDictionary:dic1];
                                            NSDictionary *dic2 = [[PersistenceUtils findBasisInfoDictionaryWithid:self.event.event_level] lastObject];
                                            self.eventLevel = [[BasisInfoDictionaryModel alloc]initWithDictionary:dic2];

                                            [self.tableView reloadData];
                                            self.tableView.allowsSelection = NO;
                                            self.startReportButton.enabled = NO;

                                        }

                                    }
                                    [self.abnormalityHistoryTableView reloadData];
                                }


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
                             eventId:self.event.id
                                memo:self.explainTextView.text
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
