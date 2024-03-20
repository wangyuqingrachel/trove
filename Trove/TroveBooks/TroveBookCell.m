//
//  TroveBookCell.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "TroveBookCell.h"
#import <Masonry/Masonry.h>
#import "TroveRecordModel.h"

static CGFloat const kLeftRight = 10;
static CGFloat const kSpace = 10;
static CGFloat const kElement = 20;
static CGFloat const kPercentageWidth = 60;

@interface TroveBookCell ()

@property (nonatomic, strong) UILabel *titleLabel; // "Game of Thrones"
@property (nonatomic, strong) UILabel *startsAtLabel; // "Starts at 2022/11/11"
@property (nonatomic, strong) UIView *progressBarHolder;
@property (nonatomic, strong) UIView *progressBar;
@property (nonatomic, strong) UILabel *percentageLabel; // 87%
@property (nonatomic, strong) UILabel *totalPageLabel; // 985 pages in total

@end

@implementation TroveBookCell

+ (NSString *)identifier
{
    return NSStringFromClass(self.class);
}

+ (CGFloat)cellHeight
{
    return 3*kElement + 4*kSpace;
}

- (void)configWithBookModel:(TroveBookModel *)book
{
    self.backgroundColor = [UIColor yellowColor];
    // title
    self.titleLabel.text = book.bookTitle;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftRight);
        make.top.offset(kSpace);
        make.height.mas_equalTo(kElement);
    }];
    // starts at
    TroveRecordModel *firstRecord = book.records.count ? book.records[0] : nil;
    self.startsAtLabel.text = firstRecord ? [NSDateFormatter localizedStringFromDate:firstRecord.date
                                                                           dateStyle:NSDateFormatterShortStyle
                                                                           timeStyle:NSDateFormatterFullStyle]:@"";
    [self addSubview:self.startsAtLabel];
    [self.startsAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftRight);
        make.top.offset(kSpace);
        make.height.mas_equalTo(kElement);
    }];
    // Bar holder
    [self addSubview:self.progressBarHolder];
    [self.progressBarHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftRight);
        make.width.mas_equalTo(self.frame.size.width - 3*kSpace - kPercentageWidth);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kElement);
    }];
    // Bar
    [self addSubview:self.progressBar];
    CGFloat percentage = book.records.count ? [book.records[book.records.count - 1].page doubleValue] / [book.totalPages doubleValue] : 0;
    [self.progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftRight);
        make.width.mas_equalTo((self.frame.size.width - 3*kSpace - kPercentageWidth) * percentage);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kElement);
    }];
    // percentage tag
    self.percentageLabel.text = [[@(percentage * 100) stringValue] stringByAppendingString:@"%"];
    [self addSubview:self.percentageLabel];
    [self.percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kLeftRight);
        make.width.mas_equalTo(kPercentageWidth);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(kElement);
    }];
    // total page
    NSString *currentPage = book.records.count ? [book.records[book.records.count - 1].page stringValue] : @"0";
    NSString *totalPages = [book.totalPages stringValue];
    self.totalPageLabel.text = [[currentPage stringByAppendingString:@"/"] stringByAppendingString:totalPages];
    [self addSubview: self.totalPageLabel];
    [self.totalPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kLeftRight);
        make.top.mas_equalTo(self.progressBarHolder.mas_bottom).offset(10);
        make.height.mas_equalTo(kElement);
    }];
    
}

#pragma mark - Getters
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)startsAtLabel
{
    if (!_startsAtLabel) {
        _startsAtLabel = [UILabel new];
    }
    return _startsAtLabel;
}

- (UIView *)progressBarHolder
{
    if (!_progressBarHolder) {
        _progressBarHolder = [UIView new];
        _progressBarHolder.backgroundColor = [UIColor whiteColor];
        _progressBarHolder.layer.cornerRadius = 10;
        _progressBarHolder.layer.borderWidth = 1;
        _progressBarHolder.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    return _progressBarHolder;
}

- (UIView *)progressBar
{
    if (!_progressBar) {
        _progressBar = [UIView new];
        _progressBar.backgroundColor = [UIColor systemTealColor];
        _progressBar.layer.cornerRadius = 10;
        _progressBar.layer.borderWidth = 1;
        _progressBar.layer.borderColor = [UIColor darkGrayColor].CGColor;
}
    return _progressBar;
}

- (UILabel *)percentageLabel
{
    if (!_percentageLabel) {
        _percentageLabel = [UILabel new];
    }
    return _percentageLabel;
}

- (UILabel *)totalPageLabel
{
    if (!_totalPageLabel) {
        _totalPageLabel = [UILabel new];
    }
    return _totalPageLabel;
}

@end
