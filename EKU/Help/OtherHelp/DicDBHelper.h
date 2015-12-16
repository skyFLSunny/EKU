#import "sqlite3.h"
#import <Foundation/Foundation.h>

@interface DicDBHelper : NSObject
{
    sqlite3 *db;
}

@property  sqlite3 *db;

-(NSString *)getDocumentsPath;
//-(void)OpenOrCreateDatabase;
-(BOOL)OpenOrCreateDatabase;

@end
