//
//  HttpFileDown.m
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "HttpFileDown.h"
#import <AFNetworking.h>

//static NSString* baseUri = @"http://192.168.163.139:8080";
static NSString* baseUri = @"http://219.134.93.113:8087";


static NSString *zsk = @"/acs/dms/KB/download?fileName=";//知识库
static NSString *yxjb = @"/acs/ath/user/download?fileName=../";//运行简报

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


    NSLog(@"请求：%@",request);
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
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseUri,zsk,[httpPath stringByReplacingOccurrencesOfString:@"-" withString:@"/"]]];
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

    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",baseUri,yxjb,[httpPath stringByReplacingOccurrencesOfString:@"-" withString:@"/"]]];
    [self downFileWithURL:URL
                 Progress:downloadProgressBlock
              destination:destination completionHandler:completionHandler];
}


@end
