//
//  FlightFliterView.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightFilterView.h"
#import "FlightFilterCollectionViewCell.h"
#import "PersistenceUtils+Business.h"
#import "BasisInfoDictionaryModel.h"
#import "HttpsUtils+Business.h"
#import "KnowledgeBaseTypeModel.h"

const NSString *FLIGHTFILTERVIEW_AREACOLLECTION_IDENTIFIER = @"FLIGHTFILTERVIEW_AREACOLLECTION_IDENTIFIER";
const NSString *FLIGHTFILTERVIEW_STATUSCOLLECTION_IDENTIFIER = @"FLIGHTFILTERVIEW_STATUSCOLLECTION_IDENTIFIER";
const NSString *FLIGHTFILTERVIEW_PROPERTYCOLLECTION_IDENTIFIER = @"FLIGHTFILTERVIEW_PROPERTYCOLLECTION_IDENTIFIER";


@implementation FilghtFilterButton


-(void) awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
-(void)setIsSelected:(Boolean)isSelected
{
    _isSelected = isSelected;
    if (isSelected == YES) {
        [self setBackgroundImage:[UIImage imageNamed:@"FlightFilterbuttonSelected"] forState:UIControlStateNormal];
        self.titleLabel.textColor = [CommonFunction colorFromHex:0XFF17B9E8];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"FlightFilterbuttonNoSelected"] forState:UIControlStateNormal];
        self.titleLabel.textColor = [CommonFunction colorFromHex:0XFF2A2D32];
    }
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

@end



@interface FlightFilterView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *selectedArray;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaLabelLeading;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaLabelTop;
//@property (weak, nonatomic) IBOutlet UICollectionView *areaCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *statusCollectionView;
//@property (weak, nonatomic) IBOutlet UICollectionView *propertyCollectionView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaCollectionViewHeight;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *propertyCollectionViewHeight;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusCollectionViewHeight;

//@property (nonatomic, copy) NSArray<BasisInfoDictionaryModel *> *areaCollectionArray;
@property (nonatomic, copy) NSArray<KnowledgeBaseTypeModel *>  *statusCollectionArray;
//@property (nonatomic, copy) NSArray<BasisInfoDictionaryModel *>  *propertyCollectionArray;

//@property (nonatomic, strong) FlightFilterCollectionViewCell *areaSelectCell;
@property (nonatomic, strong) FlightFilterCollectionViewCell *statusSelectCell;
//@property (nonatomic, strong) FlightFilterCollectionViewCell *propertySelectCell;

@end

@implementation FlightFilterView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _selectedArray = [NSMutableArray array];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }

//    _areaCollectionView.delegate = self;
//    _areaCollectionView.dataSource  = self;
    _statusCollectionView.delegate = self;
    _statusCollectionView.dataSource = self;
//    _propertyCollectionView.delegate = self;
//    _propertyCollectionView.dataSource = self;
//    [_areaCollectionView registerNib:[UINib nibWithNibName:@"FlightFilterCollectionViewCell" bundle:nil]
//          forCellWithReuseIdentifier:(NSString *)FLIGHTFILTERVIEW_AREACOLLECTION_IDENTIFIER];
    [_statusCollectionView registerNib:[UINib nibWithNibName:@"FlightFilterCollectionViewCell" bundle:nil]
            forCellWithReuseIdentifier:(NSString *)FLIGHTFILTERVIEW_STATUSCOLLECTION_IDENTIFIER];
//    [_propertyCollectionView registerNib:[UINib nibWithNibName:@"FlightFilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:(NSString *)FLIGHTFILTERVIEW_PROPERTYCOLLECTION_IDENTIFIER];
//    _areaLabelLeading.constant = px_px_2_2_3(30, 70, 118);

//    NSArray * findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"PlegType"];
//    NSMutableArray *mutableArray = [NSMutableArray array];
//    for (NSDictionary *dic  in findArray) {
//        BasisInfoDictionaryModel *model = [[BasisInfoDictionaryModel alloc]init];
//        [model setValuesForKeysWithDictionary:dic];
//        [mutableArray addObject:model];
//    }
//    _areaCollectionArray = [mutableArray copy];
//    _areaCollectionViewHeight.constant = ((int)(_areaCollectionArray.count/4.0 +0.75))*38-8+ +10;
//    [_areaCollectionView reloadData];

