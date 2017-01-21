//
//  UMECheckBindingResponse.h
//  UMESDKDevelop
//
//  Created by 张博 on 15/11/18.
//  Copyright © 2015年 张博. All rights reserved.
//

#import "UMEBaseResponse.h"

@interface UMECheckBindingResponse : UMEBaseResponse

@property (nonatomic, assign) BOOL isBound;
@property (nonatomic, copy) NSString *sessionId;

@end
