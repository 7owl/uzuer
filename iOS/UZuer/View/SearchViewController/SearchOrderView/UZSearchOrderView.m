//
//  UZSearchOrderView.m
//  UZuer
//
//  Created by CaydenK on 15/8/8.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZSearchOrderView.h"

@interface UZSearchOrderView()

@property (nonatomic, weak) IBOutlet UIButton *btn0;
@property (nonatomic, weak) IBOutlet UIButton *btn1;
@property (nonatomic, weak) IBOutlet UIButton *btn2;
@property (nonatomic, weak) IBOutlet UIButton *btn3;
@property (nonatomic, weak) IBOutlet UIButton *btn4;
@property (nonatomic, weak) IBOutlet UIButton *btn5;

@property (nonatomic, weak) IBOutlet UIImageView *imgView0;
@property (nonatomic, weak) IBOutlet UIImageView *imgView1;
@property (nonatomic, weak) IBOutlet UIImageView *imgView2;
@property (nonatomic, weak) IBOutlet UIImageView *imgView3;
@property (nonatomic, weak) IBOutlet UIImageView *imgView4;
@property (nonatomic, weak) IBOutlet UIImageView *imgView5;

@end

@implementation UZSearchOrderView {
    void(^block)(NSString *orderCondition);
    NSArray *array;
}

+ (UZSearchOrderView *)searchOrderViewWithCurrentCondition:(NSString *)conditionText collback:(void(^)(NSString *orderCondition))block {
    UZSearchOrderView *searchOrderView = [UZSearchOrderView uz_viewFromNib];
    searchOrderView->block = block;
    searchOrderView->array = @[@"推荐排序",@"最新房源",@"距离从近到远",@"租金从低到高",@"租金从高到低",@"面积从大到小"];
    [searchOrderView setButtonStateAndImageViewHiddenWithStr:conditionText];

    return searchOrderView;
}

- (void)setButtonStateAndImageViewHiddenWithStr:(NSString *)str {
    NSInteger index = [array indexOfObject:str];
    for (NSInteger i = 0; i < 6; i++) {
        NSString *btnKey = [NSString stringWithFormat:@"btn%li",(long)i];
        NSString *imgViewKey = [NSString stringWithFormat:@"imgView%li",(long)i];
        UIButton *btn = [self valueForKey:btnKey];
        UIImageView *imgView = [self valueForKey:imgViewKey];
        btn.selected = (i == index);
        imgView.hidden = (i != index);
    }
    
}

- (IBAction)buttonGestureAction:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;
    [self setButtonStateAndImageViewHiddenWithStr:title];
    !block?:block(title);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (IBAction)tapGestureAction:(id)sender {
    !block?:block(nil);
    [self removeFromSuperview];
}

@end
