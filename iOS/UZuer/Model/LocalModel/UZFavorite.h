//
//  UZFavorite.h
//  UZuer
//
//  Created by xiaofeishen on 15/8/27.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZRecommendRoom.h"

@interface UZFavorite : UZRecommendRoom

@property (nonatomic, assign) NSInteger uid;// = 13;
@property (nonatomic, assign) NSTimeInterval createTime;// = 13;

+ (UZFavorite *)favoriteWithRecommendRoom:(UZRecommendRoom *)room;

@end
