//
//  CommonAbnormalityReportViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "CommonAbnormalityReportViewController.h"
#import "AppDelegate.h"
#import "HttpsUtils+Business.h"
#import "SafeguardModel.h"
#import "BasisInfoEventModel.h"
#import "UIViewController+Reminder.h"
#import "AbnormalModel.h"
#import "PersistenceUtils+Business.h"
#import "BasisInfoDictionaryModel.h"
#import "BasisInfoEventModel.h"



@interface CommonAbnormalityReportViewController ()



@end

@implementation CommonAbnormalityReportViewController

- (void)viewDidLoad {
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

                                    int  tag = 0;
                                    for (AbnormalModel *model in self.abnormalityHistoryArray) {
                                        if (model.startTime
                                            &&![model.startTime isEqualToString:@""]
                                            &&(!model.endTime||[model.endTime isEqualToString:@""])) {
                                            tag = 1;

                                            NSDictionary * dic = [[PersistenceUtils findBasisInfoEventWithEventId:model.event.intValue] lastObject];
                                            self.event = [[BasisInfoEventModel alloc]initWithDictionary:dic];
                                            NSDictionary *dic1= [[PersistenceUtils findBasisInfoDictionaryWithid:self.event.event_type] lastObject];
                                            self.eventType = [[BasisInfoDictionaryModel alloc] initWithDictionary:dic1];
                                            NSDictionary *dic2 = [[PersistenceUtils findBasisInfoDictionaryWithid:self.event.event_level] lastObject];
                                            self.eventLevel = [[BasisInfoDictionaryModel alloc]initWithDictionary:dic2];

                                            self.explainTextView.text = self.event.content;
                                            [self.tableView reloadData];

                                            self.reportState = ReportStateStarted;
                                            break;
                                        }

                                    }
                                    if (tag == 0) {
                                        self.reportState = ReportStateNoStart;
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
                             eventId:self.event.basisid
                                memo:self.explainTextView.text
                                flag:self.isSpecial
                             imgPath:@"null"
                             success:^(id response) {
                                 self.reportState = ReportStateStarted;
                                 if (response &&[response isKindOfClass:[NSString class]]) {
                                     self.abnormalId = ((NSString *)response).intValue;
                                 }
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
                               if (response&&[response isKindOfClass:[NSString class]]&&[response isEqualToString:@"Success"]) {
                                   [self showAnimationTitle:@"上报成功"];
                                   [self.tableView reloadData];
                                   self.reportState = ReportStateCompleted;

                               }else{
                                   [self showAnimationTitle:response];
                               }

                           }
                           failure:^(NSError *error) {
                               [self showAnimationTitle:@"上报失败"];
                           }];
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
