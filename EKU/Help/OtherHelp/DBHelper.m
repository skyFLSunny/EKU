
#import "DBHelper.h"

@implementation DBHelper

-(void)ExecSql : (NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK) {  
        sqlite3_close(db);
    }
}

-(void)OpenOrCreateDatabase
{
    if (sqlite3_open([[self getDocumentsPath] UTF8String], &db)!=SQLITE_OK) {  
        sqlite3_close(db);
    }
}


-(NSString *)getDocumentsPath{  
    NSString *newPath=[[NSBundle mainBundle] pathForResource:@"Data/android.recite" ofType:@"db"];
    return  newPath;
} 


@end
