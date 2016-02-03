//
//  UZSearchDetailCell.h
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZSearchDetailCell;
@protocol UZSearchDetailCellDelegate <NSObject>
- (void)uzSearchDetailCellCollection:(UZSearchDetailCell *)cell;
- (void)uzSearchDetailCellPay:(UZSearchDetailCell *)cell;
@end
@class UZRecommendRoom;
@interface UZSearchDetailCell : UITableViewCell

@property (weak, nonatomic) UZRecommendRoom *room;
@property (weak, nonatomic) id<UZSearchDetailCellDelegate> delegate;

@end
