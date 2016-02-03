//
//  UZMainViewController.m
//  UZuer
//
//  Created by CaydenK on 15/7/30.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMainViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "UZMainHeaderView.h"
#import "UZMainMapSectionHeaderView.h"
#import "UZMainRecommendCell.h"
#import "UZMainRecommendCell0.h"
#import <Masonry/Masonry.h>
#import "UZRoomDetailViewController.h"
#import "UZRoomDetailViewController.h"
#import "UZMapSearchRoomsViewController.h"
#import "UZSearchViewController.h"
#import "UZSearchDetailViewController.h"
#import "UZWebBridge.h"
#import "UZRecommendRoom.h"
#import "CKAlert.h"
#import "UZCommunity.h"
#import "UZFavorite.h"
#import "UZNotificationsMacro.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define pullToFill_Y 150 //导航栏动画灵敏度，y值表示scroll滚动的距离

@interface UZMainViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
UZSearchViewControllerDelegate
>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *naviBarView;

@property (weak, nonatomic) IBOutlet UIView *cityButtonContainer;
@property (nonatomic, weak) IBOutlet UITextField *inputView;

@property (nonatomic, strong) UIView *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;

@property (nonatomic, strong) UZMainHeaderView *headerView;
@property (weak, nonatomic) UZSearchViewController *searchViewController;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation UZMainViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSubviews];
    [self loadDataSource]; 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadSubviews {
    self.fd_prefersNavigationBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cancelButton.hidden = YES;
    self.filterButton.hidden = !self.cancelButton.hidden;
    self.inputView.tintColor = UIColorFromRGB(BaseColor);
    [self.tableView registerNib:[UINib nibWithNibName:@"UZMainRecommendCell" bundle:nil] forCellReuseIdentifier:@"UZMainRecommendCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UZMainRecommendCell0" bundle:nil] forCellReuseIdentifier:@"UZMainRecommendCell0"];
    
    UIView *headerContainer = [[UIView alloc] initWithFrame:(CGRect){0,0,ScreenWith,[self headerViewHeight]}];
    self.headerView = [UZMainHeaderView headerView];
    self.cityButton = self.headerView.buttonContainer;
    [self.headerView.cityButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    [headerContainer addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.tableView.tableHeaderView = headerContainer;
}

#pragma mark - service
- (void)loadDataSource {
    __weak typeof(self) weakSelf = self;
    self.dataSource = [UZRecommendRoom queryWithConditions:NULL];
    [UZWebBridge asyncPOSTgetFeaturedListWithSuccess:^(NSArray *responseArray) {
        weakSelf.dataSource = responseArray;
        [weakSelf.tableView reloadData];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [UZRecommendRoom deleteWithConditions:NULL];
            [UZRecommendRoom replaceWithArray:responseArray];
        });
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

#pragma mark - aciton
- (void)selectCity:(id)sender
{
#warning 选择城市
}

- (IBAction)cancelSearch:(id)sender
{
    self.inputView.text = @"";
    [self.inputView resignFirstResponder];
    [self navigationBarSwitchToSearch:NO];
    [self.searchViewController.view removeFromSuperview];
}

- (IBAction)filterSearch:(id)sender
{
    UZSearchDetailViewController *vc = [[UZSearchDetailViewController alloc] init];
    vc.searchTitle = @"";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionWithItem:(UZRecommendRoom *)room
{
    [self.tableView setEditing:NO animated:YES];
    if (UID > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [UZWebBridge asyncPOSTAddRoomToFavoriteListWithRoomId:[room.id integerValue] success:^(id responseDict) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UZFavorite *favorite = [UZFavorite favoriteWithRecommendRoom:room];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [favorite replace];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectionSuccess object:nil];
                });
            });
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UZFavorite *favorite = [UZFavorite favoriteWithRecommendRoom:room];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [favorite replace];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCollectionSuccess object:nil];
                });
            });
        }];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
    }
}

