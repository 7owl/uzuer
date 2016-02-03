//
//  UZWantListCell.h
//  UZuer
//
//  Created by CaydenK on 15/8/7.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZWantListCell;
@protocol UZWantListCellDelegate <NSObject>

- (void)UZWantListCellPay:(UZWantListCell *)cell;

@end
@class UZFavorite;

@interface UZWantListCell : UITableViewCell

@property(nonatomic,weak) UZFavorite *favorite;
@property(nonatomic,weak) id<UZWantListCellDelegate> delegate;

@end
