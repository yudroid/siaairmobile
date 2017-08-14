//
//  ResourceOverview.m
//  airmobile
//
//  Created by xuesong on 16/12/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ResourceOverview.h"
#import "ResourceContentView.h"
#import "HomePageService.h"

@interface ResourceOverview ()<UIScrollViewDelegate>

@end

@implementation ResourceOverview
{
    UIImageView *tenDayBackgroundImageView;
    UIImageView *eightMonthBackgroundImageView;
    UILabel     *tenDayLabel;
    UILabel     *eightMonthLabel;
    UIView      *segmentedView;
    UIView      *tenDayImageView;
    UIView      *eightMonthImageView;
    ResourceContentView *tenDayRatioView;
    ResourceContentView *eightMonthRatioView;

    UIScrollView *contentScrollView ;

}

-(instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];

        float y = 6;
        segmentedView = [[UIView alloc]initWithFrame:CGRectMake(10,
                                                                y,
                                                                kScreenWidth-2*10,
                                                                34)];
        [self addSubview:segmentedView];
        UIImageView *segmentedBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                                 0,
                                                                                                 viewWidth(segmentedView),
                                                                                                 viewHeight(segmentedView))];
        segmentedBackgroundImageView.image = [UIImage imageNamed:@"segmentedBackground"];
        [segmentedView addSubview:segmentedBackgroundImageView];
        tenDayImageView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   viewWidth(segmentedView)/2,
                                                                   viewHeight(segmentedView))];
        [segmentedView addSubview:tenDayImageView];


        tenDayBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 viewWidth(tenDayImageView),
                                                                                 viewHeight(tenDayImageView))];
        tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
        [tenDayImageView addSubview:tenDayBackgroundImageView];

        tenDayLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                               0,
                                                               viewWidth(tenDayImageView) ,
                                                               viewHeight(tenDayImageView))
                                               text:@"主机位"
                                               font:33/2
                                      textAlignment:(NSTextAlignmentCenter)
                                       colorFromHex:0xFFFFFFFF];
        [tenDayImageView addSubview:tenDayLabel];

        UIButton *tenDayButton = [[UIButton alloc] initWithFrame:tenDayLabel.frame];
        [tenDayButton addTarget:self
                         action:@selector(buttonClickedWithSender:)
               forControlEvents:(UIControlEventTouchUpInside)];
        tenDayButton.tag = 0;
        [tenDayImageView addSubview:tenDayButton];


        eightMonthImageView = [[UIView alloc ] initWithFrame:CGRectMake(viewWidth(tenDayImageView),
                                                                        0,
                                                                        viewWidth(tenDayImageView),
                                                                        viewHeight(tenDayImageView))];
        [segmentedView addSubview:eightMonthImageView];
        //背景
        eightMonthBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                     0,
                                                                                     viewWidth(eightMonthImageView),
                                                                                     viewHeight(eightMonthImageView))];
        eightMonthBackgroundImageView.image = nil;
        [eightMonthImageView addSubview:eightMonthBackgroundImageView];

        eightMonthLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                   0,
                                                                   viewWidth(tenDayLabel),
                                                                   viewHeight(tenDayLabel))
                                                   text:@"子机位"
                                                   font:33/2
                                          textAlignment:(NSTextAlignmentCenter)
                                           colorFromHex:0xFF17B9E8];
        [eightMonthImageView addSubview:eightMonthLabel];

        UIButton *eightMonthButton = [[UIButton alloc] initWithFrame:eightMonthLabel.frame];
        [eightMonthButton addTarget:self
                             action:@selector(buttonClickedWithSender:)
                   forControlEvents:(UIControlEventTouchUpInside)];
        eightMonthButton.tag = 1;
        [eightMonthImageView addSubview:eightMonthButton];

        //
        contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                          viewBotton(segmentedView),
                                                                          kScreenWidth,
                                                                          kScreenHeight-49-viewBotton(segmentedView)-76)];
        contentScrollView.delegate         = self;
        contentScrollView.contentSize      = CGSizeMake(frame.size.width*2, px_px_2_2_3(400, 500, 750));
        contentScrollView.backgroundColor  = [UIColor clearColor];
        contentScrollView.pagingEnabled    = YES;
        contentScrollView.showsHorizontalScrollIndicator   = NO;
        contentScrollView.showsVerticalScrollIndicator     = NO;


        [self addSubview:contentScrollView];



        tenDayRatioView = [[ResourceContentView alloc] initWithFrame:CGRectMake(0,
                                                                                00,
                                                                                kScreenWidth,
                                                                                viewHeight(contentScrollView))
                                                     seatStatusModel:[HomePageService sharedHomePageService].seatModel
                                                                type:ResourceContentViewTypeMain
                                                            delegate:delegate];
//        tenDayRatioView.backgroundColor = [UIColor yellowColor];
        tenDayRatioView.type = ResourceContentViewTypeMain;
        [contentScrollView addSubview:tenDayRatioView];

        eightMonthRatioView = [[ResourceContentView alloc] initWithFrame:CGRectMake(kScreenWidth,
                                                                                    0,
                                                                                    kScreenWidth,
                                                                                    viewHeight(contentScrollView))

                                                         seatStatusModel:[HomePageService sharedHomePageService].seatModel
                                                                    type:ResourceContentViewTypeSub
                                                                delegate:delegate];

//        eightMonthRatioView.backgroundColor = [UIColor grayColor];
        eightMonthRatioView.type = ResourceContentViewTypeSub;
        [contentScrollView addSubview:eightMonthRatioView];

    }
    return self;
}

-(void) buttonClickedWithSender:(UIButton *)sender
{
    tenDayBackgroundImageView.image = nil;
    eightMonthBackgroundImageView.image = nil;

    switch (sender.tag)
    {
        case 0:
            tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
            eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            tenDayLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];

            [self showTenDayRatioView];
            break;

        case 1:
            eightMonthBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
            tenDayLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
            [self showEightMonthRatioView];
            break;

        default:
            break;
    }
}



-(void) showTenDayRatioView
{
    [UIView animateWithDuration:0.3 animations:^{
        contentScrollView.contentOffset = CGPointMake(0, 0);

    }];


}

-(void) showEightMonthRatioView
{
    [UIView animateWithDuration:0.3 animations:^{
        contentScrollView.contentOffset = CGPointMake(kScreenWidth, 0);

    }];

}


/**
 *  滑动page时的回调
 *
 *  @param scrollview 滑动视图
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview
{

    if (scrollview.contentOffset.x== 0) {
        tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
        eightMonthBackgroundImageView.image = [UIImage imageNamed:@""];
        eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
        tenDayLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
        [self showTenDayRatioView];

    }else{
        eightMonthBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
        tenDayBackgroundImageView.image = [UIImage imageNamed:@""];
        tenDayLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
        eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
        [self showEightMonthRatioView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
