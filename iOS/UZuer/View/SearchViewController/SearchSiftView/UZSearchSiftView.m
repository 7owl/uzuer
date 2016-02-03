//
//  UZSearchSiftView.m
//  UZuer
//
//  Created by CaydenK on 15/8/11.
//  Copyright (c) 2015年 CaydenK. All rights reserved.
//

#import "UZSearchSiftView.h"
#import "UIColor+UZExtend.h"

@interface UZSearchSiftView ()<UIScrollViewDelegate>

@property (copy, nonatomic) void(^block)(NSDictionary *dict);

//iPhone6 plus 约束配置项
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *plusConstraintLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *plusConstraintTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherConstraintTopLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *otherConstraintTop;

@property (weak, nonatomic) IBOutlet UITextField *textField0;
@property (weak, nonatomic) IBOutlet UITextField *textField1;

@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet UIView *contentView2;
@property (weak, nonatomic) IBOutlet UIView *contentView3;

@end

@implementation UZSearchSiftView

+ (UZSearchSiftView *)searchSiftViewWithSiftDict:(NSDictionary *)siftDict conditionCompletion:(void(^)(NSDictionary *dict))completion {
    UZSearchSiftView *view = [UZSearchSiftView uz_viewFromNib];
    NSString *prict = siftDict[@"price"];
    if (prict.length > 0) {
        NSArray *priceArray = [prict componentsSeparatedByString:@","];
        [priceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx == 0) {
                view.textField0.text = obj;
            }
            else if (idx == 1) {
                view.textField1.text = obj;
            }
        }];
    }
    
    NSString *kind = siftDict[@"kind"];
    if (kind.length > 0) {
        NSArray *kindArray = [kind componentsSeparatedByString:@","];
        [view.contentView1.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *button = obj;
                    NSString *sift = [button titleForState:UIControlStateNormal];
                    if ([sift isEqualToString:@"一室"]) {
                        if ([kindArray containsObject:@"1室"]) {
                            button.selected = YES;
                        }
                    }
                    else if ([sift isEqualToString:@"二室"]) {
                        if ([kindArray containsObject:@"2室"]) {
                            button.selected = YES;
                        }
                    }
                    else if ([sift isEqualToString:@"三室"]) {
                        if ([kindArray containsObject:@"3室"]) {
                            button.selected = YES;
                        }
                    }
                    else if ([sift isEqualToString:@"三室以上"]) {
                        if ([kindArray containsObject:@"三室以上"]) {
                            button.selected = YES;
                        }
                    }
            }
        }];
    }
    
    NSString *rentalEndTime = siftDict[@"rental_end_time"];
    NSInteger tag = [rentalEndTime integerValue];
    if (tag > 0) {
        UIButton *button = (UIButton *)[view.contentView2 viewWithTag:tag];
        button.selected = YES;
    }
    
    [view.contentView3.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = obj;
                NSString *sift = [button titleForState:UIControlStateNormal];
                if ([sift isEqualToString:@"新上房源"]) {
                    if ([siftDict[@"createtime"] isEqualToString:@"yes"]) {
                        button.selected = YES;
                    }
                }
                else if ([sift isEqualToString:@"精装修"]) {
                    if ([siftDict[@"decoration"] isEqualToString:@"精装"]) {
                        button.selected = YES;
                    }
                }
        }
    }];

    
    view.block = completion;
    return view;
}


- (void)awakeFromNib {
        self.plusConstraintLeading.priority = iPhone6p?UILayoutPriorityRequired:UILayoutPriorityFittingSizeLevel;
        self.plusConstraintTop.priority = iPhone6p?UILayoutPriorityRequired:UILayoutPriorityFittingSizeLevel;
        self.otherConstraintTopLeading.priority = iPhone6p?UILayoutPriorityFittingSizeLevel:UILayoutPriorityRequired;
        self.otherConstraintTopLeading.priority = iPhone6p?UILayoutPriorityFittingSizeLevel:UILayoutPriorityRequired;
    
    [self enumSubViews:self.contentView1.subviews];
    [self enumSubViews:self.contentView2.subviews];
    [self enumSubViews:self.contentView3.subviews];
    
}

