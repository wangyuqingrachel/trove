//
//  AddTroveRecordCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "AddTroveRecordCell.h"
#import <Masonry/Masonry.h>

static CGFloat const kLeftMagin = 50;
static CGFloat const kTextLeftMagin = 80;
static CGFloat const kLineWidth = 1;
static CGFloat const kDotWidth = 7;

@interface AddTroveRecordCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *dot;
@property (nonatomic, strong) UILabel *label;


@end

@implementation AddTroveRecordCell

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

- (void)configWithColor:(UIColor *)color
{
    // line
    self.line.backgroundColor = color;
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftMagin);
        make.width.mas_equalTo(kLineWidth);
        make.top.bottom.offset(0);
    }];
    // dot
    self.dot.backgroundColor = color;
    [self addSubview:self.dot];
    [self.dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.line);
        make.width.height.mas_equalTo(kDotWidth);
    }];
    // line
    self.label.textColor = color;
    [self addSubview:self.label];
    self.label.text = @"add new record";
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kTextLeftMagin);
        make.centerY.mas_equalTo(self.line);
    }];


}

#pragma mark - Getters

- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
        _line.alpha = 0.5;
    }
    return _line;
}

- (UIView *)dot
{
    if (!_dot) {
        _dot = [UIView new];
        _dot.layer.cornerRadius = kDotWidth/2;
    }
    return _dot;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    return _label;
}

@end
