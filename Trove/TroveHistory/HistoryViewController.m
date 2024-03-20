//
//  HistoryViewController.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "HistoryViewController.h"
#import <Masonry/Masonry.h>

@interface HistoryViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupUI];
}


- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height);
        make.left.offset(10);
        make.right.offset(-10);
    }];
    [self.view addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.datePicker.mas_bottom).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
    }];
}

#pragma mark - Action

- (void)selectDate
{
    self.detailLabel.text = [self textFromDate:self.datePicker.date];
}

- (NSString *)textFromDate:(NSDate *)date
{
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterShortStyle
                                          timeStyle:NSDateFormatterFullStyle];
}


#pragma mark - Getters

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleInline;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.text = [self textFromDate:_datePicker.date];
    }
    return _detailLabel;
}


@end
