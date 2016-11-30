//
//  PsnSafetyAreaView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PsnSafetyAreaView : UIView<UITableViewDelegate,UITableViewDataSource>

-(instancetype) initWithFrame:(CGRect)    frame
                    dataArray:(NSArray *) dataArray;

@end
