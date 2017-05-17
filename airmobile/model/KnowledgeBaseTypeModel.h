//
//  KnowledgeBaseTypeModel.h
//  airmobile
//
//  Created by xuesong on 2017/5/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface KnowledgeBaseTypeModel : RootModel

@property (nonatomic, strong) NSString*	code;
@property (nonatomic, assign) NSInteger	id;
@property (nonatomic, strong) NSString*	content;
@property (nonatomic, assign) NSInteger	version;
@property (nonatomic, strong) NSString*	type;
@property (nonatomic, strong) NSString*	sortIndex;


@end