- (void)enumSubViews:(NSArray *)array {
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [self setButtonStyle:obj];
        }
    }];
}

- (void)setButtonStyle:(UIButton *)button {
    [button setBackgroundImage:[UIColorFromRGB(0xd7d7d7) colorImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIColorFromRGB(0xfb8424) colorImage] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIColorFromRGB(0xfb8424) colorImage] forState:UIControlStateSelected];
    
    [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateHighlighted];
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(conditionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)conditionButtonAction:(UIButton *)button {
    UIView *superView = button.superview;
    if (button.superview == self.contentView1 || button.superview == self.contentView2) {
        [superView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                [obj setSelected:NO];
            }
        }];
        button.selected = YES;
        return;
    }
    
    button.selected = !button.selected;
}

- (void)enumButtonToFirstStateWithArray:(NSArray *)array {
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj setSelected:NO];
        }
    }];

}


//重置按钮
- (IBAction)resetButtonAction:(id)sender {
    self.textField0.text = @"";
    self.textField1.text = @"";
    
    [self enumButtonToFirstStateWithArray:self.contentView1.subviews];
    [self enumButtonToFirstStateWithArray:self.contentView2.subviews];
    [self enumButtonToFirstStateWithArray:self.contentView3.subviews];

}
- (IBAction)sureButtonAction:(id)sender {
    NSString *price0 = self.textField0.text;
    NSString *price1 = self.textField1.text;
    NSMutableDictionary *siftDict = @{}.mutableCopy;
    //有效价格区间
    if (price1.integerValue > 0 || price1.integerValue > 0) {
        if (price0.integerValue <= price1.integerValue) {
            [siftDict setObject:[NSString stringWithFormat:@"%li,%li",(long)price0.integerValue,(long)price1.integerValue] forKey:@"price"];
        }
    }
    //一室二室、、、
    NSMutableArray *kindArray = @[].mutableCopy;
    [self.contentView1.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = obj;
            if (button.selected) {
                NSString *sift = [button titleForState:UIControlStateNormal];
                if ([sift isEqualToString:@"一室"]) {
                    [kindArray addObject:@"1室"];
                }
                else if ([sift isEqualToString:@"二室"]) {
                    [kindArray addObject:@"2室"];
                }
                else if ([sift isEqualToString:@"三室"]) {
                    [kindArray addObject:@"3室"];
                }
                else if ([sift isEqualToString:@"三室以上"]) {
                    [kindArray addObject:@"三室以上"];
                }
            }
        }
    }];
    if (kindArray.count > 0) {
        [siftDict setObject:[kindArray componentsJoinedByString:@","] forKey:@"kind"];
    }
    
    //入住时间
    __block NSString *rentalEndTime = nil;
    [self.contentView2.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = obj;
            if (button.selected) {
                NSString *sift = [button titleForState:UIControlStateNormal];
                if ([sift isEqualToString:@"七天内"]) {
                    rentalEndTime = @"8";
                    *stop = YES;
                }
                else if ([sift isEqualToString:@"十五天内"]) {
                    rentalEndTime = @"16";
                    *stop = YES;
                }
                else if ([sift isEqualToString:@"三十天内"]) {
                    rentalEndTime = @"填30";
                    *stop = YES;
                }
                else if ([sift isEqualToString:@"三十天后"]) {
                    rentalEndTime = @"31";
                    *stop = YES;
                }
            }
        }
    }];
    if (rentalEndTime) {
        [siftDict setObject:rentalEndTime forKey:@"rental_end_time"];
    }
    
    [self.contentView3.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = obj;
            if (button.selected) {
                NSString *sift = [button titleForState:UIControlStateNormal];
                if ([sift isEqualToString:@"新上房源"]) {
                    [siftDict setObject:@"yes" forKey:@"createtime"];
                }
                else if ([sift isEqualToString:@"精装修"]) {
                    [siftDict setObject:@"精装" forKey:@"decoration"];
                }
            }
        }
    }];
    
    !self.block?:self.block(siftDict);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

@end
