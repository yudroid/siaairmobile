//
//  ResourceContentView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoP.h"
#import "RoundProgressView.h"
#import "LDProgressView.h"


typedef NS_ENUM(NSUInteger, ResourceContentViewType) {
    ResourceContentViewTypeMain,//主机位
    ResourceContentViewTypeSub //副机位
};


@class SeatStatusModel;

@protocol ResourceContentViewDelegate <NSObject>

@optional



/**
 展示机位的使用详细信息
 */
-(void) showSeatUsedMainDetailView;

-(void) showSeatUsedSubDetailView;

@end

@interface ResourceContentView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
    UILabel *normalNumLabel;
    UILabel *abnormalNumLabel;
    UILabel *cancelNumLabel;
    
    float   _totalNum;
    float   _normalNum;
    float   _abnormalNum;
    float   _cancleNum;
    
    CGFloat normalProportion;
    CGFloat abnormalProportion;
    CGFloat cancleProportion;
    
    id<ResourceContentViewDelegate> _delegate;
}

-(id)initWithFrame:(CGRect)                         frame
   seatStatusModel:(SeatStatusModel *)              seatStatusModel
              type:(ResourceContentViewType)        type
          delegate:(id<ResourceContentViewDelegate>)delegate;

@property (nonatomic ,assign) ResourceContentViewType type;
@end
