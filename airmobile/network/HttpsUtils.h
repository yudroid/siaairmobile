//
//  HttpsUtils.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsUtils : NSObject

/**
 *  post请求 返回结果为json格式
 *
 *  @param segment  指定除主网站地址以外的其它部分 如 form/1
 *  @param formData formData 如果没有，传nil (NSDictionary*) 
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) post:(NSString*)            segment
      params:(id)                   formData
     success:(void (^) (id))        success
     failure:(void (^) (NSError*))  failure ;

/**
 *  get 请求 返回结果为json格式
 *
 *  @param segment     指定除主网站地址以外的其它部分 如 form/1
 *  @param requestData request数据，如果没有传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) get:(NSString*)             segment
     params:(NSDictionary*)         requestData
    success:(void (^) (id))         success
    failure:(void (^) (NSError*))   failure ;


/**
 *  get 请求 返回结果为json格式 加进度
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
    failure:(void (^) (NSError*)) failure;


/**
 *  post请求 返回结果为string格式
 *
 *  @param segment  指定除主网站地址以外的其它部分 如 form/1
 *  @param formData formData 如果没有，传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) postString:(NSString*)              segment
            params:(NSDictionary*)          formData
           success:(void (^) (id))          success
           failure:(void (^) (NSError*))    failure ;

/**
 *  get 请求 返回结果为string格式
 *
 *  @param segment     指定除主网站地址以外的其它部分 如 form/1
 *  @param requestData request数据，如果没有传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) getString:(NSString*)               segment
           params:(NSDictionary*)           requestData
          success:(void (^) (id))           success
          failure:(void (^) (NSError*))     failure ;

/**
 *  get 请求 返回结果为xml格式
 *
 *  @param segment     指定除主网站地址以外的其它部分 如 form/1
 *  @param requestData request数据，如果没有传nil
 *  @param success     success回调
 *  @param failure     failure回调
 */
+(void) getXml:(NSString*)              segment
        params:(NSDictionary*)          requestData
       success:(void (^) (id))          success
       failure:(void (^) (NSError*))    failure ;

/**
 *  获取基地址
 *
 *  @return return value description
 */
+(NSString*) getBaseUri;


+ (void)post:(NSString *)           segment
    filePath:(NSString *)           filePath
     success:(void (^) (id))        success
     failure:(void (^) (NSError*))  failure ;


+(NSURL *)imageDownloadURLWithString:(NSString *)path;
@end
