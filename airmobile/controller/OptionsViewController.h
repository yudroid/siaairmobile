//
//  OptionsViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

typedef NS_ENUM(NSUInteger, OptionsType) {
    OptionsTypeEvent,//事件
    OptionsTypeType,//类型
    OptionsTypeEventLevel//事件级别
};

@protocol OptionsViewControllerDelegate <NSObject>

-(void) optionsViewControllerFinshedOptionType:(OptionsType)optionType Value:(NSString *)value;

@end



@interface OptionsViewController : RootViewController

@property (nonatomic ,weak) id<OptionsViewControllerDelegate> delegate;

-(instancetype) initWithOptionType:(OptionsType)optionsType;

@end
