//
//  OptionsViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OptionsViewController.h"

static const NSString *OPTIONS_COLLECTIONVIEW_INDETIFIER = @"OPTIONS_COLLECTIONVIEW_INDETIFIER";

@interface OptionsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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

	[_collectionView registerNib:[UINib nibWithNibName:@"OptionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:(NSString *)OPTIONS_COLLECTIONVIEW_INDETIFIER];
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
	return 10;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake((kScreenWidth-32)/4, 50);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(8, 16, 8, 16);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
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
