//
//  UZLoginViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/6.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZLoginViewController.h"
#import "UZWebBridge.h"
#import "UZNotificationsMacro.h"

@interface UZLoginViewController ()

/**
 *  手机号码
 */
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
/**
 *  验证码输入框
 */
@property (nonatomic, weak) IBOutlet UITextField *securityCodeTextField;
/**
 *  获取验证码按钮
 */
@property (nonatomic, weak) IBOutlet UIButton *securityCodeButton;
/**
 *  登录按钮
 */
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

/**
 *  验证码按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)securityCodeButtonAction:(id)sender;
/**
 *  登录按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginButtonAction:(id)sender;


@end

@implementation UZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self loadSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadSubviews {
    [self.securityCodeButton setBackgroundImage:[[UIColorFromRGB(0xfb8424) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateNormal];
    [self.securityCodeButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateHighlighted];
    [self.securityCodeButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateDisabled];
    [self.loginButton setBackgroundImage:[[UIColorFromRGB(0xfb8424) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forState:UIControlStateHighlighted];
    [self.loginButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forState:UIControlStateDisabled];
}

- (IBAction)hiddenKey:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (IBAction)goBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**
 *  验证码按钮事件
 */
- (IBAction)securityCodeButtonAction:(id)sender {
    if (self.phoneTextField.text.length != 11 || self.phoneTextField.text.integerValue <= 0) {
        [CKAlert showAlertWithMsg:@"号码输入有误，请检查"];
        return;
    }
    NSString *title = [sender titleForState:UIControlStateNormal];
    
    [sender setEnabled:NO];
    self.phoneTextField.enabled = NO;
    
    __block NSInteger count = 60;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        count--;
        if (count == 0) {
            [sender setTitle:title forState:UIControlStateNormal];
            [sender setEnabled:YES];
            dispatch_source_cancel(timer);
        }
        else {
            [sender setTitle:[NSString stringWithFormat:@"%lis后重新获取",(long)count] forState:UIControlStateNormal];
        }
    });
    dispatch_resume(timer);
    
    __weak typeof(self) weakSelf = self;
    [UZWebBridge asyncPOSTRequestSmsCode:self.phoneTextField.text success:^(id responseDict) {
        NSInteger code = [responseDict[@"code"] integerValue];
        if (code == 0) {
            [CKAlert showAlertWithMsg:@"验证码发送成功"];
        }
        else {
            [CKAlert showAlertWithMsg:responseDict[@"msg"] center:CKAlertCenterMiddle];
            weakSelf.phoneTextField.enabled = YES;
        }
    } failure:^(NSError *error) {
        [sender setEnabled:YES];
    }];
}
/**
 *  登录按钮事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginButtonAction:(id)sender {
    if (self.securityCodeTextField.text.length > 0 && self.securityCodeTextField.text.integerValue > 0) {
        [sender setEnabled:NO];
        
        __weak typeof(self) weakSelf = self;
        [UZWebBridge asyncPOSTTenantSave:self.phoneTextField.text smsCode:self.securityCodeTextField.text success:^(id responseDict) {
            [sender setEnabled:YES];
            if ([responseDict[@"code"] integerValue] == 0) {
                NSDictionary *auth = responseDict[@"auth"];
                NSDictionary *data = responseDict[@"data"];
                NSDictionary *authorize = responseDict[@"authorize"];
                [[UZUserBase shareInstance] setValuesFromDictionary:auth];
                [[UZUserBase shareInstance] setValuesFromDictionary:data];
                [[UZUserBase shareInstance] setValuesFromDictionary:authorize];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    [[UZUserBase shareInstance] replace];
                    [[NSUserDefaults standardUserDefaults] setObject:@(UID).stringValue forKey:@"lastuid"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                });
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
            }
            else {
                [CKAlert showAlertWithMsg:responseDict[@"msg"]];
            }
            
        } failure:^(NSError *error) {
            [sender setEnabled:YES];
            [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络"];
        }];
    }
    
}

@end
