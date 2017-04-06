//
//  HttpFileDown.h
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpFileDown : NSObject

- (void)downFileWithHttpPath:(NSString *)httpPath
Progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                 destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
           completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

@end
