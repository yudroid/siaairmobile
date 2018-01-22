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
#import "AFAppDotNetAPIClient.h"
#import "AFAppDotNetUpdateFileClient.h"
// 生产网络IP地址

//static NSString* baseUri = @"http://192.168.163.132:8080";
//static NSString* baseUri = @"http://192.168.163.139:8080";
//static NSString* baseUri = @"http://192.168.163.181:8080";

//static NSString* baseUri = @"http://192.168.163.44:8080";
//static NSString* baseUri = @"http://192.168.163.63:8080";
//static NSString* baseUri = @"http://219.134.93.113:8087";
//static NSString* baseUri = @"http://192.168.163.69:80";
//static NSString* baseUri = @"http://219.134.93.113:8087";


//static NSString* baseUri = @"http://192.168.163.126:8080";
//static NSString* baseUri = @"http://192.168.163.153:8080";
//static NSString* baseUri = @"http://192.168.163.181:8080";

//static NSString* baseUri = @"http://192.168.163.152:8080";

//static NSString* baseUri = @"http://192.168.163.132:8080";
//static NSString* baseUri = @"http://219.134.93.113:8087";
//static NSString* baseUri = @"http://219.134.93.113:8087";

//static NSString* baseUri = @"http://10.26.18.75:8080";
//static NSString* baseUri = @"http://219.134.93.113:8087";
//static NSString* baseUri = @"https://219.134.93.113:8086";
//static NSString* baseUri = @"http://10.26.51.41:8080";

//static NSString* baseUri = @"http://192.168.163.69:80";
static NSString* baseUri = @"http://219.134.93.113:8087";


/**
 *  请求响应超时时间间隔 以秒为单位  NSTimeInterval = double
 */
static NSTimeInterval timeInterval = 10;

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

    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClient];
//    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //使用
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;

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

    //    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];

    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
    //    if ([absoluteUrl length]>0 &&[StringUtils equals:[absoluteUrl substringFromIndex:([absoluteUrl length]-1)] To:@"/" ByIgnoreCase:YES]) {
    //        absoluteUrl = [NSString stringWithFormat:@"%@%@",absoluteUrl,[GuidUtils GuidString]];
    //    }
    //    else if ([absoluteUrl length]>0){
    //        absoluteUrl = [NSString stringWithFormat:@"%@/%@",absoluteUrl,[GuidUtils GuidString]];
    //    }
    //    NSLog(@"Post调用地址 %@",absoluteUrl);
    //注：该方法是异步调用的
    [manager POST:[url absoluteString]
       parameters:formData
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
//              NSLog(@"success ----  %@",responseObject);
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
+(void) get:(NSString*) segment
     params:(NSDictionary*) requestData
    success:(void (^) (id)) success
    failure:(void (^) (NSError*)) failure {

    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClient];
//    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

//    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;

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
//    NSLog(@"Get调用地址 %@",absoluteUrl);
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
//                NSLog(@"falied ---- %@",error);
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
+(void) get:(NSString*) segment
     params:(NSDictionary*) requestData
   progress:(void (^)(float progress))progress
    success:(void (^) (id)) success
    failure:(void (^) (NSError*)) failure {

    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClient];
//    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

//    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
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
//    NSLog(@"Get调用地址 %@",absoluteUrl);
    //注：该方法是异步调用的
    [manager GET:absoluteUrl
      parameters:requestData
        progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(downloadProgress.fractionCompleted);
        }
         success:^(NSURLSessionTask* task, id responseObject){
             //NSLog(@"success ----  %@",responseObject);
             if(success){
                 //回调
                 success(responseObject);
             }
         }failure:^(NSURLSessionTask* operation, NSError* error){
//             NSLog(@"falied ---- %@",error);
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

    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClientString];

    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];

    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];
    
    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
//    NSLog(@"Post调用地址 %@",absoluteUrl);
    
    //注：该方法是异步调用的
    [manager POST:absoluteUrl
       parameters:formData
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
              NSString *result = @"";
              if ([responseObject isKindOfClass:[NSData class]]) {
                  result = [[NSString alloc] initWithData:responseObject
                                                 encoding:NSUTF8StringEncoding];
              }
//            NSLog(@"success ----      %@",result);
            if(success){
                //回调
                success(result);
            }
        }failure:^(NSURLSessionTask* operation, NSError* error){
//            NSLog(@"falied ---- %@",error);
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

    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClientString];

    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];
    
    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment relativeToURL: [NSURL URLWithString:baseUri]];
    }
    
    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];
    
    //absoluteUrl = [NSString stringWithFormat:@"%@?uid=%@",absoluteUrl,[GuidUtils GuidString]];
