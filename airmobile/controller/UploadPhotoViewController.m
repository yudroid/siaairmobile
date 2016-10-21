//
//  UploadPhotoViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/21.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "AbnormalityReportCollectionViewCell.h"

static const NSString *UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER = @"UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER";

@interface UploadPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
    @property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation UploadPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:@"航班详情"];
    [self titleViewAddBackBtn];
    
    // Do any additional setup after loading the view from its nib.
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"AbnormalityReportCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:(NSString *)UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER];
}

    
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AbnormalityReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)UPLOADPHOTO_COLLECTIONCELL_IDENTIFIER forIndexPath:indexPath];
    return cell;
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
