//
//  AddRecordViewController.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "AddRecordViewController.h"
#import "UIColor+TroveColor.h"
#import "TroveMacro.h"
#import <Masonry/Masonry.h>

static CGFloat const kPadding = 20;

@interface AddRecordViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) TroveBookModel *book;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *pagePicker;
@property (nonatomic, strong) UITextView *noteField;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation AddRecordViewController

- (instancetype)initWithBook:(TroveBookModel *)book
{
    self = [super init];
    if (self) {
        self.book = book;
        self.view.backgroundColor = [UIColor troveColorNamed:book.color];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupUI];
}

- (void)p_setupUI
{
    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kPadding);
        make.width.mas_equalTo((kScreenWidth-2*kPadding)/2);
        make.top.offset(kScreenHeight/4);
    }];
    [self.view addSubview:self.pagePicker];
    [self.pagePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kPadding);
        make.width.mas_equalTo((kScreenWidth-2*kPadding)/2);
        make.centerY.mas_equalTo(self.datePicker);
    }];
    [self.view addSubview:self.noteField];
    [self.noteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kPadding);
        make.right.offset(-kPadding);
        make.height.mas_equalTo(kScreenHeight/4);
        make.top.mas_equalTo(self.pagePicker.mas_bottom).offset(kPadding);
    }];
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noteField.mas_bottom).offset(kPadding);
        make.centerX.offset(0);
        make.left.offset(kScreenWidth/3);
        make.right.offset(-kScreenWidth/3);
    }];
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.book.totalPages integerValue];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return (kScreenWidth - 3*20)/4;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [UILabel new];
    label.textAlignment = component == 0 ? NSTextAlignmentRight : NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor troveColorNamed:TroveColorTypeText];
    label.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:17];
    label.text = [@"Page " stringByAppendingString:[@(row+1)stringValue]];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}


#pragma mark - Getters

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    return _datePicker;
}

- (UIPickerView *)pagePicker
{
    if (!_pagePicker) {
        _pagePicker = [UIPickerView new];
        _pagePicker.delegate = self;
    }
    return _pagePicker;
}

- (UITextView *)noteField
{
    if (!_noteField) {
        _noteField = [UITextView new];
        _noteField.backgroundColor = self.view.backgroundColor;
        _noteField.layer.borderColor = [UIColor trovePulseColorType:self.book.color].CGColor;
        _noteField.layer.borderWidth = 1;
        
    }
    return _noteField;
}

- (UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = [UIButton new];
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor troveColorNamed:TroveColorTypeText] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:20];
        _saveButton.layer.borderColor = [UIColor troveColorNamed:TroveColorTypeText] .CGColor;
        _saveButton.layer.borderWidth = 1;
        _saveButton.layer.cornerRadius = 12;
//        [_saveButton addTarget:self action:@selector(saveRecord) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}


@end
