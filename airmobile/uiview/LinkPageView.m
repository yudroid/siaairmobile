//
//  LinkPageView.m
//  airmobile
//
//  Created by xuesong on 16/12/14.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "LinkPageView.h"

@interface LinkPageView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@end


@implementation LinkPageView

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSArray *images=@[@"LinkPage1",@"LinkPage2",@"LinkPage3",@""];
    _pageControl.numberOfPages = images.count-1;
    _scrollView.contentSize = CGSizeMake(images.count * kScreenWidth, kScreenHeight);
    for (int i = 0 ;i<images.count;i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [UIImage imageNamed:images[i]];
        [_scrollView addSubview:imageView];
    }
    _scrollView.delegate = self;
}




-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger number = scrollView.contentOffset.x/kScreenWidth;
    _pageControl.currentPage = number;
    if (number == _pageControl.numberOfPages) {
        self.hidden = YES;
    }
}

@end
