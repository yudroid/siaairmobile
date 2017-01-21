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
                        success:^(NSArray *response) {
                            [self stopNetWorking];
                            if ([response isKindOfClass:[NSArray class]]) {
                                //将字段数组转为对象数组
                                self.abnormalityHistoryArray = [response DictionaryToModel:[AbnormalModel class]];
                                int tag = 0;
                                for (AbnormalModel *model in self.abnormalityHistoryArray) {
                                    if ([self judgeReportStateWithAbnormalModel:model] == ReportStateStarted) {
                                        self.reportState = ReportStateStarted;
                                        [self setEventAbnormalModel:model];
                                        tag = 1;
                                        break;
                                    }
                                }
                                if (!tag) {
                                    self.reportState = ReportStateNoStart;
                                }
                            }
                            [self.abnormalityHistoryTableView reloadData];
                        }failure:^(NSError *error) {
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

    int index = 0;
    NSMutableArray *filePathArray = [NSMutableArray array];
    [self uploadImageIndex:index filePathArray:filePathArray failure:^(id error) {
        [self stopNetWorking];
        [self showAnimationTitle:@"上传失败"];
    }];
}

-(void)uploadImageIndex:(int)index filePathArray:(NSMutableArray *)filePathArray failure:(void (^)(id))failure
{
    __block  int newIndex = index;
    __block  NSMutableArray *blockFilePathArray = [filePathArray mutableCopy];
    if (self.collectionArray.count>0&&index<self.collectionArray.count) {
        [HttpsUtils unusualImageUploadImage:self.collectionArray[index] Success:^(id response) {
            [blockFilePathArray addObject:response];
            if (index+1 != self.collectionArray.count) {
                [self showAnimationTitle:[NSString stringWithFormat:@"%d图片上传成功",newIndex+1]];
            }else{
                self.imageFilePath = [blockFilePathArray copy];
            }
            newIndex++;
            [self uploadImageIndex:newIndex filePathArray:(NSMutableArray *)blockFilePathArray failure:failure];
        } failure:^(id error) {
            failure( error);
        }];
    }else{
        [self sendstartReport];
    }

}

-(void)sendstartReport
{
    AppDelegate *appdelete = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [HttpsUtils saveDispatchAbnStart:_specialModel.fid
                          dispatchId:_specialModel.id
                              userId:(int)appdelete.userInfoModel.id
                             eventId:self.event.basisid
                                memo:self.requireTextView.text
                                flag:self.isSpecial
                             imgPath:[self.imageFilePath componentsJoinedByString:@","]
                             success:^(id response) {

                                 [self stopNetWorking];
                                 if([response isEqualToString:@"0"]){
                                     [self showAnimationTitle:@"上报失败"];
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
                           }];

}
@end
