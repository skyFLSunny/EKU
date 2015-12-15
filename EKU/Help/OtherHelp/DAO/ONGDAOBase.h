//
//  ONGDAOBase.h
//  ONGHelper
//
//  Created by wzrong on 14-10-31.
//  Copyright (c) 2013年 wzrong@me.com. All rights reserved.
//
//  Data Access Objects
//  数据访问对象
//  

#import <Foundation/Foundation.h>

@class FMDatabase;

/**
 *  数据访问对象基类
 */
@interface ONGDAOBase : NSObject

@property (nonatomic, strong) FMDatabase *db;

/**
 *  初始化数据库
 *
 *  @param databaseName 数据库名称
 *
 *  @return self
 */
- (id)initWithDatabase:(NSString *)databaseName;

/**
 *  执行SQL语句
 *
 *  @param sql   执行SQL语句 查询、新增、删除、更新
 *  @param table 所在表
 *
 *  @return SQL字符串
 */
- (NSString *)SQL:(NSString *)sql inTable:(NSString *)table;

@end
