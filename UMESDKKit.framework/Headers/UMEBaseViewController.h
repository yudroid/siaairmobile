//
//  UMEBaseViewController.h
//  umetrip
//
//  Created by Haiming on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UMESDKApiDelegate.h"

@interface UMEBaseViewController : UIViewController<UMESDKApiDelegate>

@property (nonatomic, assign) id<UMESDKApiDelegate> delegate;

-(void)setBackgroundColor:(NSString *) color;

@end
