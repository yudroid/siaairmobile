//
//  FlightFliterView.h
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KnowledgeBaseTypeModel;

@interface FilghtFilterButton:UIButton

@property (nonatomic ,copy)     NSString    *title;
@property (nonatomic, copy)     NSString    *value;
@property (nonatomic, copy)     NSString    *group;
@property (nonatomic, assign)   Boolean     isSelected;//是否被选中

@end

@class FlightFilterView;

@protocol FlightFilterViewDelegate <NSObject>

-(void)flightFilterView:(FlightFilterView *)view knowledgeBaseType:(KnowledgeBaseTypeModel *)model;
-(void)flightFilterView:(FlightFilterView *)view filghtFilterCleanButton:(UIButton *)button;


@end
@interface FlightFilterView : UIView

@property (nonatomic, weak) id<FlightFilterViewDelegate> delegate;




@end
