//
//  ViewController.m
//  Trove
//
//  Created by Yuqing Wang on 2024/3/20.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "TroveMacro.h"
#import "TroveBookCell.h"
#import "AddNewBookCell.h"
#import "HistoryViewController.h"
#import "TroveStorage.h"
#import "UIColor+TroveColor.h"
#import "AddBookViewController.h"
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray<TroveBookModel *> *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 需要到viewDidAppear时navigationController才能就位，这时候让collectionView对齐才是准的
    if ([self.view.subviews containsObject:self.collectionView]) {
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height);
        }];
    }
}


- (void)p_setupUI
{
    // background
    self.view.backgroundColor = [UIColor troveColorNamed:TroveColorTypeBackground];
    // navi button
    UIImage *iconImage = [[UIImage systemImageNamed:@"calendar"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithImage:iconImage style:UIBarButtonItemStylePlain target:self action:@selector(goToHistory)];
    self.navigationItem.rightBarButtonItem = historyButton;
    // collection view
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height);
        make.left.right.bottom.offset(0);
    }];
}

#pragma mark - Action

- (void)goToHistory
{
    [self.navigationController pushViewController:[HistoryViewController new] animated:YES];
}

- (void)fieldsChange
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    // Title
    BOOL titleValid = NO;
    NSString *title = alertController.textFields[0].text;
    if (title.length) {
        titleValid = YES;
    }
    // Pages
    BOOL pagesValid = NO;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *pages = [formatter numberFromString:alertController.textFields[1].text];
    if (pages) {
        pagesValid = YES;
    }
    // Check
    if (titleValid && pagesValid) {
        alertController.actions[1].enabled = YES;
    } else {
        alertController.actions[1].enabled = NO;
    }
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)selectedIndexPath
{
    if (selectedIndexPath.item == [self.collectionView numberOfItemsInSection:0] - 1) { //最后一个cell
        AddBookViewController *addVC = [AddBookViewController new];
        [self.navigationController presentViewController:addVC animated:YES completion:nil];
    } else {

    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == [self.collectionView numberOfItemsInSection:0] - 1) { //最后一个cell
        AddNewBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AddNewBookCell identifier] forIndexPath:indexPath];
        [cell config];
        return cell;
    } else {
        TroveBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TroveBookCell identifier] forIndexPath:indexPath];
        TroveBookModel *model = self.dataSource[indexPath.item];
        [cell configWithBookModel:model];
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.dataSource = [TroveStorage retriveTroveBooks];
    return self.dataSource.count + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, [TroveBookCell cellHeight]); // cell size
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionViewCell *header;
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        return header;
    } else {
        UICollectionViewCell *footer;
        footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footer;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 10); // header
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 10); // footer
}

#pragma mark - Getters

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = self.view.backgroundColor;

        [_collectionView registerClass:[TroveBookCell class] forCellWithReuseIdentifier:[TroveBookCell identifier]];
        [_collectionView registerClass:[AddNewBookCell class] forCellWithReuseIdentifier:[AddNewBookCell identifier]];
        [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}



@end
