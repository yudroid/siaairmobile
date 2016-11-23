//
//  RootModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(BOOL)isNull:(NSDictionary *)data;

@end
