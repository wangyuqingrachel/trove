//
//  TroveBookCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "TroveBookCell.h"
#import <Masonry/Masonry.h>
#import "TroveRecordModel.h"
#import "UIColor+TroveColor.h"

static CGFloat const kLeftRight = 10;
static CGFloat const kSpace = 10;
static CGFloat const kMajorElement = 20;
static CGFloat const kMinorElement = 16;
static CGFloat const kPercentageWidth = 45; // 100%的长度

@interface TroveBookCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *totalPageLabel;
@property (nonatomic, strong) UIView *progressBarHolder;
@property (nonatomic, strong) UIView *progressBar;
@property (nonatomic, strong) UILabel *percentageLabel;

@property (nonatomic, strong) UIImageView *crownView;

@end

@implementation TroveBookCell

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

+ (CGFloat)cellHeight
{
    return 2*kMajorElement + 3*kSpace + 10; //下面padding大一些好看，+10更和谐
}

- (void)configWithBookModel:(TroveBookModel *)book
{
    self.backgroundColor = [UIColor troveColorNamed:book.color];
    self.layer.cornerRadius = 10;
    // Crown
    [self addSubview:self.crownView];
    [self.crownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.height.mas_equalTo(40);
    }];
    self.crownView.hidden = YES;
    // Title
    self.titleLabel.text = book.bookTitle;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftRight);
        make.top.offset(kSpace);
        make.height.mas_equalTo(kMajorElement);
    }];
    // Total pages
    NSString *currentPage = book.records.count ? [book.records[0].page stringValue] : @"0";
    NSString *totalPages = [book.totalPages stringValue];
    self.totalPageLabel.text = [[currentPage stringByAppendingString:@"/"] stringByAppendingString:totalPages];
    [self addSubview:self.totalPageLabel];
    [self.totalPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kLeftRight);
        make.top.offset(kSpace);
        make.height.mas_equalTo(kMajorElement);
    }];
    // Bar holder
    CGFloat holderWidth = self.frame.size.width - 3*kSpace - kPercentageWidth;
    [self addSubview:self.progressBarHolder];
    [self.progressBarHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftRight);
        make.width.mas_equalTo(holderWidth);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kMajorElement);
    }];
    // Bar
    CGFloat percentage = book.records.count ? [book.records[0].page doubleValue] / [book.totalPages doubleValue] : 0;
    if (percentage >= 1) {
        percentage = 1;
        self.crownView.hidden = NO;
    }
    [self.progressBarHolder addSubview:self.progressBar];
    self.progressBar.backgroundColor = [UIColor trovePulseColorType:book.color];
    [self.progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
    }];
    [self.progressBar mas_updateConstraints:^(MASConstraintMaker *make) { // 动态的constraint必须这样写，否则不会更新
        make.width.mas_equalTo(holderWidth * percentage);
    }];
    // percentage tag
    self.percentageLabel.text = [[@(round(percentage * 100)) stringValue] stringByAppendingString:@"%"];
    [self addSubview:self.percentageLabel];
    [self.percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kLeftRight);
        make.width.mas_equalTo(kPercentageWidth);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kMajorElement);
    }];
}

#pragma mark - Getters

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:kMajorElement];
        _titleLabel.textColor = [UIColor troveColorNamed:TroveColorTypeText];
    }
    return _titleLabel;
}

- (UILabel *)totalPageLabel
{
    if (!_totalPageLabel) {
        _totalPageLabel = [UILabel new];
        _totalPageLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:kMinorElement];
        _totalPageLabel.textColor = [UIColor troveColorNamed:TroveColorTypeTextHint];
    }
    return _totalPageLabel;
}

- (UIView *)progressBarHolder
{
    if (!_progressBarHolder) {
        _progressBarHolder = [UIView new];
        _progressBarHolder.backgroundColor = [UIColor troveColorNamed:TroveColorTypeProgressHolder];
        _progressBarHolder.layer.cornerRadius = 10;
        _progressBarHolder.layer.borderWidth = 1;
        _progressBarHolder.layer.borderColor = [UIColor troveColorNamed:TroveColorTypeShadow].CGColor;
    }
    return _progressBarHolder;
}

- (UIView *)progressBar
{
    if (!_progressBar) {
        _progressBar = [UIView new];
        _progressBar.layer.cornerRadius = 10;
        _progressBar.layer.borderWidth = 1;
        _progressBar.layer.borderColor = [UIColor troveColorNamed:TroveColorTypeShadow].CGColor;
}
    return _progressBar;
}

- (UILabel *)percentageLabel
{
    if (!_percentageLabel) {
        _percentageLabel = [UILabel new];
        _percentageLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:kMajorElement];
        _percentageLabel.textColor = [UIColor troveColorNamed:TroveColorTypeText];
    }
    return _percentageLabel;
}

- (UIImageView *)crownView
{
    if (!_crownView) {
        _crownView = [UIImageView new];
        UIImage *iconImage = [[UIImage systemImageNamed:@"crown.fill"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_crownView setImage:[iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _crownView.transform = CGAffineTransformMakeRotation(-M_PI/4);
        _crownView.tintColor = [UIColor systemYellowColor];
        _crownView.alpha = 0.5;
    }
    return _crownView;
}


@end
