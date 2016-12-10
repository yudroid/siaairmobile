//
//  FlightFilterCollectionViewCell.h
//  airmobile
//
//  Created by xuesong on 16/12/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightFilterView.h"

@interface FlightFilterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet FilghtFilterButton *contentButton;

@property (nonatomic ,assign) BOOL isSelected;

@end
