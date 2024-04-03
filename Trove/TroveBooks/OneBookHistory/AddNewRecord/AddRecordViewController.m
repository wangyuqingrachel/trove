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
#import "TroveStorage.h"

static CGFloat const kPadding = 20;

@interface AddRecordViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *bookTitle;
@property (nonatomic, assign) NSInteger lastReadTo;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *pagePicker;
@property (nonatomic, strong) UITextView *noteField;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) TroveRecordModel *brandNewRecord;

@end

@implementation AddRecordViewController

- (instancetype)initWithBook:(NSString *)bookTitle
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartVC) name:TroveSwitchThemeNotification object:nil];
        self.bookTitle = bookTitle;
        self.lastReadTo = 0;
        if ([TroveStorage getBook:bookTitle].records.count > 0) {
            self.lastReadTo = [[TroveStorage getBook:self.bookTitle].records[0].page integerValue];
        }
        UITapGestureRecognizer *tapRecognizer = [UITapGestureRecognizer new];
        [tapRecognizer addTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)restartVC
{
    // 将vc.view里的所有subviews全部置为nil
    self.datePicker = nil;
    self.pagePicker = nil;
    self.noteField = nil;
    self.saveButton = nil;
    // 将vc.view里的所有subviews从父view上移除
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self p_setupUI];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupUI];
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor troveColorNamed:[TroveStorage getBook:self.bookTitle].color];
    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kPadding);
        make.width.mas_equalTo((kScreenWidth-2*kPadding)/2);
        make.top.offset(kScreenHeight/5);
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

#pragma mark - Actions

- (void)dismissKeyboard
{
    [self.noteField endEditing:YES];
}

- (void)saveRecord
{
    self.brandNewRecord.date = self.datePicker.date; //更新date
    self.brandNewRecord.note = self.noteField.text; //更新note
    [TroveStorage addRecord:self.brandNewRecord toBook:self.bookTitle];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[TroveStorage getBook:self.bookTitle].totalPages integerValue] - self.lastReadTo;
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
    label.text = [@"Page " stringByAppendingString:[@(row+self.lastReadTo+1)stringValue]];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.brandNewRecord.page = @(row+self.lastReadTo+1); //实时更新page
}

#pragma mark - Getters

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        TroveBookModel *book = [TroveStorage getBook:self.bookTitle];
        _datePicker.tintColor = [UIColor troveColorNamed:book.color];
        if (book.records.count > 0) {
            _datePicker.minimumDate = book.records[0].date;
        }
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
        _noteField.layer.borderColor = [UIColor troveColorNamed:TroveColorTypeText].CGColor;
        _noteField.layer.borderWidth = 1;
        _noteField.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
        [_saveButton addTarget:self action:@selector(saveRecord) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (TroveRecordModel *)brandNewRecord
{
    if (!_brandNewRecord) {
        _brandNewRecord = [[TroveRecordModel alloc] initWithDate:self.datePicker.date page:@(self.lastReadTo+1) note:@""];
    }
    return _brandNewRecord;
}

@end
