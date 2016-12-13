//
//  ModifyPwdView.m
//  PopView
//
//  Created by xuesong on 16/12/4.
//  Copyright © 2016年 xuesong. All rights reserved.
//

#import "ModifyPwdView.h"
#import "UIImage+ImageEffects.h"

@interface ModifyPwdView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;

@end

@implementation ModifyPwdView


-(void)awakeFromNib
{ 
    [super awakeFromNib];


    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];

    [self contentViewStyle];


    
}

-(void)contentViewStyle
{
    _contentView.layer.cornerRadius = 10;
    _contentView.layer.shadowColor=[UIColor grayColor].CGColor;
    _contentView.layer.shadowOpacity=1;
    _contentView.layer.shadowRadius=10;
    _contentView.layer.shadowOffset = CGSizeMake(0, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,
                                                                            0,
                                                                            _contentView.frame.size.width,
                                                                            _contentView.frame.size.height-30)
                                                    cornerRadius:10.0];

    _contentView.layer.shadowPath = path.CGPath;
    _contentView.layer.masksToBounds = YES;

    _mainContentView.layer.cornerRadius = 10.0;
    _mainContentView.layer.masksToBounds = YES;




}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];


    // Show animation
    [self dropToCenter];

}

- (void)dropToCenter {
    if (!self.contentView) {
        return;
    }

    // Starts at the top
    self.contentCentre.constant = -(self.frame.size.height/2)-(self.contentView.frame.size.height/2);
    [self layoutIfNeeded];

    self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.75 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];

    [self.animator removeAllBehaviors];
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.contentView snapToPoint:self.superview.center];
    snapBehaviour.damping = 0.65;
    [self.animator addBehavior:snapBehaviour];
}


- (void)createBlurBackgroundWithImage:(UIImage *)backgroundImage tintColor:(UIColor *)tintColor blurRadius:(CGFloat)blurRadius {
    [self.backgroundButton setImage:[backgroundImage applyBlurWithRadius:blurRadius tintColor:tintColor saturationDeltaFactor:0.5 maskImage:nil] forState:UIControlStateNormal];
 
}
- (void)dropDown {
    if (!self.contentView) {
        return;
    }

    [self.animator removeAllBehaviors];
    self.contentView.center = self.center;
    CGFloat offsetY = 300.0;
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.contentView snapToPoint:CGPointMake(self.superview.center.x, self.superview.frame.size.height + (self.contentView.frame.size.height / 2.0) + offsetY)];
    [self.animator addBehavior:snapBehaviour];

    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.contentView]];
    dynamicItemBehavior.resistance = 100000;
    [self.animator addBehavior:dynamicItemBehavior];
}


- (IBAction)cancelButtonClick:(id)sender {
    [self dropDown];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0.0;
    }];
    [self endEditing:YES];

}

- (IBAction)backgroundClick:(id)sender {
    [self endEditing:YES];

}
- (IBAction)sureButtonClick:(id)sender {

    [self endEditing:YES];

    if ([_delegate respondsToSelector:@selector(modifyPwdView:sureButtonClick:)]) {
        [_delegate modifyPwdView:self sureButtonClick:sender];
    }
}


@end