//    [mutableArray removeAllObjects];
//    findArray = [PersistenceUtils findBasisInfoDictionaryWithType:@"FlightStatus"];
//    for (NSDictionary *dic  in findArray) {
//        BasisInfoDictionaryModel *model = [[BasisInfoDictionaryModel alloc]init];
//        [model setValuesForKeysWithDictionary:dic];
//        [mutableArray addObject:model];
//    }
//    _statusCollectionArray = [mutableArray copy];
//    _statusCollectionViewHeight.constant = ((int)(_statusCollectionArray.count/4.0 +0.75))*38-8+ +10;
//    [_statusCollectionView reloadData];
//
//
//    BasisInfoDictionaryModel *propertyTomMoldel = [[BasisInfoDictionaryModel alloc]init];
//    propertyTomMoldel.content = @"普通";
//    BasisInfoDictionaryModel *propertyInlModel = [[BasisInfoDictionaryModel alloc]init];
//    propertyInlModel.content = @"特殊";
//    _propertyCollectionArray = @[propertyTomMoldel,propertyInlModel];
//    _propertyCollectionViewHeight.constant = ((int)(_propertyCollectionArray.count/4.0 +0.75))*38-8+ +10;
//    [_propertyCollectionView reloadData];

    [HttpsUtils searchEQType:^(id responseObj) {
        if (responseObj) {
            _statusCollectionArray = [responseObj DictionaryToModel:[KnowledgeBaseTypeModel class]];
            [_statusCollectionView reloadData];
        }
    } failure:^(id error) {

    }];

}

-(void)adjustPLUS
{
//    _areaLabelTop.constant = 57/3;
}


- (IBAction)cancelButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}
- (IBAction)sureButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
    if ([_delegate respondsToSelector:@selector(flightFilterView:knowledgeBaseType:)]) {
        [_delegate flightFilterView:self knowledgeBaseType:_statusSelectCell.knowledgeBaseTypeModel];
    }
}
- (IBAction)selectButtonClick:(FilghtFilterButton *)sender {
    if(sender.isSelected){
        sender.isSelected = NO;
        if ([_selectedArray containsObject:sender]) {
            [_selectedArray removeObject:sender];
        }
    }else{
        sender.isSelected = YES;
        if (![_selectedArray containsObject:sender]) {
            [_selectedArray addObject:sender];
        }
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

//    if (collectionView == _areaCollectionView) {
//        return _areaCollectionArray.count;
//    }else if(_statusCollectionView == collectionView){
        return _statusCollectionArray.count;
//    }else{
//        return _propertyCollectionArray.count;
//    }

}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-32)/4,30);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (collectionView == _areaCollectionView) {
//        FlightFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)FLIGHTFILTERVIEW_AREACOLLECTION_IDENTIFIER
//                                                                                         forIndexPath:indexPath];
//        cell.contentButton.title = _areaCollectionArray[indexPath.row].content;
//        return cell;
//
//    }else if (collectionView == _propertyCollectionView){
//        FlightFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)FLIGHTFILTERVIEW_PROPERTYCOLLECTION_IDENTIFIER
//                                                                                         forIndexPath:indexPath];
//        cell.contentButton.title = _propertyCollectionArray[indexPath.row].content;
//        return cell;
//    }
//    else{
        FlightFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)FLIGHTFILTERVIEW_STATUSCOLLECTION_IDENTIFIER
                                                                                         forIndexPath:indexPath];
        cell.contentButton.title = _statusCollectionArray[indexPath.row].content;
        cell.knowledgeBaseTypeModel = _statusCollectionArray[indexPath.row];
        return cell;
//    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (collectionView == _areaCollectionView) {
//        if (_areaSelectCell) {
//            _areaSelectCell.isSelected = NO;
//        }
//        _areaSelectCell = (FlightFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        _areaSelectCell.isSelected = YES;
//
//    }else if(_statusCollectionView == collectionView){
        if (_statusSelectCell) {
            _statusSelectCell.isSelected = NO;
        }
        _statusSelectCell = (FlightFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        _statusSelectCell.isSelected = YES;

//    }else{
//        if (_propertySelectCell) {
//            _propertySelectCell.isSelected = NO;
//        }
//        _propertySelectCell = (FlightFilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        _propertySelectCell.isSelected = YES;
//
//    }

}
- (IBAction)flightFilterButtonClick:(id)sender {

//    _areaSelectCell.isSelected = NO;
    _statusSelectCell.isSelected = NO;
//    _propertySelectCell.isSelected = NO;

//    _areaSelectCell = nil;
    _statusSelectCell = nil;
//    _propertySelectCell = nil;

    if ([_delegate respondsToSelector:@selector(flightFilterView:filghtFilterCleanButton:)] ) {
        [_delegate flightFilterView:self filghtFilterCleanButton:sender];
    }
    [self cancelButtonClick:nil];

}

@end
