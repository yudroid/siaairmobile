//
//  IntroductionOfActivitiesViewController.h
//  umetrip
//
//  Created by zhangbo on 14-7-21.
//
//

#import "UMEBaseViewController.h"

@interface UMEWebViewController : UMEBaseViewController
{
    UIWebView *_webView;
    UIActivityIndicatorView *_indicatorView;
    NSString *_url;
}

@end
