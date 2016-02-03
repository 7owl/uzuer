//
//  UZSearchOrderView.h
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZSearchOrderView : UIView

+ (UZSearchOrderView *)searchOrderViewWithCurrentCondition:(NSString *)conditionText collback:(void(^)(NSString *orderCondition))block;

@end
