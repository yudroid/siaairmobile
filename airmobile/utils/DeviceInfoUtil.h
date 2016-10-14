//
//  DeviceInfoUtil.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#include <sys/sysctl.h>
#include <mach/mach.h>

@interface DeviceInfoUtil : NSObject

+(float)IphoneVersions;//屏幕尺寸粗略判断
+(NSString *)deviceVersions;//设备类型精确判断
+(BOOL)isSystemVersion5OrLater;// 判断设备类型5及以后
+(BOOL)isSystemVersion7OrLater;// 判断设备类型7及以后
+(CGPoint)MidPointWithPoint1:(CGPoint) p1 Point2:(CGPoint)p2; //屏幕中心点
+(NSInteger)MemoryUsed;// 内存使用量
+(NSInteger)MemoryAvailable;// 内存剩余量
+(double) ip6Facto5;// 6到5转换

@end
