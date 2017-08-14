//
//  OperationSituationView.h
//  airmobile
//
//  Created by xuesong on 17/3/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationSituationView : UIView
@property (weak, nonatomic) IBOutlet UILabel *planLabel;
@property (weak, nonatomic) IBOutlet UILabel *realLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *planNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;


-(void)reDraw:(NSArray *)array;
@end
