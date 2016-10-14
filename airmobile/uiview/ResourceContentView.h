//
//  ResourceContentView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResourceContentViewDelegate <NSObject>

@optional

/**
 展示机位的使用详细信息
 */
-(void) showSeatUsedDetailView;

@end

@interface ResourceContentView : UIView

@end
