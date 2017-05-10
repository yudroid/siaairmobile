//
//  ChatRightImageTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ChatRightImageTableViewCell.h"

@interface ChatRightImageTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImgeViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTrailing;

@end

@implementation ChatRightImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }
}

-(void) adjustPLUS
{
    _headerImgeViewTrailing.constant = px_3(35);
    _nameLabelTrailing.constant = px_3(31);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)imageButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(chatRightImageClick:)]) {
        [_delegate chatRightImageClick:_imageButton.imageView.image];
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
