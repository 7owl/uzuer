//
//  UZSearchViewController.h
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UZSearchHistoryHelper.h"

typedef NS_ENUM(NSInteger, SearchMode){
    SearchModeHasHistory, //默认值 ，有历史记录
    SearchModePlain,  //无历史记录
};

@protocol UZSearchViewControllerDelegate;
@interface UZSearchViewController : UIViewController

@property(nonatomic,weak) id<UZSearchViewControllerDelegate> delegate;
@property(nonatomic,strong) UZSearchHistoryHelper *searchHistoryHelper;
@property(nonatomic,assign) SearchMode searchMode; //默认SearchModeHasHistory

/**
 *  yes， 移除历史搜索项在列表中显示
 */
- (void)setHistoryListHidden:(BOOL)hidden;

/**
 *  根据用户输入搜索
 */
- (void)searchWithKeyword:(NSString *)aKeyword showToast:(BOOL)showToast;

@end

@protocol UZSearchViewControllerDelegate <NSObject>

- (void)UZSearchViewController:(UZSearchViewController *)vc didSelected:(UZCommunity *)item;

@end