
#import <Foundation/Foundation.h>

@interface LrcToDictionary : NSObject
{
    NSMutableArray *_arrayTemp; // 临时的数组，用来存储每次迭代后的数据
    NSMutableArray *_arrayItemList; // 存储解析后的数据
}


@property(nonatomic,copy)NSMutableArray *_arrayTemp;
@property(nonatomic,copy)NSMutableArray *_arrayItemList;


-(void)LoadData:(NSString *)txtLrc;

@end
