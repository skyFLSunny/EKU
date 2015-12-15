
#import "DicDBHelper.h"

@implementation DicDBHelper
@synthesize db;

-(void)ExecSql : (NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
        sqlite3_close(db);
    }
}

//-(void)OpenOrCreateDatabase
//{
//    if (sqlite3_open([[self getDocumentsPath] UTF8String], &db)!=SQLITE_OK) {
//        sqlite3_close(db);
//    }
//}
-(BOOL)OpenOrCreateDatabase
{
    NSString *path=[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return NO;
    }
    
    if (sqlite3_open([[self getDocumentsPath] UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        return NO;
    }
    else
        return YES;
}


-(NSString *)getDocumentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *newPath=[[NSString alloc] initWithFormat:@"%@/FindCharacter.db",[paths objectAtIndex:0]];
    return  newPath;
}

@end
