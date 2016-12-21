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
#import "AbnormalModel.h"
#import "BasisInfoEventModel.h"
#import "PersistenceUtils+Business.h"
#import "BasisInfoDictionaryModel.h"

@interface SpecialAbnormalityReportViewController ()

@end

@implementation SpecialAbnormalityReportViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self starNetWorking];
    [HttpsUtils getDispatchAbns:_specialModel.id
                           type:1
                        success:^(id response) {
                            [self stopNetWorking];
                            if ([response isKindOfClass:[NSArray class]]) {
                                [self stopNetWorking];
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
                                            self.abnormalId = (int)model.id;

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
                            [self stopNetWorking];
                            [self showAnimationTitle:@"获取历史列表失败"];
                        }];

}


- (IBAction)startReportDatClick:(id)sender {

    if(self.event == nil){
        [self showAnimationTitle:@"请选取有效的事件"];
        return;
    }

    if (self.requireTextView.text.length == 0) {
        [self showAnimationTitle:@"请填写要求"];
        return;
    }

    [self starNetWorking];
    AppDelegate *appdelete = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    [HttpsUtils saveDispatchAbnStart:_specialModel.fid
                          dispatchId:_specialModel.id
                              userId:(int)appdelete.userInfoModel.id
                             eventId:self.event.basisid
                                memo:self.requireTextView.text
                                flag:self.isSpecial
                             imgPath:@"null"
                             success:^(id response) {

                                 [self stopNetWorking];
                                 if([response isEqualToString:@"0"]){
                                     return ;
                                 }
                                 [self showAnimationTitle:@"上报成功"];
                                 _specialModel.tag = 2;
                                 self.reportState = ReportStateStarted;
                                 if (response &&[response isKindOfClass:[NSString class]]) {
                                     self.abnormalId = ((NSString *)response).intValue;
                                 }

                             }
                             failure:^(NSError *error) {
                                 [self stopNetWorking];
                                 [self showAnimationTitle:@"上报失败"];

                             }];
}

- (IBAction)endReportDate:(id)sender {

    [self starNetWorking];
    AppDelegate *appdelete = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [HttpsUtils saveDispatchAbnEnd:self.abnormalId
                            userId:(int)appdelete.userInfoModel.id
                           success:^(id response) {
                               if (response&&[response isKindOfClass:[NSString class]]&&[response isEqualToString:@"Success"]) {
                                   [self stopNetWorking];
                                   [self showAnimationTitle:@"上报成功"];
                                   [self.tableView reloadData];
                                   self.reportState = ReportStateCompleted;

                               }else{
                                   [self showAnimationTitle:response];
                               }

                           }
                           failure:^(NSError *error) {
                               [self stopNetWorking];
                               [self showAnimationTitle:@"上报失败"];
//                               self.endReportButton.enabled = NO;
                           }];

}
@end
