//
//  PassengerContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerContentView.h"
#import "UIView+Toast.h"

@implementation PassengerContentView{
    UIPageControl *pageControl;
    PsnGeneralContentView *psnGeneral;
    PsnSafetyContentView *psnSafety;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
//        self.backgroundColor = [UIColor lightGrayColor];
        CGFloat width =  frame.size.width;
        CGFloat height = frame.size.height;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(width*2, height-50);
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];

        psnGeneral = [[PsnGeneralContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [scrollView addSubview:psnGeneral];
        
        psnSafety = [[PsnSafetyContentView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        [scrollView addSubview:psnSafety];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
        pageControl.center = CGPointMake(width/2, height);
        pageControl.numberOfPages = 2;
        pageControl.userInteractionEnabled = NO;
        pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
        pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
//        pageControl.backgroundColor = [UIColor blueColor];
        [self addSubview:pageControl];//四个按钮
    }
    
    return self;
}

/**
 *  滑动page时的回调
 *
 *  @param scrollView <#scrollView description#>
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
    NSLog(@"%ld",page);
    [pageControl setCurrentPage:page];
    if (page == 0)
    {
        
    }
    else if (page == 1)
    {
        
    }
}
@end
