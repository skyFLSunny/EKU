//
//  TYHShowContenModel.m
//  HppleDemo
//
//  Created by tanyuehong on 15/10/15.
//
//

#import "TYHShowContenModel.h"

@implementation TYHShowContenModel

- (id)init
{
    self = [super init];
    
    if (self )
    {
        self.textFont = [UIFont systemFontOfSize:12];
        
        self.jianju = 5;
        
        self.kongjianSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
        
        self.textColor = [UIColor blackColor];
        
        self.backgroudColor = [UIColor whiteColor];
        
        self.mathFlag = 0;
        
        self.lineSpace = 0;
        
        self.magrging =  6;
        
        self.baseUrl = @"pic";
        
    }
    return  self;
}

@end
