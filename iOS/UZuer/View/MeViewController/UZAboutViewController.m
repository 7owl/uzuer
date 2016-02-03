//
//  UZAboutViewController.m
//  UZuer
//
//  Created by xiaofeishen on 15/9/19.
//  Copyright © 2015年 CaydenK. All rights reserved.
//

#import "UZAboutViewController.h"
#import "UZWebBridge.h"

@interface UZAboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLb;

@end

@implementation UZAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于优租";
    self.versionLb.text = [NSString stringWithFormat:@"版本号 %@",UZAppVersion];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
