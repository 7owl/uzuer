//
//  SKRefreshViewController.h
//  ShenKHealthy
//
//  Created by xiaofeishen on 15/7/6.
//  Copyright (c) 2015年 shenxiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

#define kStartPageIndex 0

typedef NS_ENUM(NSInteger, RefreshType)
{
    RefreshTypeHeader,
    RefreshTypeFooter
};

@protocol MJConfigerProtocol <NSObject>
@optional
- (void)pullDownRefresh;
- (void)pullUpRefresh;
@end

@interface SKRefreshViewController : UIViewController
<MJConfigerProtocol>


@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataSource;
//分页
@property(nonatomic,assign) NSInteger totalPage; //总页数
@property(nonatomic,assign) NSInteger curPage; //当前页码

@property(nonatomic,assign) BOOL needRefreshHeader;
@property(nonatomic,assign) BOOL needRefreshFooter;
@property(nonatomic,assign,readonly) RefreshType refreshType; //刷新类型

- (void)endRefresh;

@end
