//
//  UZFeedBackViewController.m
//  UZuer
//
//  Created by CaydenK on 15/8/5.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZFeedBackViewController.h"
#import "UZWebBridge.h"
#import "ELVTextView.h"

@interface UZFeedBackViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet ELVTextView *textView;

@end

@implementation UZFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithTitle:@"提交" target:self action:@selector(commitFeedBack)];
    self.navigationItem.title = @"意见反馈";
    
    //草稿
    NSString *draft = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"user_feed_back_draft_with_uid_%li",(long)UID]];
    if (draft.length > 0) {
        self.textView.text = draft;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[NSString stringWithFormat:@"user_feed_back_draft_with_uid_%li",(long)UID]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
        [[NSUserDefaults standardUserDefaults] setObject:self.textView.text forKey:[NSString stringWithFormat:@"user_feed_back_draft_with_uid_%li",(long)UID]];
        [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)commitFeedBack {
    if (self.textView.text.length > 0) {
        __weak typeof(self) weakSelf = self;
        [UZWebBridge asyncPOSTUserFeedBackWithContent:self.textView.text success:^(id responseDict) {
            [CKAlert showAlertWithMsg:@"反馈已提交成功,谢谢！"];
            weakSelf.textView.text = @"";
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[NSString stringWithFormat:@"user_feed_back_draft_with_uid_%li",(long)UID]];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } failure:^(NSError *error) {

        }];
    }
}

@end
