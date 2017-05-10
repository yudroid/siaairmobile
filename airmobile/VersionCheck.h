//
//  VersionCheck.h
//  airmobile
//
//  Created by xuesong on 17/4/10.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionCheck : NSObject

+(void)versionCheck:(UIViewController *)viewController;
+(void)versionCheckWithViewController:(UIViewController*) viewController
                         isNewVersion:(void (^)(void) )newVersion
                          httpFailuer:(void (^)(NSError *error)) failer;

@end
