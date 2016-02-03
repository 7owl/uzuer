//
//  UZSearchSiftView.h
//  UZuer
//
//  Created by CaydenK on 15/8/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZSearchSiftView : UIView

+ (UZSearchSiftView *)searchSiftViewWithSiftDict:(NSDictionary *)siftDict conditionCompletion:(void(^)(NSDictionary *dict))completion;

@end
