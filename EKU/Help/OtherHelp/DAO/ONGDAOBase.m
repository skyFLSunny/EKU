//
//  ONGDAOBase.m
//  ONGHelper
//
//  Created by wzrong on 14-10-31.
//  Copyright (c) 2013年 wzrong@me.com. All rights reserved.
//

#import "ONGDAOBase.h"
#import "ONGDAODB.h"

@implementation ONGDAOBase

/**
 *  初始化数据库
 *
 *  @param databaseName 数据库名称
 *
 *  @return self
 */
- (id)initWithDatabase:(NSString *)databaseName{
    self = [super init];
    if (self) {
        self.db = [[ONGDAODB alloc] getDatabase:databaseName];
    }
    
    return self;
}

/**
 *  执行SQL语句
 *
 *  @param sql   执行SQL语句 查询、新增、删除、更新
 *  @param table 所在表
 *
 *  @return SQL字符串
 */
- (NSString *)SQL:(NSString *)sql inTable:(NSString *)table{
    return [NSString stringWithFormat:sql, table];
}

@end
