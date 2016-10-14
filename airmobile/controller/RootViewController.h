//
//  RootViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarView.h"

typedef enum
{
    TitleTypeHigh,
    TitleTypeNormal,
    
}TitleType;

@interface RootViewController : UIViewController
{
    
}

@property(nonatomic,strong) DefaultHelper *defaultHelper;
@property(nonatomic,strong) GlobalHelper  *globalHelper;

@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)TabBarView *tabBarView;
@property(nonatomic,assign)TitleType titleType;

//titleView相关设置
-(void)titleViewInitWithHight:(CGFloat)high;
- (void)titleViewAddTitleText:(NSString *)titleText;
-(UIButton *)titleViewAddBackBtn;

@end
