//
//  StringUtils.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

/**
 *  判断字符串是否相同
 *
 *  @param s1          <#s1 description#>
 *  @param s2          <#s2 description#>
 *  @param isIgnoreCase YES,忽略大小写，NO不忽略。
 *
 *  @return <#return value description#>
 */
+(BOOL) equals:(NSString*) s1 To:  (NSString*) s2 ByIgnoreCase:(BOOL) isIgnoreCase;

/**
 *  是否为空或者nil
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) isNullOrEmpty:(NSString*) s;

/**
 *  判断字符串是否为nil或空白
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) isNullOrWhiteSpace:(NSString*) s;

/**
 *  如果为nil,返回@"";
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(NSString*) trim:(NSString*) s;

+(BOOL) contains:(NSString*) s1 To:  (NSString*) s2 ByIgnoreCase:(BOOL) isIgnoreCase;

/**
 *  @author yangql, 16-02-24 11:02:54
 *
 *  @brief 获取汉字首个拼音字母
 *
 *  @param zh 汉字字符串
 *
 *  @return 第一个字首字母
 */
+ (NSString *)firstCharactor:(NSString *)zh;

/**
 *  转换为证书
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(int) convertToInt:(NSString *) s;

/**
 *  将url编码 避免html注入
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(NSString*) urlEncoding:(NSString*) s;


@end
