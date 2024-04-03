//
//  EditBookViewController.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "EditBookViewController.h"
#import "ColorCollectionViewCell.h"
#import "TroveMacro.h"
#import "TroveStorage.h"
#import <Masonry/Masonry.h>

static CGFloat const kAddTaskVCPadding = 20;
static CGFloat const kHeightRatio = 0.8;

@interface EditBookViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString *originalTitle;
@property (nonatomic, strong) TroveBookModel *book; //新创建的task，由于OC不允许使用new作为property的前缀，这里使用了brand new
@property (nonatomic, strong) UITextField *enterBookNameTextField;
@property (nonatomic, strong) UITextField *enterBookPageTextField;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<TroveColorModel *> *colorBlocks;
@property (nonatomic, strong) UIButton *discardButton;
@property (nonatomic, strong) UIButton *saveButton;


@end

@implementation EditBookViewController

- (instancetype)initWithBook:(TroveBookModel *)book
{
    self = [super init];
    if (self) {
        self.originalTitle = book.bookTitle;
        self.book = book;
        self.view.backgroundColor = [UIColor troveColorNamed:book.color];
        self.enterBookNameTextField.text = book.bookTitle;
        self.enterBookPageTextField.text = [book.totalPages stringValue];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupUI];
    [self.enterBookNameTextField becomeFirstResponder];
}

- (void)viewDidLayoutSubviews
{
    // 创建task页面为半屏
    [self.view setFrame:CGRectMake(0, kScreenHeight*(1-kHeightRatio), kScreenWidth, kScreenHeight*kHeightRatio)];
    self.view.layer.cornerRadius = 20;
    self.view.layer.masksToBounds = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewGetsTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.view.superview addGestureRecognizer:tapRecognizer];
}

