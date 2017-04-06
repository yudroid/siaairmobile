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
#import "XRWaterfallLayout.h"
#import "NSString+Size.h"


static const NSString *OPTIONS_COLLECTIONVIEW_INDETIFIER = @"OPTIONS_COLLECTIONVIEW_INDETIFIER";

@interface OptionsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>
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
//			NSArray *findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"DispatchType"];
//			int Id = -1;
//			for (NSDictionary *dic in findArray) {
//				if ([[dic objectForKey:@"content"] isEqualToString:_dispatchType]) {
//					Id = [[dic objectForKey:@"basisidid"] intValue];
//				}
//			}
			[mutableArray removeAllObjects];

				NSArray *findEventArray = [PersistenceUtils findBasisInfoEventWithEventId:_controlType
																			   eventLevel:_ensureType];
				for (NSDictionary *dic in findEventArray) {
					BasisInfoEventModel *model = [[BasisInfoEventModel alloc]initWithDictionary:dic];
					[mutableArray addObject:model];
				}
				_collectionArray = [mutableArray copy];


			break;
		}
		case OptionsTypeEventLevel:
		{
			NSMutableArray *mutableArray = [NSMutableArray  array];
			NSArray *findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"DispatchType"];
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

	XRWaterfallLayout *waterFall = (XRWaterfallLayout *)_collectionView.collectionViewLayout;
	waterFall.columnCount = _collectionArray.count>=3?3:_collectionArray.count;
	[waterFall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
	waterFall.delegate = self;
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
	return CGSizeMake((kScreenWidth-32), size.height?:20+8);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if ([_delegate respondsToSelector:@selector(optionsViewControllerFinshedOptionType:Value:)]) {
		[_delegate optionsViewControllerFinshedOptionType:_optionsType
													Value:_collectionArray[indexPath.row]];
	}
	[self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath
{
	NSString *contentText ;
	if (_optionsType == OptionsTypeEvent) {
		contentText = ((BasisInfoEventModel *)_collectionArray[indexPath.row]).event;


	}else{
		contentText = ((BasisInfoEventModel *) _collectionArray[indexPath.row]).content;
	}
	return [contentText sizeWithWidth:itemWidth-16 font:[UIFont fontWithName:@"PingFang SC" size:15]].height+16;
}


@end
