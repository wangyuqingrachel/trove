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
#import "TroveStorage.h"
#import "UIColor+TroveColor.h"
#import "AddBookViewController.h"
#import "EditBookViewController.h"
#import "RecordsViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSMutableArray<TroveBookModel *> *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartVC) name:TroveSwitchThemeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:TroveBookCreateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:TroveBookEditNotification object:nil];
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
    [self.collectionView reloadData];
}

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
    UIImage *iconImage = [[UIImage systemImageNamed:@"plus"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *addBookBotton = [[UIBarButtonItem alloc] initWithImage:iconImage style:UIBarButtonItemStylePlain target:self action:@selector(addNewBook)];
    self.navigationItem.rightBarButtonItem = addBookBotton;
    self.navigationController.navigationBar.tintColor = [UIColor troveColorNamed:TroveColorTypeText];
    // collection view
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height);
        make.left.right.bottom.offset(0);
    }];
}

#pragma mark - Action

- (void)addNewBook
{
    AddBookViewController *addVC = [AddBookViewController new];
    [self.navigationController presentViewController:addVC animated:YES completion:nil];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
    EditBookViewController *editVC = [[EditBookViewController alloc] initWithBook:self.dataSource[selectedIndexPath.item]];
    [self.navigationController presentViewController:editVC animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)selectedIndexPath
{
    RecordsViewController *vc = [[RecordsViewController alloc] initWithBookTitle:self.dataSource[selectedIndexPath.item].bookTitle];
    [self.navigationController pushViewController:vc animated:YES];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TroveBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TroveBookCell identifier] forIndexPath:indexPath];
    TroveBookModel *model = self.dataSource[indexPath.item];
    [cell configWithBookModel:model];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.dataSource = [TroveStorage retriveTroveBooks];
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth - 20, [TroveBookCell cellHeight]); // cell size
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

        [_collectionView registerClass:[TroveBookCell class] forCellWithReuseIdentifier:[TroveBookCell identifier]];
        [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_collectionView addGestureRecognizer:longPress];
    }
    return _collectionView;
}



@end
