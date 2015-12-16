//
//  PLTableViewCell.m
//  LYrecite
//
//  Created by liyao on 15/7/1.
//  Copyright (c) 2015年 liyao. All rights reserved.
//

#import "PLTableViewCell.h"

#import "UIImageView+WebCache.h"
#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)

@implementation PLTableViewCell
{
    UIView *spreateView;
    BOOL isZ;
    UIButton *deleteBtn;
}

+ (instancetype)cellWithTableVieplCell:(UITableView *)tableView
{
    static NSString *repeapID = @"plTableViewCellID";
    PLTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:repeapID];
    if (cell == nil) {
        cell = [[PLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:repeapID];
    }

    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UILabel *contentLable = [[UILabel alloc] init];
        contentLable.numberOfLines = 0;
        [self addSubview:contentLable];
        self.contentLabel = contentLable;
        
        spreateView = [[UIView alloc] init];
        spreateView.alpha =1;
        [self addSubview:spreateView];
        
        UIImageView *imageviewIcon = [[UIImageView alloc] init];
        self.tximage = imageviewIcon;
        [self addSubview:imageviewIcon];
        
        UILabel *userlable = [[UILabel alloc] init];
        [self addSubview:userlable];
        
        self.userLabel  =userlable;
        
        UILabel *pllableV = [[UILabel alloc] init];
        self.pllabel = pllableV;
        [self addSubview:pllableV];
        
        UILabel *flowerCont = [[UILabel alloc] init];
        self.flowerContLable = flowerCont;
        [self addSubview:flowerCont];
        
        UILabel *znumlable = [[UILabel alloc] init];
        self.znum = znumlable;
         [self addSubview:znumlable];
        
        
        UILabel *hfNUm = [[UILabel alloc]init];
        self.hfnum = hfNUm;
        [self addSubview:hfNUm];
        
        UILabel *step = [[UILabel alloc] init];
        self.sep = step;
        [self addSubview:step];
        
        
        UIImageView *imageview = [[UIImageView alloc] init];
        self.imageVie = imageview;
        [self addSubview:imageview];
        
        
        UIButton *zhanbtn = [[UIButton alloc] init];
        self.zbtn= zhanbtn;
        [zhanbtn addTarget:self action:@selector(presspl:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:zhanbtn];
        
        plzhanBtn  *myzhanBTn = [[plzhanBtn  alloc] init];
        self.zhanbtn = myzhanBTn;
        [myzhanBTn addTarget:self action:@selector(presspl:) forControlEvents:UIControlEventTouchDown];
        [self  addSubview:myzhanBTn];
        
        UIButton *wzbtn = [[UIButton alloc] init];
        self.wzbtn= wzbtn;
        [wzbtn addTarget:self action:@selector(pressessay:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:wzbtn];
        self.zbtn.titleLabel.textColor=DAYBACKCOLOR;
        self.zbtn.contentVerticalAlignment=  UIControlContentHorizontalAlignmentRight;
        self.zbtn.titleLabel.textAlignment=NSTextAlignmentRight;
        self.userLabel.textColor = DAYTEXTCOLOR;
    
        self.contentLabel.textColor = DAYTEXTCOLOR;
        self.pllabel.textColor = DAYTEXTCOLOR;
        self.znum.textColor = DAYBACKCOLOR;
        spreateView.backgroundColor = DAYBACKCOLOR;
        self.flowerContLable.textColor = DAYBACKCOLOR;
        self.sep.backgroundColor=DAYBACKCOLOR;
        self.backgroundColor = [UIColor clearColor];
        
      
        self.wzbtn.contentVerticalAlignment=  UIControlContentHorizontalAlignmentRight;
        [self.wzbtn.layer setCornerRadius:5];
        [self.wzbtn.layer setMasksToBounds:YES];
        self.wzbtn.titleLabel.textAlignment=NSTextAlignmentRight;
      
        

    }
    return self;
}
- (void)setModel:(plModelFrame *)model
{
    _model =  model;
    
    self.contentLabel.text = model.model.Content;
  
    NSString  *zhantitle = [NSString stringWithFormat:@"(%d)",_model.model.Flowers] ;
    [self.zhanbtn setTitle:zhantitle forState:UIControlStateNormal];
    [self.zhanbtn setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
  
    
    
    NSURL *url = [NSURL URLWithString:model.model.urlImage];
    [self.tximage  sd_setImageWithURL:url];
    [self setStyle];
    
 

}

-(void)setStyle
{
    NSString* zstr = _isxp?[[NSUserDefaults standardUserDefaults] objectForKey:@"XPZPSTR"]:[[NSUserDefaults standardUserDefaults] objectForKey:@"ZSTR"];
    NSArray* array = [zstr componentsSeparatedByString:@","];
    if ([array containsObject:[NSString stringWithFormat:@"%d",_model.model.NewsReplayID]])
    {
        [self.zhanbtn setImage:[UIImage imageNamed:@"btn_article_flower2.png"]  forState:UIControlStateNormal];
        isZ=YES;
    }
    else
    {
         [self.zhanbtn setImage:[UIImage imageNamed:@"btn_article_flower3.png"]  forState:UIControlStateNormal];
        isZ=NO;
    }
    [self.zhanbtn setTitle:[NSString stringWithFormat:@"(%d)",_model.model.Flowers] forState:UIControlStateNormal] ;
    [self.zhanbtn setTitleColor:DAYBACKCOLOR forState:UIControlStateNormal]  ;
    self.zhanbtn.titleLabel.font=[UIFont systemFontOfSize:10] ;
    // cell.userLabel.text =model.UserID;
    self.contentLabel.text = _model.model.Content;
    self.pllabel.text = [NSString stringWithFormat:@"评论于:%@",_model.model.PubTime];
    self.pllabel.textColor = DAYBACKCOLOR;
    self.pllabel.font=[UIFont systemFontOfSize:10];
    self.contentLabel.font=[UIFont systemFontOfSize:12];
    self.flowerContLable.font=[UIFont systemFontOfSize:10];

    self.userLabel.text =[NSString stringWithFormat:@"%@",_model.model.petName] ;
    self.userLabel.textColor=DAYTOPBACKCOLOR;
     self.userLabel.font=[UIFont systemFontOfSize:10];
    self.backgroundColor = DAYBOTTOMColor;
    self.tximage.backgroundColor=[UIColor clearColor];
    
 
  
  
    
     spreateView.backgroundColor = DAYBACKCOLOR;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)presspl:(UIButton*)sender {
    if ([lyDownLoad networkingCanAceess]==0) {
//         [showErrorView shareWithTtile:@"主人网络断了，赞不了啦！" withFangXiang:1 ];
       
        
        
    }
    else
    {
   
        if (isZ) {
//             [showErrorView shareWithTtile:@"您已经赞过了哦！" withFangXiang:1 ];
            
        }
        else{
            self.plbtn();
            self.model.model.Flowers+=1;
            [self setStyle];
            
            NSString* zstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"ZSTR"];
            NSArray* array = [zstr componentsSeparatedByString:@","];
            if ([array containsObject:[NSString stringWithFormat:@"%d",_model.model.NewsReplayID]])
            {
//                [self.zhanbtn setImage:[UIImage imageWithContentsOfFile:[IMAGEPATH stringByAppendingString:@"/btn_article_flower2.png"]]  forState:UIControlStateNormal];
                isZ=YES;
            }
            
            
            
            else
            {
//                [self.zhanbtn setImage:[UIImage imageWithContentsOfFile:[IMAGEPATH stringByAppendingString:@"/btn_article_flower.png"]]  forState:UIControlStateNormal];
                isZ=NO;
            }

        UIImageView *anmation = sender.imageView;
        
        CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animation];
        anim1.keyPath = @"transform.rotation";
        anim1.values = @[@(Angle2Radian(-20)),  @(Angle2Radian(10)), @(Angle2Radian(-20))];
        anim1.duration = 1;
        // 动画的重复执行次数
        anim1.repeatCount = 6;
        anim1.delegate = self;
        
        [anmation.layer addAnimation:anim1 forKey:@"end"];
        }
        
    }

   
}
- (void)layoutSubviews
{
    self.tximage.frame = _model.imageFrame;
    
    self.userLabel.frame = _model.UserIDFrame;
    
    self.contentLabel.frame = _model.ContentFrame;
    
    self.pllabel.frame  = _model.PubTimeFrame;
    
    self.zbtn.frame = _model.FlowersFrame;
    self.wzbtn.frame  =_model.wzBtn;
    self.flowerContLable.frame = _model.FlowersCountFrame;
    
    self.zhanbtn.frame = _model.zhanbtnFrame;
    [self.tximage.layer setCornerRadius:self.tximage.frame.size.width/2.0];
    [self.tximage.layer setMasksToBounds:YES];
    spreateView.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        return;
    NSString *urlSTr = [NSString stringWithFormat:@"JsonNews.aspx?NewsReplayDelete=%d&NewsID=%d",self.model.model.NewsReplayID,self.model.model.contentId];
    
    NSString* urlstr= [NSString stringWithFormat:@"%@/Support/%@",DOCUMENTYM,urlSTr];
    
    
    NSString  *urlStr1= [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    lyDownLoad* lydown = [[lyDownLoad alloc] init];
    
    [lydown downLoadResource:urlStr1];
    lydown.requestSuccess=^(AFHTTPRequestOperation* op){
        NSData *date = op.responseData;
        NSString *result= [[NSString alloc]initWithData:date encoding:NSUTF8StringEncoding];
        if ([result isEqualToString:@"T"])
        {
            if ([_delegate respondsToSelector:@selector(cellDeleteBtnClick:)]) {
                
                [_delegate cellDeleteBtnClick:self.model];
            }
//               [showErrorView shareWithTtile:@"亲，删除评论成功～！" withFangXiang:0 ];
            
           
        }
        else
        {
//            [showErrorView shareWithTtile:@"亲，删除评论失败了哦～！" withFangXiang:1 ];
            
            
        }
        
    };
    lydown.requestFailed=^(AFHTTPRequestOperation* op)
    {
//        [showErrorView shareWithTtile:@"亲，删除评论失败了哦～！" withFangXiang:1 ];
        
    };
    
    
}

- (void)deleteLiuYan
{
    
    UIAlertView *myaler = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您确定要删除评论信息吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [myaler show];
    
   }

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isKindOfClass:[CAAnimationGroup class]]) {
        
        
    }
    else
    {
        [self.imageVie  removeFromSuperview];
    }
    
    
}
-(void)pressessay:(id)sender
{
   
    

}
- (IBAction)presshf:(id)sender {
    self.hfbtn();
}
@end
