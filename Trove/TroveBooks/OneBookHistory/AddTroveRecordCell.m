//
//  AddTroveRecordCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "AddTroveRecordCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+TroveColor.h"

static CGFloat const kLeftMagin = 50;
static CGFloat const kTextLeftMagin = 80;
static CGFloat const kLineWidth = 1;
static CGFloat const kIconWidth = 40;
static CGFloat const kPlusWidth = 30;
 
@interface AddTroveRecordCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *icon;
@property (nonatomic, strong) UIImageView *plus;
@property (nonatomic, strong) UILabel *label;

@end

@implementation AddTroveRecordCell

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

- (void)configWithColor:(UIColor *)color isEnd:(BOOL)isEnd
{
    // line
    self.line.backgroundColor = color;
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftMagin);
        make.width.mas_equalTo(kLineWidth);
        make.top.offset(self.frame.size.height/2);
    }];
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) { // 动态的constraint必须这样写，否则不会更新
        make.bottom.offset(isEnd ? -self.frame.size.height/2 : 0);
    }];
    // icon
    self.icon.backgroundColor = color;
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(kIconWidth);
    }];
    self.icon.layer.cornerRadius = kIconWidth/2;
    [self.icon addSubview:self.plus];
    [self.plus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.height.mas_equalTo(kPlusWidth);
    }];
    // text
    self.label.textColor = color;
    [self addSubview:self.label];
    self.label.text = @"Add a new record";
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kTextLeftMagin);
        make.centerY.offset(0);
    }];


}

#pragma mark - Getters

- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
    }
    return _line;
}

- (UIView *)icon
{
    if (!_icon) {
        _icon = [UIView new];
    }
    return _icon;
}

- (UIImageView *)plus
{
    if (!_plus) {
        UIImage *image = [[UIImage systemImageNamed:@"plus"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _plus = [[UIImageView alloc] initWithImage:image];
        _plus.tintColor = [UIColor troveColorNamed:TroveColorTypeBackground];
    }
    return _plus;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:16];
    }
    return _label;
}

@end