//    NSLog(@"Get调用地址 %@",absoluteUrl);
    
    //注：该方法是异步调用的
    [manager GET:absoluteUrl parameters:requestData
        progress:nil
         success:^(NSURLSessionTask* task, id responseObject){
             NSString *result = @"";
             if([responseObject isKindOfClass:[NSData class]]){
                 result = [[NSString alloc] initWithData:responseObject
                                                          encoding:NSUTF8StringEncoding];
             }
//            NSLog(@"success ----  %@",result);
            if(success){
                //回调
                success(result);
            }
        }failure:^(NSURLSessionTask* operation, NSError* error){
//            NSLog(@"falied ---- %@",error);
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
    
    
//    NSLog(@"Get调用地址 %@",[url absoluteString]);
    
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
//            NSLog(@"falied ---- %@",error);
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
    
//        //导入证书taocares.cer
//        NSString* cerPath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];
//        //读入byte buffer
//        NSData* cerData = [NSData dataWithContentsOfFile:cerPath];
//
//    /*
//
//     AFSecurityPolicy分三种验证模式：
//
//     AFSSLPinningModeNone: 这个模式表示不做SSL pinning
//
//     AFSSLPinningModeCertificate: 这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端的是否一致。
//
//     AFSSLPinningModePublicKey: 这个模式用于证书绑定认证，客户端需要服务器端的证书拷贝，但验证时只验证证书里的公匙，不验证证书的其它信息。
//
//
//     */
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
////    securityPolicy.pinnedCertificates = /*@[cerData];*/[NSSet setWithObjects:cerData, nil];
//
//    return securityPolicy;
    
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}


+(void)postImage {



    
}


+ (void)post:(NSString *)           segment
    filePath:(NSString *)           filePath
     success:(void (^) (id))        success
     failure:(void (^) (NSError*))  failure
{


    AFAppDotNetUpdateFileClient *manager = [AFAppDotNetUpdateFileClient sharedClient];

    //构建url
    NSURL* url = [NSURL URLWithString:baseUri];

    if (![StringUtils isNullOrWhiteSpace:segment]) {
        url = [NSURL URLWithString:segment
                     relativeToURL: [NSURL URLWithString:baseUri]];
    }


//    NSLog(@"Get调用地址 %@",[url absoluteString]);

    //设置响应编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];


    //请求超时时间
    [manager.requestSerializer setTimeoutInterval: timeInterval];
    
    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:[url absoluteString]
       parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    /*

     第一个参数：将要上传的数据的原始路径

     第二个参数：要上传的路径的key

     第三个参数：上传后文件的别名

     第四个参数：原始图片的格式

     */

    [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath]
                               name:@"file"
                           fileName:@"2345.png"
                           mimeType:@"image.jpg"
                              error:nil];

} progress:^(NSProgress * _Nonnull uploadProgress) {

} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    success(responseObject);

} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    failure(error);
    
}];


}


+(NSURL *)imageDownloadURLWithString:(NSString *)path
{
    //
    NSString *urlstring = [NSString stringWithFormat:@"%@%@%@",baseUri,@"/acs/ath/user/download?fileName=",path];
    
    //构建url
    NSURL* url = [NSURL URLWithString:urlstring];

    return url;
}


///无主机名
+(void) postNoDomain:(NSString*)            segment
      params:(id)                   formData
     success:(void (^) (id))        success
     failure:(void (^) (NSError*))  failure  {

    AFAppDotNetAPIClient *manager = [AFAppDotNetAPIClient sharedClient];
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
    NSURL* url = [NSURL URLWithString:segment];



    NSString* absoluteUrl = [StringUtils trim:[url absoluteString]];


    //注：该方法是异步调用的
    [manager POST:[url absoluteString]
       parameters:formData
         progress:nil
          success:^(NSURLSessionTask* task, id responseObject){
//              NSLog(@"success ----  %@",responseObject);
              if(success){
                  //回调success
                  success(responseObject);
              }
          }failure:^(NSURLSessionTask* operation, NSError* error){
//              NSLog(@"falied ---- %@",error);
              if(failure){
                  failure(error);
              }
          }
     ];

}







@end
