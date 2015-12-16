//
//  plView.m
//  EKU
//
//  Created by 李瑶 on 15/12/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "plView.h"
#import "TopView.h"
@implementation plView
{
    UITextField *text;
    TopView* headerView;
    UIButton* cancelBtn;
    NSMutableArray* dataArray;
}
- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initHeader];
        [self initText];
        [self initTable];
        //        [self setStyle];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return  self;
}
-(void) initText
{
    text = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, SCREENWIDTH-20, 70)];
    text.delegate = self;
    text.backgroundColor=DAYBOTTOMColor;
    text.textColor=DAYTEXTCOLOR;
    text.placeholder = @"亲，评论一番吧！";
    text.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 0)];
    //设置显示模式为永远显示(默认不显示)
    text.leftViewMode = UITextFieldViewModeAlways;
    text.returnKeyType = UIReturnKeySend;
    text.layer.borderColor = DAYBACKCOLOR.CGColor;
    text.layer.borderWidth = 0.8;
    [text.layer setCornerRadius:10];
    [text.layer setMasksToBounds:YES];

    [self addSubview:text];
    
   
    
}

-(void)initTable
{
    PLLIst* pl  = [[PLLIst alloc] initWithFrame:CGRectMake(0, 125, SCREENWIDTH, self.frame.size.height-125)];
    UITapGestureRecognizer* tap= [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(hideKeyBoard:)];
    
    _plView = pl;
    [_plView addGestureRecognizer:tap];

    [self addSubview:_plView];
    
}
-(void)initHeader
{
    headerView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45) withTitle:@"评论"];
   
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame  =CGRectMake(SCREENWIDTH-50, 0, 45, 45);
    [cancelBtn setImage:[UIImage imageNamed:@"btn_error2.png"] forState:UIControlStateNormal];
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [cancelBtn addTarget:self  action:@selector(pressCancel:) forControlEvents:UIControlEventTouchUpInside];
   
    [headerView addSubview:cancelBtn];
    
    [self addSubview:headerView];
}

#pragma  事件处理
-(void)pressCancel:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.hidden=YES;
        [text resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANSCROLL" object:self userInfo:nil];
    }];
}

-(void)hideKeyBoard:(UIGestureRecognizer*)tap
{
    text.text = @"";
    [text resignFirstResponder];
}
#pragma mark delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self presstj];
 
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
      text.text = @"";
    [text resignFirstResponder];
}

-(void)initPLRequest:(NSString*)urlStr
{
    
    lyDownLoad* lydown = [[lyDownLoad alloc] init];
    __weak plView* viewCon = self;
    [lydown downLoadResource:urlStr];
    lydown.requestFailed = ^(AFHTTPRequestOperation* op){
        [showErrorView shareWithTtile:@"世界最遥远的距离，就是没有网络"withFangXiang:1 ];
       
    };
    lydown.requestSuccess = ^(AFHTTPRequestOperation* op){
        NSString* str = [[NSString alloc] initWithData:op.responseData encoding:NSUTF8StringEncoding];
        if ([str isEqualToString:@"T"]) {
           
            text.text = @"";
            [showErrorView shareWithTtile:@"评论成功" withFangXiang:0]  ;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGEPL" object:nil];
           
            
        }
        else if ([str isEqualToString:@"F"])
        {
            [showErrorView shareWithTtile:@"亲，提交失败了哦～" withFangXiang:1 ];
           
            
            
        }
        else
        {
            [showErrorView shareWithTtile:@"亲，提交次数过多了哦～" withFangXiang:1 ];
            
        }
        
        
    };
    
    
}


#pragma mark 代理


- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    return YES;
}



#pragma mark 事件处理
-(void)presstj
{
    
        NSString* url =[NSString stringWithFormat:@"%@/Support/JsonNews.aspx?NewsReplayAdd=yes&UserID=99954&NewsID=%d&Content=%@",DOCUMENTYM,@"12345" ,[text.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if (text.text.length>=2&&text.text.length<=100)
        {
            url =[NSString stringWithFormat:@"%@/Support/JsonNews.aspx?NewsReplayAdd=yes&UserID=99954&NewsID=%d&Content=%@",DOCUMENTYM,3998 ,[text.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
            
            [self initPLRequest:url];
            
        }
        else
        {
            [showErrorView shareWithTtile:@"亲，不能少于两个字多于一百个字哦～" withFangXiang:1];
            
            
        }
        


}


@end
