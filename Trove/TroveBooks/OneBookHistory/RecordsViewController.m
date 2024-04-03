//
//  RecordsViewController.m
//  Trove
//
//  Created by Yuqing Wang on 2024/4/3.
//

#import "RecordsViewController.h"
#import "TroveMacro.h"

@interface RecordsViewController ()

@property (nonatomic, strong) TroveBookModel *book;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation RecordsViewController

- (instancetype)initWithBook:(TroveBookModel *)book
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartVC) name:TroveSwitchThemeNotification object:nil];
        self.book = book;
    }
    return self;
}

- (void)restartVC
{
    self.collectionView = nil;
    [self p_setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupUI];
}

- (void)p_setupUI
{
    // background
    self.view.backgroundColor = [UIColor troveColorNamed:TroveColorTypeBackground];
    // navi button
    UIImage *iconImage = [[UIImage systemImageNamed:@"plus"]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *addRecordBotton = [[UIBarButtonItem alloc] initWithImage:iconImage style:UIBarButtonItemStylePlain target:self action:@selector(addRecord)];
    self.navigationItem.rightBarButtonItem = addRecordBotton;
    self.navigationItem.title = self.book.bookTitle;
}

#pragma mark - Action

- (void)addRecord
{
    
}

@end
