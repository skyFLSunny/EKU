#import <Foundation/Foundation.h>
#import "DBHelper.h"

@interface Helper : NSObject
{
    sqlite3 *db;
    DBHelper *dbHelper;
}
//页码和字体的管理
-(int)getSubjectPagerValue:(NSString *)key;
-(void)setSubjectPagerValue : (int) data : (NSString *)key ;
-(void)getPfinfo;
- (UIImage*) getBrighterImage:(UIImage *)originalImage;
//收藏夹管理
-(NSMutableArray *)getFavorArray;
-(void)addFavorValue : (int) data ;
-(void)delFavorValue : (int) data ;
-(NSString *)getOutFilePath;
-(UIColor*) colorWithRGBHexString:(NSString*)rgbColor withAlpha:(float)al;

//获得WEB方式管理中web源文件保存的路径
-(NSString *)getWebServerPath;

-(NSString *)getAjax:(NSString *)url;


//应用内购买
-(void)setBuy : (NSString *) strKey ;
-(NSString *) getBuy ;


//获得缓存的路径
-(NSString *)getCachePath;

//获得分类缓存的字符串
-(NSString *)getSortCacheString;
//缓存分类的字符串
-(void)setSortCacheString : (NSString *)strJson;

@end
