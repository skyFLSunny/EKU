
#import "sqlite3.h"

@interface DBHelper : NSObject
{
    sqlite3 *db;
}

-(NSString *)getDocumentsPath;
-(void)OpenOrCreateDatabase;

@end
