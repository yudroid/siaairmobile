//
//  OptionCollectionViewCell.h
//  airmobile
//
//  Created by xuesong on 16/11/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BasisInfoDictionaryModel;

@interface OptionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic ,strong) BasisInfoDictionaryModel *basisInfoDictionaryModel;

@end
