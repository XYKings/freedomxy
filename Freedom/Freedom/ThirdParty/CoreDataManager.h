//
//  CoreDataManager.h
//  CoreData
//
//  Created by dllo on 16/1/8.
//  Copyright © 2016年 Carlos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject 

+ (instancetype)shareCoreDataManager;

//    被管理对象上下文(数据管理器类)
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//    数据模型器
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//    数据连接器
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//    存储数据到数据库
- (void)saveContext;
//    沙盒路径
- (NSURL *)applicationDocumentsDirectory;

@end
