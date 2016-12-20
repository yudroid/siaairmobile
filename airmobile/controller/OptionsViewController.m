//
//  OptionsViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OptionsViewController.h"
#import "OptionCollectionViewCell.h"
#import "PersistenceUtils+Business.h"
#import "BasisInfoEventModel.h"


static const NSString *OPTIONS_COLLECTIONVIEW_INDETIFIER = @"OPTIONS_COLLECTIONVIEW_INDETIFIER";

@interface OptionsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//自定义
@property (nonatomic, assign) OptionsType optionsType;
@property (nonatomic, strong) NSArray *collectionArray;


@end

@implementation OptionsViewController

-(instancetype)initWithOptionType:(OptionsType)optionsType
{
	self = [super init];
	if (self) {
		_optionsType = optionsType;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	[self initTitle];

	_collectionView.delegate = self;
	_collectionView.dataSource = self;



	switch (_optionsType) {

		case OptionsTypeType:
		{
			NSMutableArray *mutableArray = [NSMutableArray  array];
			NSArray *findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"EventType"];
			for (NSDictionary *dic  in findArray) {
				BasisInfoDictionaryModel *model = [[BasisInfoDictionaryModel alloc]initWithDictionary:dic];
				[mutableArray addObject:model];
			}
			_collectionArray = [mutableArray copy];
			break;
		}
		case OptionsTypeEvent:
		{
			NSMutableArray *mutableArray = [NSMutableArray  array];
			NSArray *findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"DispatchType"];
			int Id = -1;
			for (NSDictionary *dic in findArray) {
				if ([[dic objectForKey:@"content"] isEqualToString:_dispatchType]) {
					Id = [[dic objectForKey:@"basisidid"] intValue];
				}
			}
			[mutableArray removeAllObjects];
			if (Id != -1) {
				NSArray *findEventArray = [PersistenceUtils findBasisInfoEventWithEventId:_event_type
																			   dispatchId:Id
																			   eventLevel:_event_level];
				for (NSDictionary *dic in findEventArray) {
					BasisInfoEventModel *model = [[BasisInfoEventModel alloc]initWithDictionary:dic];
					[mutableArray addObject:model];
				}
				_collectionArray = [mutableArray copy];

			}
			break;
			
		}
		case OptionsTypeEventLevel:
		{
			NSMutableArray *mutableArray = [NSMutableArray  array];
			NSArray *findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"EventLevel"];
			for (NSDictionary *dic  in findArray) {
				BasisInfoDictionaryModel *model = [[BasisInfoDictionaryModel alloc]initWithDictionary:dic];
				[mutableArray addObject:model];
			}
			_collectionArray = [mutableArray copy];
			break;
		}
		default:

			break;
	}


	[_collectionView registerNib:[UINib nibWithNibName:@"OptionCollectionViewCell" bundle:nil]
	  forCellWithReuseIdentifier:(NSString *)OPTIONS_COLLECTIONVIEW_INDETIFIER];
}



-(void)initTitle
{
	//titleView订制
	[self titleViewInitWithHight:64];
	self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
	[self titleViewAddTitleText:@"异常上报"];
	[self titleViewAddBackBtn];
//	UIButton *finshButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-10-22, 33, 22, 20)];

//	[finshButton setTitle:@"完成"  forState:UIControlStateNormal];
//	[finshButton addTarget:self action:@selector(finshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//	[self.titleView addSubview:finshButton];

}

//-(void)finshButtonClick:(UIButton *)sender
//{
//	if (_delegate && [_delegate respondsToSelector:@selector(optionsViewControllerFinshedOptionType:Value:)]) {
//		[_delegate optionsViewControllerFinshedOptionType:_optionsType Value:];
//	}
//	[self.navigationController popViewControllerAnimated:YES];
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	OptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)OPTIONS_COLLECTIONVIEW_INDETIFIER
																			   forIndexPath:indexPath];
	cell.contentView.backgroundColor = [UIColor grayColor];
	if (_optionsType == OptionsTypeEvent) {
		cell.basisInfoEventModel = _collectionArray[indexPath.row];

	}else{
		cell.basisInfoDictionaryModel = _collectionArray[indexPath.row];

	}

	return cell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _collectionArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *content = @"";
	if (_optionsType == OptionsTypeEvent) {
		content = ((BasisInfoEventModel *)_collectionArray[indexPath.row]).event;

	}else{
		content = ((BasisInfoDictionaryModel *)_collectionArray[indexPath.row]).content;

	}
	CGSize size = [content boundingRectWithSize:CGSizeMake((kScreenWidth-32), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:15.0 ]} context:nil].size;
	return CGSizeMake((kScreenWidth-32), size.height+8);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(8, 16, 8, 16);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 8;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ([_delegate respondsToSelector:@selector(optionsViewControllerFinshedOptionType:Value:)]) {
		[_delegate optionsViewControllerFinshedOptionType:_optionsType
													Value:_collectionArray[indexPath.row]];
	}
	[self.navigationController popViewControllerAnimated:YES];
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
