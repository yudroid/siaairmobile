//
//  StringUtils.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "StringUtils.h"

static NSMutableDictionary *ZHDIC;

@implementation StringUtils


/**
 *  判断字符串是否相同
 *
 *  @param s1          s1
 *  @param s2          s2
 *  @param isIgnoreCase YES,忽略大小写，NO不忽略。
 *
 *  @return <#return value description#>
 */
+(BOOL) equals:(NSString *)s1 To:(NSString *)s2 ByIgnoreCase:(BOOL)isIgnoreCase{
    if([self isNullOrWhiteSpace:s1] && [self isNullOrWhiteSpace:s2]){
        return YES;
    }
    
    if(s1 == nil || s2 == nil){
        return NO;
    }
    
    if(isIgnoreCase){
        return [[self trim:s1] caseInsensitiveCompare:[self trim:s2]] == NSOrderedSame;
    }
    else{
        return [[self trim:s1] isEqualToString:[self trim:s2]];
    }
}

/**
 *  判断字符串是否为空或nil
 *
 *  @param s s
 *
 *  @return bool
 */
+(BOOL) isNullOrEmpty:(NSString *)s{
    if(s==nil || [s isEqualToString:@""]){
        return YES;
    }
    else{
        return NO;
    }
}

/**
 *  判断字符串是否为空白或nil
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) isNullOrWhiteSpace:(NSString *)s{
    if(s==nil || [[self trim:s] isEqualToString:@""]){
        return YES;
    }
    else{
        return NO;
    }
}


/**
 *  如果为nil,返回空字符串。
 *  否则去掉前后空白
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(NSString*) trim:(NSString *)s{
    if (s == nil){
        return @"";
    }
    
    if ([[NSNull null] isEqual:s]) {
        return @"";
    }
    
    return [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  判断字符串s1中是否包含s2
 *  如果s1 s2 均为空白，则认为它们等价
 *  @param s1           <#s1 description#>
 *  @param s2           <#s2 description#>
 *  @param isIgnoreCase <#isIgnoreCase description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) contains:(NSString*) s1 To:  (NSString*) s2 ByIgnoreCase:(BOOL) isIgnoreCase{
    if([self isNullOrWhiteSpace:s1] && [self isNullOrWhiteSpace:s2]){
        return YES;
    }
    
    if(s1 == nil || s2 == nil){
        return NO;
    }
    
    if(isIgnoreCase){
        NSRange range = [[[self trim:s1] lowercaseString] rangeOfString: [[self trim:s2] lowercaseString]];
        
        if (range.location != NSNotFound) {
            return YES;
        }
        else{
            return NO;
        }
        
    }
    else{
        NSRange range = [[self trim:s1]  rangeOfString: [self trim:s2]];
        
        if (range.location != NSNotFound) {
            return YES;
        }
        else{
            return NO;
        }
    }
}

/**
 *  @author yangql, 16-02-24 11:02:54
 *
 *  @brief 获取汉字首个拼音字母
 *
 *  @param zh 汉字字符串
 *
 *  @return 第一个字首字母
 */
+ (NSString *)firstCharactor:(NSString *)zh
{
    if(zh==nil || zh.length==0){
        return @"";
    }
    if(ZHDIC == nil){
        ZHDIC = [NSMutableDictionary dictionary];
    }
    
    if([ZHDIC objectForKey:zh] == nil){
        //转成了可变字符串
        NSMutableString *str = [NSMutableString stringWithString:zh];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
        //        //转化为大写拼音
        //        NSString *pinYin = [str capitalizedString];
        //获取并返回首字母
        [ZHDIC setValue:[[str substringToIndex:1] capitalizedString] forKey:zh];
    }
    return [ZHDIC objectForKey:zh];
}


/**
 *  转换为证书
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(int) convertToInt:(NSString *) s{
    @try {
        return [s intValue];
    }
    @catch (NSException *exception) {
        return 0;
    }
}


/**
 *  将url编码 避免html注入
 *
 *  @param s <#s description#>
 *
 *  @return <#return value description#>
 */
+(NSString*) urlEncoding:(NSString*) s{
    if([self isNullOrEmpty:s]){
        return @"";
    }
    else{
        
        return [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}
@end
