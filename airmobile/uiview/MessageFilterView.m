//
//  ModifyPwdView.m
//  PopView
//
//  Created by xuesong on 16/12/4.
//  Copyright © 2016年 xuesong. All rights reserved.
//

#import "MessageFilterView.h"
#import "UIImage+ImageEffects.h"
#import "MessageFilterTableViewCell.h"

static const NSString *MESSAGEFILTERVIEW_TABLECELL_IDENTIFIER = @"MESSAGEFILTERVIEW_TABLECELL_IDENTIFIER";

@interface MessageFilterView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray *tableArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation MessageFilterView


-(void)awakeFromNib
{
    [super awakeFromNib];


    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];

    [self contentViewStyle];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];

    [_tableView registerNib:[UINib nibWithNibName:@"MessageFilterTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)MESSAGEFILTERVIEW_TABLECELL_IDENTIFIER];

    _tableArray = @[@"",@"",@"",@"",@""];
    _selectedArray = [NSMutableArray array];
    
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

}

- (IBAction)backgroundClick:(id)sender {
//    NSLog(@"点击");
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MESSAGEFILTERVIEW_TABLECELL_IDENTIFIER];

    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row) {
//        <#statements#>
//    }

}
@end
