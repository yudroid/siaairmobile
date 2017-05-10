//
//  AbnormalModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalModel.h"

@implementation AbnormalModel



-(void)setPathList:(NSString *)pathList
{
    if ([pathList isKindOfClass:[NSString class]]&&pathList.length > 0&&[pathList characterAtIndex:0]==','  ) {
        NSMutableString *mutableString = [NSMutableString stringWithString:pathList];
        [mutableString deleteCharactersInRange:NSMakeRange(0, 1)];
        _pathList = [mutableString copy];

    }else{
        _pathList = @"";
    }

}



@end
