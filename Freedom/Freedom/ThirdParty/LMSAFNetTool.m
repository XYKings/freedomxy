//
//  LMSAFNetTool.m
//  Freedom
//
//  Created by dllo on 16/1/12.
//  Copyright © 2016年 LMS. All rights reserved.
//

#import "LMSAFNetTool.h"
#import <AFNetworking.h>




@implementation LMSAFNetTool


+ (void)getNetWithURL:(NSString *)url
                 body:(id)body
             headFile:(NSDictionary *)headFile
        responseStyle:(LMSResponseStyle)responseStyle
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //    1.  创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    2.  请求头的添加
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    //    3.  返回数据的类型
    switch (responseStyle) {
        case LMSJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case LMSXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LMSDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    //    4.  响应返回数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/javascript", @"application/x-javascript", @"image/jpeg", nil]];
    //    5.  UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //    6.  发送请求
    
    [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.plist", [url hash]]];
        
        [NSKeyedArchiver archiveRootObject:responseObject toFile:filePath];
        
        if (responseObject) {
            success(task, responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.plist", [url hash]]];
        id responseObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"  responseObject    =    %@", responseObject);
        
        if (responseObject) {
            success(task, responseObject);
        } else {
            failure(task, error);
        }
        
        
    }];
}
+ (void)postNetWithURL:(NSString *)url
                  body:(id)body
             bodyStyle:(LMSRequestStyle)requestStyle
              headFile:(NSDictionary *)headFile
         responseStyle:(LMSResponseStyle)responseStyle
               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //    1.  创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    2.  body的类型
    switch (requestStyle) {
        case LMSRequestJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case LMSRequestString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                
                return parameters;
                
            }];
            break;
        default:
            break;
    }
    
    //    3.  请求头的添加
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    
    
    //    4.  返回数据的类型
    switch (responseStyle) {
        case LMSJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case LMSXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LMSDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    //    5.  响应返回数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", @"application/javascript", @"application/x-javascript", @"image/jpeg", nil]];
    //    6.  UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    //    7.  发送请求
    
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.plist", [url hash]]];
        
        [NSKeyedArchiver archiveRootObject:responseObject toFile:filePath];
        
        if (responseObject) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.plist", [url hash]]];
        id responseObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        //        NSLog(@"  responseObject    =    %@", responseObject);
        
        if (responseObject) {
            success(task, responseObject);
        } else {
            failure(task, error);
        }
        
    }];
    
}



@end
