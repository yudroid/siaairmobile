//
//  TabBarView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "TabBarView.h"
#import "PersistenceUtils+Business.h"
#import "MessageService.h"

@implementation TabBarIteam
    
-(id)initWithCenter:(CGPoint)center
    {
        self = [super initWithFrame:CGRectMake(0, 0, 24, 37)];
        
        if (self)
        {
            icon        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
            icon.image  = [UIImage imageNamed:@"icon_home.png"];
            [self addSubview:icon];
            
            titleLabel                  = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, 24, 10)];
            titleLabel.text             = @"态势";
            titleLabel.textAlignment    = NSTextAlignmentCenter;
            titleLabel.textColor        = [CommonFunction colorFromHex:0XFF7599C8];
            titleLabel.font             = [UIFont systemFontOfSize:10];
            [self addSubview:titleLabel];
            
            self.center = center;
            
        }
        return self;
    }

-(void)setImage:(UIImage *)image
    {
        icon.image = image;
    }
    
-(void)setText:(NSString *)text
{
        titleLabel.text = text;
}
    
-(void)setTextColor:(UIColor *)textColor
{
        titleLabel.textColor = textColor;
}
    
@end


@implementation TabBarView
{
    int funtionNum;
    int index;
}

-(id)initTabBarWithModel:(TabBarBgModel)model
            selectedType:(TabBarSelectedType)type
                delegate:(id<TabBarViewDelegate>)delegate
    {
        self = [super initWithFrame:CGRectMake(0,
                                               kScreenHeight-49,
                                               kScreenWidth,
                                               49)];
        
        if (self)
        {
            UIView *topline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
            topline.backgroundColor = [CommonFunction colorFromHex:0x5F999999];
            [self addSubview:topline];
            _delegate = delegate;
            funtionNum = [self getFunctionNum]*2;
            index = 1;
            
            
            TabBarIteam *homePage   = [[TabBarIteam alloc] initWithCenter:CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2)];
            homePage.image          = [UIImage imageNamed:@"icon_home.png"];
            homePage.text           = @"态势";
            UIButton *homePageBtn   = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
            homePageBtn.center      = CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2);
            homePageBtn.tag         = 0;
            [homePageBtn addTarget:self
                            action:@selector(iteamBtnClickedWithSender:)
                  forControlEvents:UIControlEventTouchUpInside];
            if ([CommonFunction hasFunction:OV]) {
                [self addSubview:homePage];
                [self addSubview:homePageBtn];
                index ++;
            }
            
            
            
            TabBarIteam *flightPage     = [[TabBarIteam alloc] initWithCenter:CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2)];
            flightPage.image            = [UIImage imageNamed:@"icon_flight.png"];
            flightPage.text             = @"详情";
            UIButton *flightPageBtn     = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
            flightPageBtn.center        = CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2);
            flightPageBtn.tag           = 1;
            [flightPageBtn addTarget:self
                              action:@selector(iteamBtnClickedWithSender:)
                    forControlEvents:UIControlEventTouchUpInside];
            if([CommonFunction hasFunction:FL]){
                [self addSubview:flightPage];
                [self addSubview:flightPageBtn];
                index++;
            }
           
            
            BOOL hasNewMessage = [PersistenceUtils unReadCount]>0;
