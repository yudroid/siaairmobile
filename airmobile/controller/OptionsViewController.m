//
//  OptionsViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OptionsViewController.h"

static const NSString *OPTIONS_COLLECTIONVIEW_INDETIFIER = @"OPTIONS_COLLECTIONVIEW_INDETIFIER";

@interface OptionsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	//titleView订制
	[self titleViewInitWithHight:64];
	self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
	[self titleViewAddTitleText:@"异常上报"];
	[self titleViewAddBackBtn];

	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:(NSString *)OPTIONS_COLLECTIONVIEW_INDETIFIER];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)OPTIONS_COLLECTIONVIEW_INDETIFIER forIndexPath:indexPath];
	cell.contentView.backgroundColor = [UIColor grayColor];
	return cell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 3;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
