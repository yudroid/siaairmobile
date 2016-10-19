//
//  FlightDetailAirLineCollectionViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FlightDetailAirLineCollectionViewCellType) {
    FlightDetailAirLineCollectionViewCellTypeDefault,
    FlightDetailAirLineCollectionViewCellTypeFirst,
    FlightDetailAirLineCollectionViewCellTypeLast,
};

@interface FlightDetailAirLineCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (nonatomic, assign) FlightDetailAirLineCollectionViewCellType type;

@end
