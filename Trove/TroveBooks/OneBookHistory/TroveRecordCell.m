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
static CGFloat const kTextLeftRightMagin = 20;
static CGFloat const kLineWidth = 1;
static CGFloat const kIconWidth = 30;
static CGFloat const kPlusWidth = 20;
static CGFloat const kDatePageHeight = 16;

@interface TroveRecordCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *icon;
@property (nonatomic, strong) UIImageView *edit;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) UILabel *noteLabel;

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
    [self.icon addSubview:self.edit];
    [self.edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.height.mas_equalTo(kPlusWidth);
    }];
    // Date label
    self.dateLabel.textColor = color;
    [self addSubview:self.dateLabel];
    self.dateLabel.text = [NSDateFormatter localizedStringFromDate:record.date
                                                         dateStyle:NSDateFormatterShortStyle
                                                         timeStyle:NSDateFormatterShortStyle];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line.mas_right).offset(kTextLeftRightMagin);
        make.top.offset(10);
        make.height.mas_equalTo(kDatePageHeight);
    }];
    // Page label
    self.pageLabel.textColor = color;
    [self addSubview:self.pageLabel];
    self.pageLabel.text = [@"Page " stringByAppendingString:[record.page stringValue]];
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self.dateLabel.mas_bottom);
    }];
    // Note label
    self.noteLabel.textColor = color;
    [self addSubview:self.noteLabel];
    self.noteLabel.text = record.note;
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line.mas_right).offset(kTextLeftRightMagin);
        make.right.offset(-kTextLeftRightMagin);
        make.top.mas_equalTo(self.dateLabel.mas_bottom).offset(10);
        make.bottom.offset(-10);
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

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:16];
    }
    return _dateLabel;
}

- (UILabel *)pageLabel
{
    if (!_pageLabel) {
        _pageLabel = [UILabel new];
        _pageLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:14];
    }
    return _pageLabel;
}

- (UILabel *)noteLabel
{
    if (!_noteLabel) {
        _noteLabel = [UILabel new];
        _noteLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:14];
        _noteLabel.textColor = [UIColor troveColorNamed:TroveColorTypeText];
    }
    return _noteLabel;
}

@end
