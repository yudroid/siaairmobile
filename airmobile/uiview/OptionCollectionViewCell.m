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
#import "UIControl+SelfViewController.h"


@interface OptionCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation OptionCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo)];
    longPressGr.minimumPressDuration = 0.5;
    [self addGestureRecognizer:longPressGr];

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

-(void)longPressToDo
{
    if ([_basisInfoEventModel isKindOfClass:[BasisInfoEventModel class]]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"内容"
                                                                       message:_basisInfoEventModel.content
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }]];

        [[self rootViewController] presentViewController:alert animated:YES completion:nil];
    }
}

-(UIViewController *)rootViewController
{
    for (UIView *nextView = self.superview; nextView; nextView = nextView.superview) {
        UIResponder *responder = [nextView nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
