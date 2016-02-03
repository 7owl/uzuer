//
//  UZContractDetailImageCell.h
//  UZuer
//
//  Created by CaydenK on 15/9/13.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UZContractDetailImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *blowupButton;
@property (assign, nonatomic) BOOL hasLoaded;

@end
