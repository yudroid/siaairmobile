//
//  ChatLeftImageTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ChatLeftImageTableViewCell.h"

@interface ChatLeftImageTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTrailing;

@end

@implementation ChatLeftImageTableViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }


}

-(void)adjustPLUS
{
    _headerImageViewTrailing.constant = px_3(35);
    _headerImageViewWidth.constant = px_3(125);
    _headerImageViewHeight.constant = px_3(125);
    _nameLabelTrailing.constant = px_3(15);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)imageButtonClick:(id)sender {

    if ([_delegate respondsToSelector:@selector(chatLeftImageClick:)]) {
        [_delegate chatLeftImageClick:_imageButton.imageView.image];
    }
}



-(void)setImageBase64:(NSString *)imageBase64
{
    _imageBase64 = imageBase64;
    NSData *decodedImageData = [[NSData alloc]
                                initWithBase64EncodedString:imageBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];

    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];

    [_imageButton setImage:decodedImage forState:UIControlStateNormal];
    
}


@end
