//
//  ELVTextView.m
//  fuckup
//
//  Created by seemelk on 15/1/17.
//  Copyright (c) 2015年 seemelk. All rights reserved.
//

#import "ELVTextView.h"

@interface ELVTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation ELVTextView

- (UILabel *)placeholderLabel{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _placeholderLabel.textColor = self.placeholderColor?:[UIColor colorWithRed:0xe8/255.0 green:0xe8/255.0 blue:0xe8/255.0 alpha:1];
        _placeholderLabel.text = self.placeholder?:@"";
        _placeholderLabel.font = self.font;
        _placeholderLabel.hidden = self.text.length>0;
        _placeholderLabel.numberOfLines = 0;
    }
    return _placeholderLabel;
}
- (void)setText:(NSString *)text{
    [super setText:text];
    self.placeholderLabel.hidden = self.text.length>0;
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholderLabel.hidden = self.text.length>0;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
    self.placeholderLabel.hidden = self.text.length>0;
    _placeholderLabel.font = self.font;
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _placeholderLabel.font = self.font;
    CGSize size = [placeholder boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    self.placeholderLabel.frame = CGRectMake(5, 8, size.width+10 > self.bounds.size.width-10 ? self.bounds.size.width-10 : size.width+10, size.height);
    self.placeholderLabel.text = placeholder;
}

- (void)awakeFromNib{
    [self addSubview:self.placeholderLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editText) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)editText{
    self.placeholderLabel.hidden = self.text.length>0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}


@end