//            BOOL hasNewMessage = NO;
            
            TabBarIteam *message    = [[TabBarIteam alloc] initWithCenter:CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2)];
            message.image           = [UIImage imageNamed:@"icon_message"];
            message.text            = @"消息";
            newMessage = [CommonFunction imageView:@"newMessage" frame:CGRectMake(0, 0, 7, 7)];
            newMessage.center = CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum+18, 49/2-18);
            newMessage.hidden = !hasNewMessage;
            UIButton *messageBtn    = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
            messageBtn.center       = CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2);
            messageBtn.tag          = 2;
            [messageBtn addTarget:self
                           action:@selector(iteamBtnClickedWithSender:)
                 forControlEvents:UIControlEventTouchUpInside];
            if([CommonFunction hasFunction:MSG]){
                [self addSubview:message];
                [self addSubview:newMessage];
                [self addSubview:messageBtn];
                index++;
            }

            
            TabBarIteam *function   = [[TabBarIteam alloc] initWithCenter:CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2)];
            function.image          = [UIImage imageNamed:@"icon_function.png"];
            function.text           = @"功能";
            UIButton *functionBtn   = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
            functionBtn.center      = CGPointMake(kScreenWidth*(1+(index-1)*2)/funtionNum, 49/2);
            functionBtn.tag         = 3;
            [functionBtn addTarget:self
                            action:@selector(iteamBtnClickedWithSender:)
                  forControlEvents:UIControlEventTouchUpInside];
            
            if([CommonFunction hasFunction:FUNC]){
                [self addSubview:function];
                [self addSubview:functionBtn];
                index++;
            }
            
            
            TabBarIteam *userInfo   = [[TabBarIteam alloc] initWithCenter:CGPointMake(kScreenWidth-kScreenWidth/funtionNum, 49/2)];
            userInfo.image          = [UIImage imageNamed:@"icon_userinfo.png"];
            userInfo.text           = @"设置";
            UIButton *userInfoBtn   = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
            userInfoBtn.center      = CGPointMake(kScreenWidth-kScreenWidth/funtionNum, 49/2);
            userInfoBtn.tag         = 4;
            [userInfoBtn addTarget:self
                            action:@selector(iteamBtnClickedWithSender:)
                  forControlEvents:UIControlEventTouchUpInside];
            if([CommonFunction hasFunction:SET]){
                [self addSubview:userInfo];
                [self addSubview:userInfoBtn];
            }
            
            
            if (model == TabBarBgModelHomePage)
            {
                self.backgroundColor    = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_footer_bg.png"]];
                homePage.textColor      = [CommonFunction colorFromHex:0XFF617087];
                flightPage.textColor    = [CommonFunction colorFromHex:0XFF617087];
                message.textColor       = [CommonFunction colorFromHex:0XFF617087];
                function.textColor      = [CommonFunction colorFromHex:0XFF617087];
                userInfo.textColor      = [CommonFunction colorFromHex:0XFF617087];
                
                switch (type)
                {
                    case TabBarSelectedTypeHomePage:
                    homePage.textColor  = [CommonFunction colorFromHex:0XFF7599c8];
                    homePage.image      = [UIImage imageNamed:@"icon_home_pass"];
                    break;
                        
                    case TabBarSelectedTypeFlight:
                    flightPage.textColor= [CommonFunction colorFromHex:0XFF7599c8];
                    flightPage.image    = [UIImage imageNamed:@"icon_flight_pass"];
                    break;
                        
                    case TabBarSelectedTypeMessage:
                    message.textColor   = [CommonFunction colorFromHex:0XFF7599c8];
                    message.image       = [UIImage imageNamed:@"icon_message_pass"];
                    break;
                    
                    case TabBarSelectedTypeFunction:
                    function.textColor  = [CommonFunction colorFromHex:0XFF7599c8];
                    function.image      = [UIImage imageNamed:@"icon_function_pass"];
                    break;
                    
                    case TabBarSelectedTypeUserInfo:
                    userInfo.textColor  = [CommonFunction colorFromHex:0XFF7599c8];
                    userInfo.image      = [UIImage imageNamed:@"icon_userinfo_pass"];
                    break;
                    
                    default:
                    break;
                }
                
            }
            else
            {
                self.backgroundColor    = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_footer_bg.png"]];
                homePage.image          = [UIImage imageNamed:@"icon_home_light.png"];
                flightPage.image        = [UIImage imageNamed:@"icon_flight_light.png"];
                message.image           = [UIImage imageNamed:@"icon_message_light.png"];
                function.image          = [UIImage imageNamed:@"icon_function_light.png"];
                userInfo.image          = [UIImage imageNamed:@"icon_userinfo_light.png"];
                homePage.textColor      = [CommonFunction colorFromHex:0XFFA0ADC1];
                flightPage.textColor    = [CommonFunction colorFromHex:0XFFA0ADC1];
                message.textColor       = [CommonFunction colorFromHex:0XFFA0ADC1];
                function.textColor      = [CommonFunction colorFromHex:0XFFA0ADC1];
                userInfo.textColor      = [CommonFunction colorFromHex:0XFFA0ADC1];
                
                switch (type)
                {
                    case TabBarSelectedTypeHomePage:
                    homePage.textColor  = [CommonFunction colorFromHex:0XFF3972c3];
                    homePage.image      = [UIImage imageNamed:@"icon_home_pre.png"];
                    break;
                        
                    case TabBarSelectedTypeFlight:
                    flightPage.textColor    = [CommonFunction colorFromHex:0XFF3972c3];
                    flightPage.image        = [UIImage imageNamed:@"icon_flight_pre.png"];
                    break;
                    
                    case TabBarSelectedTypeMessage:
                    message.textColor   = [CommonFunction colorFromHex:0XFF3972c3];
                    message.image       = [UIImage imageNamed:@"icon_message_pre.png"];
                    break;
                    
                    case TabBarSelectedTypeFunction:
                    function.textColor  = [CommonFunction colorFromHex:0XFF3972c3];
                    function.image      = [UIImage imageNamed:@"icon_function_pre.png"];
                    break;
                    
                    case TabBarSelectedTypeUserInfo:
                    userInfo.textColor  = [CommonFunction colorFromHex:0XFF3972c3];
                    userInfo.image      = [UIImage imageNamed:@"icon_userinfo_pre.png"];
                    break;
                    
                    default:
                    break;
                }
            }
            [MessageService sharedMessageService].curTabBarView = self;
        }
        
        return self;
    }
    
-(void)iteamBtnClickedWithSender:(UIButton *)sender
    {
        BOOL hasNewMessage = [PersistenceUtils unReadCount]>0;
        //BOOL hasNewMessage = NO;
        
        [self setHasNewMessage:hasNewMessage];
        
        switch (sender.tag)
        {
            case 0:
            [_delegate selectWithType:TabBarSelectedTypeHomePage];
            break;
            
            case 1:
            [_delegate selectWithType:TabBarSelectedTypeFlight];
            break;
                
            case 2:
            [_delegate selectWithType:TabBarSelectedTypeMessage];
            break;
            
            case 3:
            [_delegate selectWithType:TabBarSelectedTypeFunction];
            break;
            
            case 4:
            [_delegate selectWithType:TabBarSelectedTypeUserInfo];
            break;
            
            default:
            break;
        }
    }

-(int)getFunctionNum
{
    int num=0;
    if([CommonFunction hasFunction:OV]){
        num++;
    }
    if([CommonFunction hasFunction:FL]){
        num++;
    }
    if([CommonFunction hasFunction:MSG]){
        num++;
    }
    if([CommonFunction hasFunction:FUNC]){
        num++;
    }
    if([CommonFunction hasFunction:SET]){
        num++;
    }
    return num==0?1:num;
}

-(void)setHasNewMessage:(BOOL)hasNewMessage
    {
        if (newMessage) {
            if (hasNewMessage)
            {
                newMessage.hidden = NO;
            }
            else
            {
                newMessage.hidden = YES;
            }
        }
        
    }

@end
