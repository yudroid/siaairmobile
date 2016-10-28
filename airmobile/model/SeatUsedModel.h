//
//  SeatUsedModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatUsedModel : NSObject

@property(nonatomic,copy) NSString *type;
@property(nonatomic,assign) int free;
@property(nonatomic,assign) int used;

-(instancetype) initWithType:(NSString *)type free:(int)free used:(int)used;
-(CGFloat) getPercent;

@end
