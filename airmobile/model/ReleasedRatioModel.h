//
//  ReleasedRatioModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReleasedRatioModel : NSObject

@property(nonatomic,copy) NSString *time;
@property(nonatomic,assign) CGFloat ratio;

-(instancetype) initWithTime:(NSString *)time ratio:(CGFloat)ratio;

@end
