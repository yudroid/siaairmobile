//
//  ImageViewCollectionViewCell.h
//  airmobile
//
//  Created by xuesong on 16/11/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LongPressBlock) (UICollectionViewCell *cell);

@interface ImageViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) LongPressBlock longPressBlock;
@property (nonatomic, copy) NSString *imagePath;

@end
