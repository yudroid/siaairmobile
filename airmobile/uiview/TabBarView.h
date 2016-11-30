//
//  TabBarView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunction.h"

// 当前选中的按钮类型枚举
typedef enum {
    TabBarSelectedTypeHomePage,
    TabBarSelectedTypeFlight,
    TabBarSelectedTypeMessage,
    TabBarSelectedTypeFunction,
    TabBarSelectedTypeUserInfo,
    
} TabBarSelectedType;

// item当前状态枚举
typedef enum {
    TabBarBgModelHomePage,
    TabBarBgModelNormal,
    
} TabBarBgModel;

//点击协议
@protocol TabBarViewDelegate <NSObject>
    -(void) selectWithType: (TabBarSelectedType)type;
@end

// 每个按钮元素接口
@interface TabBarIteam : UIView
    {
        UIImageView *icon;
        UILabel     *titleLabel;
    }
    @property (nonatomic,strong)UIImage     *image;
    @property (nonatomic,strong)NSString    *text;
    @property (nonatomic,strong)UIColor     *textColor;
@end

// 导航栏按钮
@interface TabBarView : UIView
    {
        id<TabBarViewDelegate> _delegate;
        UIImageView *newMessage;
    }
    
    @property (nonatomic,assign)BOOL hasNewMessage;

    -(id)initTabBarWithModel:(TabBarBgModel)model
                selectedType:(TabBarSelectedType)type
                    delegate:(id<TabBarViewDelegate>)delegate;
    -(void) setHasNewMessage:(BOOL)hasNewMessage;
@end





