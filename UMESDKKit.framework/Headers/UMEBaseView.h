//
//  UMEBaseView.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-4-24.
//  Copyright (c) 2014年 zhangbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMESDKApiDelegate.h"


@interface UMEBaseView : UIView<UIWebViewDelegate>
{
    UIWebView *_contentWebView;
}

@property (nonatomic, assign) id<UMESDKApiDelegate> apiDelegate;

- (void)loadData;

-(void)cancelRequest;

@end
