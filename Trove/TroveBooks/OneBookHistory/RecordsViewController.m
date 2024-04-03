//
//  RecordsViewController.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "RecordsViewController.h"
#import "TroveMacro.h"
#import "TroveRecordCell.h"
#import "AddTroveRecordCell.h"
#import <Masonry/Masonry.h>
#import "AddRecordViewController.h"
#import "TroveSettings.h"
#import "TroveStorage.h"

@interface RecordsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSString *bookTitle;
@property (nonatomic, strong) NSMutableArray<TroveRecordModel *> *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RecordsViewController

- (instancetype)initWithBookTitle:(NSString *)bookTitle
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartVC) name:TroveSwitchThemeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:TroveRecordAddNotification object:nil];
        self.bookTitle = bookTitle;
        self.dataSource = [TroveStorage getBook:self.bookTitle].records;
    }
    return self;
}

- (void)restartVC
{
    self.collectionView = nil;
    [self p_setupUI];
}

- (void)reloadData
{
    self.dataSource = [TroveStorage getBook:self.bookTitle].records;
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    // navi title
    self.navigationItem.title = self.bookTitle;
    // collection view
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height);
        make.left.right.bottom.offset(0);
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)selectedIndexPath
{
    if (selectedIndexPath.item == 0) {
        AddRecordViewController *vc = [[AddRecordViewController alloc] initWithBook:[TroveStorage getBook:self.bookTitle]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        AddTroveRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AddTroveRecordCell identifier] forIndexPath:indexPath];
        UIColor *color = [TroveSettings appliedDarkMode] ? [UIColor troveColorNamed:[TroveStorage getBook:self.bookTitle].color] : [UIColor trovePulseColorType:[TroveStorage getBook:self.bookTitle].color];
        BOOL isEnd = [collectionView numberOfItemsInSection:0] - 1 == indexPath.item;
        [cell configWithColor:color isEnd:isEnd];
        return cell;
    } else {
        TroveRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TroveRecordCell identifier] forIndexPath:indexPath];
        TroveRecordModel *model = self.dataSource[indexPath.item - 1];
        BOOL isEnd = [collectionView numberOfItemsInSection:0] - 1 == indexPath.item;
        [cell configWithColor:[UIColor troveColorNamed:[TroveStorage getBook:self.bookTitle].color] recordModel:model isEnd:isEnd];
        return cell;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth - 20, 80); // cell size
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
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
    return CGSizeMake(kScreenWidth, 0); // header
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 0); // footer
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
        [_collectionView registerClass:[AddTroveRecordCell class] forCellWithReuseIdentifier:[AddTroveRecordCell identifier]];
        [_collectionView registerClass:[TroveRecordCell class] forCellWithReuseIdentifier:[TroveRecordCell identifier]];
        [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}


@end
