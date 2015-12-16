//
//  ONGDAODB.h
//  ONGHelper
//
//  Created by wzrong on 14-10-31.
//  Copyright (c) 2013年 wzrong@me.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

/**
 *  数据访问对象DB
 */
@interface ONGDAODB : NSObject

/**
 *  初始化数据库
 *
 *  @param databaseName 数据库名称
 *
 *  @return 初始化是否成功
 */
- (BOOL)initDatabase:(NSString *)databaseName;
-(void)deleteDatabase:(NSString *)databaseName;
/**
 *  获取数据库
 *
 *  @param databaseName 数据库名称
 *
 *  @return FMDatabase
 */
- (FMDatabase *)getDatabase:(NSString *)databaseName;

@end
