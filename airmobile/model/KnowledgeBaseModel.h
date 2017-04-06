//
//  KnowledgeBaseModel.h
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"
@interface KnowledgeBaseModel : RootModel

@property(nonatomic, assign)  NSInteger id;//唯一标识
@property(nonatomic, strong)  NSString *title;//标题
@property(nonatomic, strong)  NSString *depName;//部门名称
@property(nonatomic, strong)  NSString *userName;//用户名称
@property(nonatomic, strong)  NSString *CreateTime;//时间
@property(nonatomic, strong)  NSString *httpPath;//网络附件路径
@property(nonatomic, strong)  NSString *memo;//概述
@property(nonatomic, strong)  NSString *typeName;//标签
@property(nonatomic, strong)  NSString *content;//内容
@property(nonatomic, strong)  NSString *localPath;//本地路径

@end