- (void)clickSaveButton
{
    // BOOK NAME
    NSString *booktitle = self.enterBookNameTextField.text;
    BOOL booknameEmpty = !booktitle || [booktitle isEqualToString:@""];
    BOOL booknameInvalid = [TroveStorage bookNameExists:booktitle] && ![booktitle isEqualToString:self.originalTitle];
    // BOOK PAGES
    NSString *bookpages = self.enterBookPageTextField.text;
    BOOL bookpagesEmpty = !bookpages || [bookpages isEqualToString:@""];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *pages = [formatter numberFromString:bookpages];
    BOOL bookpageInvalid = !pages;
    if (!booknameEmpty && !booknameInvalid && !bookpagesEmpty && !bookpageInvalid) {
        [self dismissViewControllerAnimated:YES completion:^{
            self.book.bookTitle = booktitle; //taskname退出时更新
            self.book.totalPages = pages;
            [TroveStorage editBook:self.originalTitle toBook:self.book];
        }];
    } else if (booknameEmpty) {
        UIAlertController* newNameIsEmptyAlert = [UIAlertController alertControllerWithTitle:@"bookname_cannot_be_empty" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* understandAction = [UIAlertAction actionWithTitle:@"gotcha" style:UIAlertActionStyleDefault handler:nil];
        [newNameIsEmptyAlert addAction:understandAction];
        [self presentViewController:newNameIsEmptyAlert animated:YES completion:nil];
    } else if (booknameInvalid){
        UIAlertController* newNameIsDuplicateAlert = [UIAlertController alertControllerWithTitle:@"bookname_cannot_be_duplicated" message: nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* understandAction = [UIAlertAction actionWithTitle:@"gotcha" style:UIAlertActionStyleDefault handler:nil];
        [newNameIsDuplicateAlert addAction:understandAction];
        [self presentViewController:newNameIsDuplicateAlert animated:YES completion:nil];
    } else if (bookpagesEmpty) {
        UIAlertController* newNameIsDuplicateAlert = [UIAlertController alertControllerWithTitle:@"bookpage_cannot_be_empty" message: nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* understandAction = [UIAlertAction actionWithTitle:@"gotcha" style:UIAlertActionStyleDefault handler:nil];
        [newNameIsDuplicateAlert addAction:understandAction];
        [self presentViewController:newNameIsDuplicateAlert animated:YES completion:nil];
    } else if (bookpageInvalid) {
        UIAlertController* newNameIsDuplicateAlert = [UIAlertController alertControllerWithTitle:@"bookpage_invalid" message: nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* understandAction = [UIAlertAction actionWithTitle:@"gotcha" style:UIAlertActionStyleDefault handler:nil];
        [newNameIsDuplicateAlert addAction:understandAction];
        [self presentViewController:newNameIsDuplicateAlert animated:YES completion:nil];
    }


}

- (void)clickDiscardButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)p_setupUI
{
    [self.view addSubview:self.enterBookNameTextField];
    [self.enterBookNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.centerX.offset(0);
        make.width.mas_equalTo(kScreenWidth - 2*kAddTaskVCPadding);
    }];
    [self.view addSubview:self.enterBookPageTextField];
    [self.enterBookPageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.enterBookNameTextField.mas_bottom).offset(8);
        make.centerX.offset(0);
        make.width.mas_equalTo(kScreenWidth - 2*kAddTaskVCPadding);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.enterBookPageTextField.mas_bottom).offset(16);
        make.centerX.offset(0);
        make.width.mas_equalTo(kScreenWidth - 2*kAddTaskVCPadding);
        make.height.mas_equalTo([self p_colorBlockWidth]);
    }];
    
    [self.view addSubview:self.discardButton];
    [self.view addSubview:self.saveButton];
    [self.discardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(20);
        make.left.offset(kAddTaskVCPadding);
        make.width.mas_equalTo(kScreenWidth/2-kAddTaskVCPadding);
        make.height.mas_equalTo(40);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.discardButton.mas_right).offset(0);
        make.width.mas_equalTo(kScreenWidth/2-kAddTaskVCPadding);
        make.height.mas_equalTo(40);
    }];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 选中某色块时，更新背景颜色为该色块颜色，更新model的颜色为该色块颜色
    TroveColorType selectedColor =  self.colorBlocks[indexPath.item].color;
    self.view.backgroundColor = [UIColor troveColorNamed:selectedColor];
    self.book.color = selectedColor; // 颜色实时更新
    [collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kMaxColorNum;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 展示所有色块
    TroveColorModel *taskModel = (TroveColorModel *)self.colorBlocks[indexPath.item];
    taskModel.isSelected = CGColorEqualToColor([UIColor troveColorNamed:taskModel.color].CGColor, [UIColor troveColorNamed:self.book.color].CGColor); // 如果某色块和当前model的颜色一致，标记为选中
    ColorCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:[ColorCollectionViewCell identifier] forIndexPath:indexPath];
    // 更新色块（颜色、是否选中）
    [cell configWithModel:taskModel];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self p_colorBlockWidth];
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - Actions
// 给superview添加了点击手势（为了在点击上方不属于self.view的地方可以dismiss掉self）
- (void)viewGetsTapped:(UIGestureRecognizer *)tapRecognizer
{
    CGPoint touchPoint = [tapRecognizer locationInView:self.view];
    if (touchPoint.y <= 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIGestureRecognizerDelegate
// 这里需要判断下，如果点击的位置属于self.view，这时候忽略superview上的手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self.view];
    if (touchPoint.y <= 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Getters

- (UITextField *)enterBookNameTextField
{
    if (!_enterBookNameTextField) {
        _enterBookNameTextField = [UITextField new];
        _enterBookNameTextField.placeholder = @"enter_book_title";
        _enterBookNameTextField.textColor = [UIColor troveColorNamed:TroveColorTypeText];
        _enterBookNameTextField.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:20];
        _enterBookNameTextField.enabled = YES;
        _enterBookNameTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _enterBookNameTextField;
}

- (UITextField *)enterBookPageTextField
{
    if (!_enterBookPageTextField) {
        _enterBookPageTextField = [UITextField new];
        _enterBookPageTextField.placeholder = @"enter_book_page";
        _enterBookPageTextField.textColor = [UIColor troveColorNamed:TroveColorTypeText];
        _enterBookPageTextField.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:20];
        _enterBookPageTextField.enabled = YES;
        _enterBookPageTextField.textAlignment = NSTextAlignmentCenter;
        _enterBookPageTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _enterBookPageTextField;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[ColorCollectionViewCell class] forCellWithReuseIdentifier:[ColorCollectionViewCell identifier]];
    }
    return _collectionView;
}

- (NSArray<TroveColorModel *> *)colorBlocks
{
    TroveColorModel *pinkModel = [TroveColorModel new];
    pinkModel.color = TroveColorTypeCellPink;
    TroveColorModel *orangeModel = [TroveColorModel new];
    orangeModel.color = TroveColorTypeCellOrange;
    TroveColorModel *yellowModel = [TroveColorModel new];
    yellowModel.color = TroveColorTypeCellYellow;
    TroveColorModel *greenModel = [TroveColorModel new];
    greenModel.color = TroveColorTypeCellGreen;
    TroveColorModel *tealModel = [TroveColorModel new];
    tealModel.color = TroveColorTypeCellTeal;
    TroveColorModel *blueModel = [TroveColorModel new];
    blueModel.color = TroveColorTypeCellBlue;
    TroveColorModel *purpleModel = [TroveColorModel new];
    purpleModel.color = TroveColorTypeCellPurple;
    TroveColorModel *grayModel = [TroveColorModel new];
    grayModel.color = TroveColorTypeCellGray;
    return @[pinkModel,orangeModel,yellowModel,greenModel,tealModel,blueModel,purpleModel,grayModel];
}

- (UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = [UIButton new];
        // icon
        [_saveButton setImage:[[UIImage systemImageNamed:@"checkmark.rectangle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        _saveButton.tintColor = [UIColor troveColorNamed:TroveColorTypeText];
        // title
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor troveColorNamed:TroveColorTypeText] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:20];
        // padding
        _saveButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        // action
        [_saveButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (UIButton *)discardButton
{
    if (!_discardButton) {
        _discardButton = [UIButton new];
        // icon
        [_discardButton setImage:[[UIImage systemImageNamed:@"xmark.rectangle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        _discardButton.tintColor = [UIColor troveColorNamed:TroveColorTypeText];
        // title
        [_discardButton setTitle:@"Discard" forState:UIControlStateNormal];
        [_discardButton setTitleColor:[UIColor troveColorNamed:TroveColorTypeText] forState:UIControlStateNormal];
        _discardButton.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS-Italic" size:20];
        // padding
        _discardButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        // action
        [_discardButton addTarget:self action:@selector(clickDiscardButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _discardButton;
}

#pragma mark - Private methods

- (CGFloat)p_colorBlockWidth
{
    return (kScreenWidth - 2*kAddTaskVCPadding)/kMaxColorNum;
}


@end

