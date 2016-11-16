//
//  AbnormalityReportCollectionViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbnormalityReportCollectionViewCell : UICollectionViewCell
    
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedBackgroundImageView;
@property (nonatomic ,assign) BOOL isSelected;

@end
