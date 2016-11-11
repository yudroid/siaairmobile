//
//  ContactPersonTableViewHeaderView.m
//  airmobile
//
//  Created by xuesong on 16/11/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ContactPersonTableViewHeaderView.h"

@interface ContactPersonTableViewHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *fileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fileLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagLeading;



@end

@implementation ContactPersonTableViewHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }
}


-(void)adjustPLUS
{
    _fileLeading.constant = px_3(34);
    _titleLeading.constant = px_3(34);
    _tagLeading.constant = px_3(36);
    _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(54)];
}

-(void)setOpen:(BOOL)open
{
    _open = open;
    UIImage *fileImage;
    UIImage *tagImage;
    if (_open) {
        fileImage= [UIImage imageNamed:@"FileOpen"];
        tagImage = [UIImage imageNamed:@"FileOpenTag"];
    }else{
        fileImage = [UIImage imageNamed:@"FileClose"];
        tagImage = [UIImage imageNamed:@"FileCloseTag"];
    }

    [UIView animateWithDuration:0.3 animations:^{
        _fileImageView.image = fileImage;
        _tagImageView.image = tagImage;
        [self layoutIfNeeded];
    }];
}

- (IBAction)viewClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(contactPersonTableViewHeaderViewClick:)]) {
        [self.delegate contactPersonTableViewHeaderViewClick:self];
    }
}

@end
