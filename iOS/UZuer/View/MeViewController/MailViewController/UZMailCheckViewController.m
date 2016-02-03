//
//  UZMailCheckViewController.m
//  uzuer
//
//  Created by CaydenK on 15/8/20.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZMailCheckViewController.h"
#import "UZWebBridge.h"

@interface UZMailCheckViewController ()

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;

- (IBAction)checkButtonAction:(id)sender;

@end

@implementation UZMailCheckViewController

- (void)viewDidLoad {
    [super  viewDidLoad];
    self.title = @"验证邮箱";
    [self.checkButton setBackgroundImage:[[UIColorFromRGB(0xfb8424) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateNormal];
    [self.checkButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateHighlighted];
    if ([[UZUserBase shareInstance].email length]) {
        self.mailTextField.text = [UZUserBase shareInstance].email;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)checkButtonAction:(id)sender {
    
    if (![self isValidateEmail:self.mailTextField.text]) {
        [CKAlert showAlertWithMsg:@"无效的邮箱格式！请重新输入。"];
    }
    self.checkButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [UZUserBase shareInstance].email = self.mailTextField.text;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[UZUserBase shareInstance] replace];
        [[NSUserDefaults standardUserDefaults] setObject:@(UID).stringValue forKey:@"lastuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    });
    
    [UZWebBridge asyncPOSTTenantEdit:[[UZUserBase shareInstance] modelDictionary] success:^(id responseDict) {
        if (responseDict[@"error"]) {
            [CKAlert showAlertWithMsg:responseDict[@"error"]];
        }
        else if ([responseDict[@"code"] integerValue] == 0){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                [UZUserBase shareInstance].email_validate = @"0";
                [[UZUserBase shareInstance] replace];
                [[NSUserDefaults standardUserDefaults] setObject:@(UID).stringValue forKey:@"lastuid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
            [CKAlert showAlertWithMsg:@"修改成功，请前往邮箱认证"];
        }
        weakSelf.checkButton.enabled = YES;
    } failure:^(NSError *error) {
        DLog(@"%@",error);
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络或重试！"];
        weakSelf.checkButton.enabled = YES;
    }];

}

//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



@end
