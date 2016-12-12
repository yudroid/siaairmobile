//
//  OptionCollectionViewCell.m
//  airmobile
//
//  Created by xuesong on 16/11/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OptionCollectionViewCell.h"
#import "BasisInfoDictionaryModel.h"
#import "BasisInfoEventModel.h"

@interface OptionCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation OptionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _nameLabel.adjustsFontSizeToFitWidth = YES;
}


-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _backgroundImageView.image = [UIImage imageNamed:@"OptionCellSelected"];
    }else{
        _backgroundImageView.image = [UIImage imageNamed:@"OptionCellNotSelected"];
    }

}

-(void)setBasisInfoDictionaryModel:(BasisInfoDictionaryModel *)basisInfoDictionaryModel
{
    _basisInfoDictionaryModel = basisInfoDictionaryModel;
    _nameLabel.text = basisInfoDictionaryModel.content;
}

-(void)setBasisInfoEventModel:(BasisInfoEventModel *)basisInfoEventModel
{
    _basisInfoEventModel = basisInfoEventModel;
    _nameLabel.text = basisInfoEventModel.event;

}
@end
