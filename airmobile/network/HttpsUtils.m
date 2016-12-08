//
//  HttpsUtils.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HttpsUtils.h"
#import "AFNetworking.h"
#import "StringUtils.h"

// 生产网络IP地址
//static NSString* baseUri = @"http://192.168.163.132:8080";
static NSString* baseUri = @"http://219.134.93.113:8087";

/**
 *  请求响应超时时间间隔 以秒为单位  NSTimeInterval = double
 */
static NSTimeInterval timeInterval = 16;

@implementation HttpsUtils

/**
 *  post请求
 *
 *  @param segment  指定除主网站地址以外的其它部分 如 form/1
 *  @param formData formData 如果没有，传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) post:(NSString*)            segment
      params:(id)                   formData
     success:(void (^) (id))        success
     failure:(void (^) (NSError*))  failure  {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //使用
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //请求超时时间
    [manager.requestSerializer setTimeoutInterval: timeInterval];
    
    //设置请求编码格式
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //设置响应编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    
    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];
    
    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
    //    if ([absoluteUrl length]>0 &&[StringUtils equals:[absoluteUrl substringFromIndex:([absoluteUrl length]-1)] To:@"/" ByIgnoreCase:YES]) {
    //        absoluteUrl = [NSString stringWithFormat:@"%@%@",absoluteUrl,[GuidUtils GuidString]];
    //    }
    //    else if ([absoluteUrl length]>0){
    //        absoluteUrl = [NSString stringWithFormat:@"%@/%@",absoluteUrl,[GuidUtils GuidString]];
    //    }
    NSLog(@"Post调用地址 %@",absoluteUrl);
    //注：该方法是异步调用的
    [manager POST:[url absoluteString]
       parameters:formData
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
              NSLog(@"success ----  %@",responseObject);
              if(success){
                  //回调success
                  success(responseObject);
              }
          }failure:^(NSURLSessionTask* operation, NSError* error){
              NSLog(@"falied ---- %@",error);
              if(failure){
                  failure(error);
              }
          }
     ];
    
}


/**
 *  get 请求
 *
 *  @param segment     指定除主网站地址以外的其它部分 如 form/1
 *  @param requestData request数据，如果没有传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) get:(NSString*) segment params:(NSDictionary*) requestData success:(void (^) (id)) success failure:(void (^) (NSError*)) failure {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //请求超时时间
    [manager.requestSerializer setTimeoutInterval: timeInterval];
    
    //设置请求编码格式
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //设置响应编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    
    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment
                     relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];
    
    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
    NSLog(@"Get调用地址 %@",absoluteUrl);
    //注：该方法是异步调用的
    [manager GET:absoluteUrl
      parameters:requestData
        progress:nil
         success:^(NSURLSessionTask* task, id responseObject){
        //NSLog(@"success ----  %@",responseObject);
            if(success){
                //回调
                success(responseObject);
            }
            }failure:^(NSURLSessionTask* operation, NSError* error){
                NSLog(@"falied ---- %@",error);
            if(failure){
                //回调
                failure(error);
            }
    }];
    
}


/**
 *  post请求
 *
 *  @param segment  指定除主网站地址以外的其它部分 如 form/1
 *  @param formData formData 如果没有，传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) postString:(NSString*)              segment
            params:(NSDictionary*)          formData
           success:(void (^) (id))          success
           failure:(void (^) (NSError*))    failure  {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //使用
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求超时时间
    [manager.requestSerializer setTimeoutInterval: timeInterval];
    
    //设置请求编码格式
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //设置响应编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    
    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];
    
    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
    NSLog(@"Post调用地址 %@",absoluteUrl);
    
    //注：该方法是异步调用的
    [manager POST:absoluteUrl
       parameters:formData
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
            NSString *result = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
            NSLog(@"success ----  %@",result);
            if(success){
                //回调
                success(result);
            }
        }failure:^(NSURLSessionTask* operation, NSError* error){
            NSLog(@"falied ---- %@",error);
            if(failure){
                failure(error);
            }
    }];
    
}


/**
 *  get 请求
 *
 *  @param segment     指定除主网站地址以外的其它部分 如 form/1
 *  @param requestData request数据，如果没有传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) getString:(NSString*)               segment
           params:(NSDictionary*)           requestData
          success:(void (^) (id))           success
          failure:(void (^) (NSError*))     failure {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求超时时间
    [manager.requestSerializer setTimeoutInterval: timeInterval];
    
    //设置请求编码格式
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //设置响应编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    
    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];
    
    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
    NSLog(@"Get调用地址 %@",absoluteUrl);
    
    //注：该方法是异步调用的
    [manager GET:absoluteUrl parameters:requestData
        progress:nil
         success:^(NSURLSessionTask* task, id responseObject){
            NSString *result = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
            NSLog(@"success ----  %@",result);
            if(success){
                //回调
                success(result);
            }
        }failure:^(NSURLSessionTask* operation, NSError* error){
            NSLog(@"falied ---- %@",error);
            if(failure){
                //回调
                failure(error);
            }
    }];
    
}


/**
 *  get 请求
 *
 *  @param segment     指定除主网站地址以外的其它部分 如 form/1
 *  @param requestData request数据，如果没有传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) getXml:(NSString*)              segment
        params:(NSDictionary*)          requestData
       success:(void (^) (id))          success
       failure:(void (^) (NSError*))    failure {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    //请求超时时间
    [manager.requestSerializer setTimeoutInterval: timeInterval];
    
    //设置请求编码格式
    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //设置响应编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    
    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    
    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment
                     relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    
    NSLog(@"Get调用地址 %@",[url absoluteString]);
    
    //注：该方法是异步调用的
    [manager GET:[url absoluteString]
      parameters:requestData
        progress:nil success:^(NSURLSessionTask* task, id responseObject){
            //NSLog(@"success ----  %@",responseObject);
            if(success){
                //回调
                success(responseObject);
            }
        }failure:^(NSURLSessionTask* operation, NSError* error){
            NSLog(@"falied ---- %@",error);
            if(failure){
                //回调
                failure(error);
            }
    }];
    
}

/**
 *  获取基地址
 *
 *  @return <#return value description#>
 */
+(NSString*) getBaseUri{
    return baseUri;
}


#pragma mark -辅助私有方法

/**
 *  定制安全策略
 *
 *  @return AFSecurityPolicy
 */
+ (AFSecurityPolicy*) customSecurityPolicy{
    
    //    //导入证书taocares.cer
    //    NSString* cerPath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"cer"];
    //    //读入byte buffer
    //    NSData* cerData = [NSData dataWithContentsOfFile:cerPath];
    
    /*
     
     AFSecurityPolicy分三种验证模式：
     
     AFSSLPinningModeNone: 这个模式表示不做SSL pinning
     
     AFSSLPinningModeCertificate: 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端的是否一致。
     
     AFSSLPinningModePublicKey: 这个模式用于证书绑定认证，客户端需要服务器端的证书拷贝，但验证时只验证证书里的公匙，不验证证书的其它信息。
     
     
     */
//    //使用证书验证模式
//    AFSecurityPolicy* securityPolicy  = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    
//    //允许无效证书（也就是自建证书）
//    securityPolicy.allowInvalidCertificates = YES;
//    
//    //不验证域名
//    securityPolicy.validatesDomainName = NO;
//    
//    //把服务端证书(需要转换成cer格式)放到APP项目资源里，AFSecurityPolicy会自动寻找根目录下所有cer文件
//    //证书
//    //securityPolicy.pinnedCertificates = /*@[cerData];*/[NSSet setWithObjects:cerData, nil];
//    
//    return securityPolicy;
    return nil;
}

@end
