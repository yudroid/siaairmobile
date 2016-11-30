//
//  PsnGeneralContentView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgreesBarView.h"
#import "PassengerContentView.h"
@class PassengerModel;

@interface PsnGeneralContentView : UIView

-(instancetype)initWithFrame:(CGRect)           frame
              passengerModel:(PassengerModel *) passengerModel;

@end
