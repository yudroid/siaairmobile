//
//  UMEBindingRequest.h
//  UMESDKDevelop
//
//  Created by 张博 on 15/11/18.
//  Copyright © 2015年 张博. All rights reserved.
//

#import "UMEBaseReq.h"

@interface UMEBindingRequest : UMEBaseReq

@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *userIdentifier;



@end
