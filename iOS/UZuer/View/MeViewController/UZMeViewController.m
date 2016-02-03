//
//  UZMeViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/5.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMeViewController.h"
#import "UZFeedBackViewController.h"
#import <Masonry/Masonry.h>
#import "UZNotificationsMacro.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UZSearchDetailViewController.h"


#import "UZWebBridge.h"
#import "UZAuthenticaionNameViewController.h"

@interface UZMeViewController ()

@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UIImageView *avatorImageV; //头像
@property (strong, nonatomic) UILabel *phoneLb; //手机号

@property (weak, nonatomic) IBOutlet UIButton *mailCheckedButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonAction:(id)sender;

@end

@implementation UZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    if (UID > 0) {
        self.phoneLb.text = [UZUserBase shareInstance].username;
        [self.loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    } else {
        self.phoneLb.text = @"未登录";
        [self.loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kNotificationLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess:) name:kNotificationLogoutSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoUpdated:) name:kNotificationUserInfoUpdated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authUpdated:) name:kNotificationAuthUpdated object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.mailCheckedButton.selected = [UZUserBase shareInstance].email_validate.boolValue && [UZUserBase shareInstance].identity_valid.boolValue;
    
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //用户反馈
    if (indexPath.row == 1) {
        UZFeedBackViewController *feedback = [UZFeedBackViewController new];
        feedback.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedback animated:YES];
    }
    //给好评
    else if (indexPath.row == 1) {
        
    }
    //实名认证
    else if (indexPath.row == 2) {
        if (UID == 0) {
            [CKAlert showAlertWithMsg:@"未登录"];
            return;
        }
        if ([UZUserBase shareInstance].email_validate.boolValue && [UZUserBase shareInstance].identity_valid.boolValue) {
            [CKAlert showAlertWithMsg:@"实名认证和邮箱认证都已认证"];
            return;
        }
        [self performSegueWithIdentifier:@"toAuthencation" sender:nil];
    }
    //分享软件
    else if (indexPath.row == 3) {
        
    }
    //关于优租
    else if (indexPath.row == 4) {
        
    }
}

#pragma mark - action
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"UZContract"]) {
        if (UID == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
            return NO;
        }
    }
    else if ([identifier isEqualToString:@"toAuthencation"]) {
        return YES;
    }
    else {
        UITableViewCell *mailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        if (mailCell == sender) {
            if (UID == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
                return NO;
            }
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAuthencation"]) {
        //前往认证界面
        UIViewController *vc =  segue.destinationViewController;
        vc.hidesBottomBarWhenPushed = YES;
    }
}

#pragma mark - login or logout
- (IBAction)loginButtonAction:(id)sender {
    if (UID == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
    }
    else {
        [CKNormalAlert alertAtWindowWithContent:@"确定登出？" sure:@"确定" cancel:@"取消" callBack:^(CKAlertCallBackType type) {
            if (type == CKAlertCallBackTypeSure) {
                [UZWebBridge asyncPOSTUnbundlingSuccess:nil failure:nil];
                //注销登录
                [[UZUserBase shareInstance] clearData];
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - notification
- (void)loginSuccess:(NSNotification *)noti
{
    self.phoneLb.text = [UZUserBase shareInstance].username;
    [self.loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    self.mailCheckedButton.selected = [UZUserBase shareInstance].email_validate.boolValue && [UZUserBase shareInstance].identity_valid.boolValue;
}

- (void)logoutSuccess:(NSNotification *)noti
{
    self.phoneLb.text =  @"未登录";
    [self.loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    self.mailCheckedButton.selected = NO;
}

- (void)userInfoUpdated:(NSNotification *)noti
{
    self.mailCheckedButton.selected = [UZUserBase shareInstance].email_validate.boolValue && [UZUserBase shareInstance].identity_valid.boolValue;
}

- (void)authUpdated:(NSNotification *)noti
{
    self.mailCheckedButton.selected = [UZUserBase shareInstance].email_validate.boolValue && [UZUserBase shareInstance].identity_valid.boolValue;
}

#pragma mark - getter & setter
- (UIView *)tableHeaderView {
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0,0,ScreenWith,184}];
        _tableHeaderView.backgroundColor = UIColorFromRGB(BaseColor);
        self.avatorImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_homepage_photo"]];
        [_tableHeaderView addSubview:self.avatorImageV];
        UIButton *avatorButton = [[UIButton alloc]init];
        [_tableHeaderView addSubview:avatorButton];
        [avatorButton addTarget:self action:@selector(avatorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_homepage_phone"]];
        [_tableHeaderView addSubview:phoneIcon];
        
        self.phoneLb = [[UILabel alloc] init];
        self.phoneLb.font = [UIFont boldSystemFontOfSize:15.f];
        self.phoneLb.textColor = [UIColor whiteColor];
        self.phoneLb.textAlignment = NSTextAlignmentCenter;
        
        [_tableHeaderView addSubview:self.phoneLb];
        
        //约束
        [self.avatorImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(171/2.f);
            make.centerX.mas_equalTo(0);
        }];
        [avatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.avatorImageV);
        }];
        
        [self.phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneIcon.mas_centerY).offset(0);
            make.centerX.equalTo(self.avatorImageV.mas_centerX).offset(0);
        }];
        
        [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.phoneLb.mas_left).offset(-8);
            make.top.equalTo(self.avatorImageV.mas_bottom).offset(8);
        }];
    }
    if (UID > 0) {
        self.phoneLb.text = [UZUserBase shareInstance].tel_number;
    }
    else {
        self.phoneLb.text = @"未登录";
    }
    return _tableHeaderView;
}

- (void)avatorButtonAction:(UIButton *)sender {
    if (UID == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"present_login_view_controller" object:nil];
    }
}

@end