#pragma mark - notification
- (void)keyboardFrameWillChanged:(NSNotification *)notification
{
    CGRect beginFrame = [notification.userInfo[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat dValue = beginFrame.origin.y - endFrame.origin.y;
    CGFloat keyboardHeight = beginFrame.size.height;
    if (dValue > 0) {
        //键盘升起
        if (self.searchViewController == nil) {
            UZSearchViewController *vc = [[UZSearchViewController alloc] init];
            vc.delegate = self;
            [self addChildViewController:vc];
            self.searchViewController = vc;
        }
        [self.view addSubview:self.searchViewController.view];
        [self.searchViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.naviBarView.mas_bottom).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardHeight+49);
            make.left.right.mas_equalTo(0);
        }];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 0;
    } else {
        return self.dataSource.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UZMainMapSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"main_header"];
    if (!header) {
        __weak __typeof(self) weakSelf = self;
        header = [[UZMainMapSectionHeaderView alloc]initWithReuseIdentifier:@"main_header" callBack:^{
            UZMapSearchRoomsViewController *vc = [UZMapSearchRoomsViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    }
    return 269;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UZMainRecommendCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"UZMainRecommendCell0"];
        return cell;
    }
    UZMainRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UZMainRecommendCell"];
    cell.room = self.dataSource[indexPath.row-1];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    
    UZRecommendRoom *room = self.dataSource[indexPath.row-1];
    
    UZRoomDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"UZRoomDetailViewController"];
    vc.roomId = [room.id integerValue];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat scale = (offset>0?offset:0) / pullToFill_Y;
    if (scale >=1) {
        scale = 1;
    }
    
    self.inputView.alpha = scale;
    self.filterButton.alpha = scale;
    self.naviBarView.backgroundColor = UIColorFromRGBA(BaseColor, scale);
    
    scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentOffset.y > 0?64:0, 0, 0, 0);

    //cityButton
    if (offset > 0) {
        [self.cityButtonContainer addSubview:self.cityButton];
        
        const CGRect offsetRect = [self verticalWithView:self.cityButton view:self.cityButtonContainer]; //差值-固定值
        const CGFloat constTopOffset = 7;
        CGFloat topOffset = offsetRect.origin.y - offset; //以高度差为基准
        if (topOffset <= constTopOffset) {
            topOffset = constTopOffset;
        }
        
        CGFloat scale1 = topOffset / offsetRect.origin.y; //往上拉 ，数值减小
        if (scale1 < 0) {
            scale1 = 0;
        }
        
        //位置变化处理
        CGFloat fontRatio = (1 + scale1) / 2.f;
        CGFloat fontSize = 30;
        self.headerView.cityLabel.font = [UIFont systemFontOfSize: fontSize * fontRatio];//文字处理
        
        CGFloat leftOffset = offsetRect.origin.x * scale1 + 4;
        [self.cityButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topOffset);
            make.left.mas_equalTo(leftOffset);
        }]; //位置处理
        self.cityButton.layer.shadowOpacity = scale1; //投影处理
        
        
        static CGFloat enLabelCenterXOffset = 0;
        if (enLabelCenterXOffset == 0) {
            enLabelCenterXOffset = self.headerView.enLabel.frame.origin.x + self.headerView.enLabel.frame.size.width + 30;
        }
        self.headerView.enLabelCenterX.constant = - enLabelCenterXOffset * (1 - scale1); //拼音位置处理
        
    } else {
        //返回原位
        [self.tableView.tableHeaderView addSubview:self.cityButton];
        [self.cityButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointMake(0, 0));
        }];
        self.headerView.enLabelCenterX.constant = 0; //返回原位;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

//iOS7 入口
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //ios7 入口
        UZRecommendRoom *room = self.dataSource[indexPath.row-1];
        [self collectionWithItem:room];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"收藏";
}

//iOS8 入口
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UZRecommendRoom *room = self.dataSource[indexPath.row-1];
        [self collectionWithItem:room];
    }];
    action.backgroundColor = UIColorFromRGB(BaseColor);
    return @[action];
}

#pragma mark - search view controller delegte
- (void)UZSearchViewController:(UZSearchViewController *)vc didSelected:(UZCommunity *)item
{
    UZSearchDetailViewController *searchVC = [[UZSearchDetailViewController alloc] init];
    searchVC.searchTitle = item.comm_name;
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.tableView.contentOffset.y < [self headerViewHeight] - 64) {
        [self.tableView setContentOffset:CGPointMake(0, [self headerViewHeight] - 64) animated:YES];
    }
    if (textField.text.length == 0) {
        [self.searchViewController setHistoryListHidden:NO];
    }
    [self navigationBarSwitchToSearch:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        return NO;
    } else {
        UZCommunity *community = [[UZCommunity alloc] init];
        community.comm_name = textField.text;
        [self.searchViewController.searchHistoryHelper addNewSearchItem:community];
        UZSearchDetailViewController *vc = [[UZSearchDetailViewController alloc] init];
        vc.searchTitle = textField.text;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *temp = textField.text;
    if (string.length == 0) {
        temp = [temp substringToIndex:textField.text.length - 1];
    } else {
        temp = [temp stringByReplacingCharactersInRange:range withString:string];
    }
    if (temp.length > 0) {
        [self.searchViewController setHistoryListHidden:YES];
        [self.searchViewController searchWithKeyword:temp showToast:NO];
    } else {
        [self.searchViewController setHistoryListHidden:NO];
    }
    return YES;
}

#pragma mark - helper
- (void)navigationBarSwitchToSearch:(BOOL)toSearch
{
    self.cancelButton.hidden = !toSearch;
    self.filterButton.hidden = toSearch;
}

- (CGRect)verticalWithView:(UIView *)view1 view:(UIView *)view2
{
    static CGRect offset;
    if (offset.origin.y == 0) {
        CGRect rect1 = [view1 convertRect:view1.bounds toView:nil];
        CGRect rect2 = [view2 convertRect:view2.bounds toView:nil];
        offset.origin.x = rect1.origin.x - rect2.origin.x;
        offset.origin.y = rect1.origin.y - rect2.origin.y - 20;
        offset.size.width = rect1.size.width - rect2.size.width;
        offset.size.height = rect1.size.height - rect2.size.height;
    }
    return offset;
}

- (CGFloat)headerViewHeight
{
    CGFloat ratio = 375.f/260.f; //宽高比
    return ScreenWith/ratio;
}

@end
