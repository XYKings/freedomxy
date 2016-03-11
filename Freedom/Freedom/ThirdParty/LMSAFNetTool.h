//
//  LMSAFNetTool.h
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, LMSResponseStyle) {
    LMSJSON,
    LMSXML,
    LMSDATA,
};

typedef NS_ENUM(NSUInteger, LMSRequestStyle) {
    LMSRequestJSON,
    LMSRequestString,
};

@interface LMSAFNetTool : NSObject



/**
 *  get请求
 *
 *  @param url           请求网址
 *  @param body          body体
 *  @param headFile      请求头
 *  @param responseStyle 返回数据类型
 *  @param success       请求成功回调
 *  @param failure       请求失败回调
 */
+ (void)getNetWithURL:(NSString *)url
                 body:(id)body
             headFile:(NSDictionary *)headFile
        responseStyle:(LMSResponseStyle)responseStyle
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 *  post请求
 *
 *  @param url           请求网址
 *  @param body          body体
 *  @param responseStyle body类型
 *  @param headFile      请求头
 *  @param responseStyle 返回数据类型
 *  @param success       请求成功回调
 *  @param failure       请求失败回调
 *
 **/

+ (void)postNetWithURL:(NSString *)url
                  body:(id)body
             bodyStyle:(LMSRequestStyle)requestStyle
              headFile:(NSDictionary *)headFile
         responseStyle:(LMSResponseStyle)responseStyle
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
