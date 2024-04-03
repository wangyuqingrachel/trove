//
//  TroveRecordCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "TroveRecordCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+TroveColor.h"

static CGFloat const kLeftMagin = 50;
static CGFloat const kTextLeftMagin = 80;
static CGFloat const kLineWidth = 1;
static CGFloat const kIconWidth = 30;
static CGFloat const kPlusWidth = 20;

@interface TroveRecordCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *icon;
@property (nonatomic, strong) UIImageView *edit;
@property (nonatomic, strong) UILabel *label;

@end

@implementation TroveRecordCell

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

- (void)configWithColor:(UIColor *)color recordModel:(TroveRecordModel *)record isEnd:(BOOL)isEnd
{
    // line
    self.line.backgroundColor = color;
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftMagin);
        make.width.mas_equalTo(kLineWidth);
        make.top.offset(0);
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
    [self.icon addSubview:self.edit];
    [self.edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.height.mas_equalTo(kPlusWidth);
    }];
    // text
    self.label.textColor = color;
    [self addSubview:self.label];
    self.label.text = [record.page stringValue];
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

- (UIImageView *)edit
{
    if (!_edit) {
        UIImage *image = [[UIImage systemImageNamed:@"square.and.pencil"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _edit = [[UIImageView alloc] initWithImage:image];
        _edit.tintColor = [UIColor troveColorNamed:TroveColorTypeBackground];
    }
    return _edit;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    return _label;
}

@end
