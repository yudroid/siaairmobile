//
//  UserManageSoundTableViewCell.m
//  airmobile
//
//  Created by xuesong on 17/3/7.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "UserManageSoundTableViewCell.h"

@implementation UserManageSoundTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)openSwitchValueChanged:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(_openSwitch.isOn) forKey:@"MessageVoice"];
}
@end
