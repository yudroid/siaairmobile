//
//  BaseReq.h
//  test111
//
//  Created by zhangbo on 14-2-24.
//  Copyright (c) 2014年 Livindesign. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMEBaseReq : NSObject
{
    int _reqType;
  
}

@property (nonatomic ,assign) int reqType;
@property (nonatomic ,copy) NSString *appScheme;

@end
