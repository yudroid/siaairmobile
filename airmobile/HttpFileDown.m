//
//  HttpFileDown.m
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "HttpFileDown.h"
#import <AFNetworking.h>

//static NSString* baseUri = @"http://192.168.163.66:8080";
//static NSString* baseUri = @"http://192.168.163.132:8080";
static NSString* baseUri = @"https://219.134.93.113:8086";


static NSString *zsk = @"/acs/dms/KB/download?fileName=";//知识库
static NSString *yxjb = @"/acs/ath/user/download?fileName=../";//运行简报
static NSString *chat = @"/acs/um/download?file=";//聊天

@interface HttpFileDown ()

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation HttpFileDown


-(void)downFileWithURL:(NSURL *)url
                   Progress:(void (^)(NSProgress *))downloadProgressBlock
                destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination
          completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{

    //远程地址/acs/ath/user/download?fileName=
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseUri,@"/acs/ath/user/download?fileName=../",[httpPath stringByReplacingOccurrencesOfString:@"-" withString:@"/"]]];
    //    NSURL *URL = [NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png"];
    //    //默认配置
    //    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    //AFN3.0+基于封住URLSession的句柄
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //加上 https ssl验证
    [manager setSecurityPolicy:[self customSecurityPolicy]];

//    NSLog(@"请求：%@",request);
    //下载Task操作
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        downloadProgressBlock(downloadProgress);

        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小

        // 给Progress添加监听 KVO
        //        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        //        // 回到主队列刷新UI
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            // 设置进度条的百分比
        //
        //            self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        //        });

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {

        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径

        //        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        //        return [NSURL fileURLWithPath:path];
        return destination(targetPath,response);

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用

        //        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
        //        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
        //        self.imageView.image = img;
        completionHandler(response,filePath,error);
    }];
    [_downloadTask resume];
}

//知识库

-(void)zskDownFileWithHttpPath:(NSString *)httpPath
                      Progress:(void (^)(NSProgress *))downloadProgressBlock
                   destination:(NSURL *(^)(NSURL *, NSURLResponse *))destination
             completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler
{
    httpPath =  [httpPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseUri,zsk,[httpPath stringByReplacingOccurrencesOfString:@"--" withString:@"/"]]];
    [self downFileWithURL:URL
                 Progress:downloadProgressBlock
              destination:destination completionHandler:completionHandler];

}


//运行简报下载
- (void)yxjbDownFileWithHttpPath:(NSString *)httpPath
                        Progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                     destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
               completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{

    httpPath =  [httpPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseUri,yxjb,[httpPath stringByReplacingOccurrencesOfString:@"--" withString:@"/"]]];
    [self downFileWithURL:URL
                 Progress:downloadProgressBlock
              destination:destination completionHandler:completionHandler];
}

-(void)chatDownFileWithHttpPath:(NSString *)httpPath
                       Progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                    destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
              completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
{
    httpPath =  [httpPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@&fileName=%@",baseUri,chat,httpPath,[[httpPath componentsSeparatedByString:@"/"]lastObject]]];
    [self downFileWithURL:URL
                 Progress:downloadProgressBlock
              destination:destination completionHandler:completionHandler];

}


/**
 *  定制安全策略
 *
 *  @return AFSecurityPolicy
 */
- (AFSecurityPolicy*) customSecurityPolicy{

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


@end
