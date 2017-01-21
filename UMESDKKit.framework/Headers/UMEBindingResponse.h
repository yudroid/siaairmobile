//
//  UMEBindingResponse.h
//  UMESDKDevelop
//
//  Created by 张博 on 15/11/18.
//  Copyright © 2015年 张博. All rights reserved.
//

#import "UMEBaseResponse.h"

@interface UMEBindingResponse : UMEBaseResponse

@property (nonatomic, assign) BOOL isBindingSuccess;
@property (nonatomic, copy) NSString *sessionId;


@end
