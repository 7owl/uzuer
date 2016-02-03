//
//  UZAuthenticaionNameViewController.m
//  UZuer
//
//  Created by xiaofeishen on 15/9/9.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZAuthenticaionNameViewController.h"
#import "UZWebBridge.h"
#import "CKAlert.h"
#import <Masonry/Masonry.h>
#import <BlocksKit+UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UZNotificationsMacro.h"

@interface UZAuthenticaionNameViewController ()
<UIActionSheetDelegate,
UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *mailCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *realNameCheckButton;

@property (weak, nonatomic) IBOutlet UITextField *mailTf;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTf;
@property (weak, nonatomic) IBOutlet UIImageView *imageV1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

@property (weak, nonatomic) UIImageView *selectedImageV; //当前选择的照片
@end
@implementation UZAuthenticaionNameViewController

#pragma mark life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"实名认证";
    [self.contentView bk_whenTapped:^{
        //添加背景点击
        [self.view endEditing:YES];
    }];
    
    [self.mailCheckButton setBackgroundImage:[[UIColorFromRGB(0xfb8424) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateNormal];
    [self.mailCheckButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateHighlighted];
    [self.realNameCheckButton setBackgroundImage:[[UIColorFromRGB(0xfb8424) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateNormal];
    [self.realNameCheckButton setBackgroundImage:[[UIColorFromRGB(0xd7d7d7) colorImage] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) ] forState:UIControlStateHighlighted];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authUpdated:) name:kNotificationAuthUpdated object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    if ([UZUserBase shareInstance].email_validate.boolValue) {
        self.mailCheckButton.backgroundColor = [UIColor lightGrayColor];
        self.mailCheckButton.enabled = NO;
        [self.mailCheckButton setTitle:@"邮箱已认证" forState:UIControlStateNormal];
    }
    if ([UZUserBase shareInstance].identity_valid.boolValue) {
        self.realNameCheckButton.backgroundColor = [UIColor lightGrayColor];
        self.realNameCheckButton.enabled = NO;
        [self.realNameCheckButton setTitle:@"已实名认证" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notification
- (void)keyboardFrameChange:(NSNotification *)notification
{
    CGRect endFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (CGRectGetMinY(endFrame) == CGRectGetHeight([UIScreen mainScreen].bounds)) {
        //键盘收起
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomLayout.constant = 0;
            [self.view layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomLayout.constant = endFrame.size.height;
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)authUpdated:(NSNotification *)noti
{
    if ([UZUserBase shareInstance].email_validate.boolValue) {
        self.mailCheckButton.backgroundColor = [UIColor lightGrayColor];
        self.mailCheckButton.enabled = NO;
        [self.mailCheckButton setTitle:@"邮箱已认证" forState:UIControlStateNormal];
    }
    if ([UZUserBase shareInstance].identity_valid.boolValue) {
        self.realNameCheckButton.backgroundColor = [UIColor lightGrayColor];
        self.realNameCheckButton.enabled = NO;
        [self.realNameCheckButton setTitle:@"已实名认证" forState:UIControlStateNormal];
    }
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (![title isEqualToString:@"取消"]) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            if ([title isEqualToString:@"拍照"]) {
                sourceType = UIImagePickerControllerSourceTypeCamera;
            } else if ([title isEqualToString:@"从相册选择"]) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            } else {
                return;
            }
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - image picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selectedImage = info[@"UIImagePickerControllerOriginalImage"];
    self.selectedImageV.image = selectedImage;
    self.selectedImageV = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - action
- (IBAction)selectImage:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    self.selectedImageV = (UIImageView *)sender.view;
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    [sheet showInView:self.view];
}

//验证邮箱
- (IBAction)mailAuthenticaiton:(id)sender {
    if ([UZUserBase shareInstance].email_validate.boolValue) {
        [CKAlert showAlertWithMsg:@"邮箱已认证"];
        return;
    }
    if (self.mailTf.text.length == 0) {
        [CKAlert showAlertWithMsg:@"邮箱未填写"];
        return;
    }
    
    if (![self isValidateEmail:self.mailTf.text]) {
        [CKAlert showAlertWithMsg:@"无效的邮箱格式！请重新输入。"];
        return;
    }
    self.mailCheckButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [UZUserBase shareInstance].email = self.mailTf.text;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [[UZUserBase shareInstance] replace];
        [[NSUserDefaults standardUserDefaults] setObject:@(UID).stringValue forKey:@"lastuid"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UZWebBridge asyncPOSTTenantEdit:[[UZUserBase shareInstance] modelDictionary] success:^(id responseDict) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (responseDict[@"error"]) {
            [CKAlert showAlertWithMsg:responseDict[@"error"]];
        }
        else if ([responseDict[@"code"] integerValue] != 0) {
            [CKAlert showAlertWithMsg:responseDict[@"msg"]];
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
        weakSelf.mailCheckButton.enabled = YES;
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        DLog(@"%@",error);
        [CKAlert showAlertWithMsg:@"网络请求失败，请检查网络或重试！"];
        weakSelf.mailCheckButton.enabled = YES;
    }];
}

//提交等待认证
- (IBAction)commit:(id)sender {
    if ([UZUserBase shareInstance].identity_valid.boolValue) {
        [CKAlert showAlertWithMsg:@"已实名认证"];
        return;
    }
    
    if ([self.nameTf.text isEqualToString:@""] || self.nameTf.text == nil || [self.cardNumberTf.text isEqualToString:@""] || self.cardNumberTf.text == nil) {
        [CKAlert showAlertWithMsg:@"姓名和身份证号不能为空"];
        return;
    }
    
    if (self.imageV1.image == nil) {
        [CKAlert showAlertWithMsg:@"照片未选择"];
        return;
    }
    
    NSString *cardNumberRegex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cardNumberRegex];
    if (![predicate evaluateWithObject:self.cardNumberTf.text]) {
        [CKAlert showAlertWithMsg:@"身份证格式不正确"];
        return;
    }
    
    self.realNameCheckButton.enabled = NO;
    __weak typeof(self) wself = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UZWebBridge asyncPOSTRealNameAuthenticationWithName:self.nameTf.text
                                              cardNumber:self.cardNumberTf.text
                                                  image:self.imageV1.image
                                                    success:^(id responseDict) {
                                                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                        wself.realNameCheckButton.enabled = YES;
                                                        NSInteger code = [responseDict[@"code"] integerValue];
                                                        if (code == 0) {
                                                            [CKAlert showAlertWithMsg:@"提交成功，等待审核"];
                                                        } else {
                                                            [CKAlert showAlertWithMsg:responseDict[@"msg"]];
                                                        }
                                                    } failure:^(NSError *error) {
                                                        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                        wself.realNameCheckButton.enabled = YES;
                                                    }];
}


#pragma mark - helper
//利用正则表达式验证
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
