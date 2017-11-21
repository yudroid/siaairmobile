//
//  RootModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import <objc/runtime.h>

@implementation RootModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:[self nullHandleDictionary:dictionary]];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    return;
}

-(BOOL)isNull:(NSDictionary *)data
{
    return (data == nil
            || ([data isKindOfClass:[NSArray class]] && [data count]==0)
            || ([data isKindOfClass:[NSDictionary class]] && [[data allKeys] count]==0));
}


///将dictionary中的null转化为对应属性类型的值
-(NSDictionary *)nullHandleDictionary:(NSDictionary *)dictionary
{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        NSArray *allKeys = [dictionary allKeys];
        NSMutableDictionary *mdictionary = [[NSMutableDictionary alloc]initWithDictionary:dictionary];
        for (NSString *key in allKeys) {
            if ([[dictionary objectForKey:key] isKindOfClass:[NSNull class]]) {
                objc_property_t property = class_getProperty([self class], [key UTF8String]);
                if(property != NULL){
                    const char *type = property_getAttributes(property);
                    NSString *name = [NSString stringWithUTF8String:type];
                    NSArray *array = [name componentsSeparatedByString:@"@\""];
                    if (array.count>=2) {
                        NSArray *handleArray = [array[1] componentsSeparatedByString:@"\""];
                        if (handleArray.count>=1) {
                            NSString *className = handleArray[0];
                            Class someClass = NSClassFromString(className);
                            id obj = [[someClass alloc] init];
                            [mdictionary setObject:obj forKey:key];
                        }
                    }else if(array.count ==1){
                        [mdictionary setObject:@0 forKey:key];
                    }
                }
            }
        }
        return [mdictionary copy];
    }
    return  [[NSDictionary alloc] init];
}

@end
