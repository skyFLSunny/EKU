//
//  ONGDAODB.m
//  ONGHelper
//
//  Created by wzrong on 14-10-31.
//  Copyright (c) 2013年 wzrong@me.com. All rights reserved.
//

#import "ONGDAODB.h"
#import "FMDatabase.h"

@implementation ONGDAODB{
    FMDatabase *db;
    BOOL isKnown;
}

/**
 *  初始化数据库
 *
 *  @param database 数据库名称
 *
 *  @return BOOL值
 */
- (BOOL)initDatabase:(NSString *)databaseName{
    isKnown = YES;
    BOOL isExists;
    
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:databaseName];
    
    isExists = [fm fileExistsAtPath:writableDBPath];
    
    if (!isExists) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:databaseName];

        isExists = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!isExists) {
         
        }
        
        isExists = YES;
    }
    
    if (isExists) {
        db = [FMDatabase databaseWithPath:writableDBPath];
        if ([db open]) {
            [db setShouldCacheStatements:YES];
        }else{
          
            isExists = NO;
        }
    }
    
    return isExists;
}

-(void)deleteDatabase:(NSString *)databaseName {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:databaseName];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
       
        return ;
    }else {
       
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
           
        }else {
          
        }
        
    }
}
/**
 *  获取数据库
 *
 *  @param databaseName 数据库名称
 *
 *  @return FMDatabase
 */
- (FMDatabase *)getDatabase:(NSString *)databaseName{
    
    if ([self initDatabase:databaseName]) {
        return db;
    }
    
    return nil;
}

@end
