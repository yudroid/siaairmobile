//
//  KnowledgeBaseContentViewController.h
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class KnowledgeBaseModel;

@interface KnowledgeBaseContentViewController : RootViewController

@property (nonatomic, strong) KnowledgeBaseModel *knowledgeBaseModel;
@property (nonatomic, assign) NSInteger type; ///1为知识库 2为运行简报

@end
