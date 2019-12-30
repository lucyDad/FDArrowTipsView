//
//  ViewController.m
//  xxdemo
//
//  Created by hexiang on 2018/7/6.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ArrowTipsView.h"
#import <Masonry/Masonry.h>

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface FDListViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation FDListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = UIColorHex(333333);
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    self.iconImageView = ({
        UIImageView *imageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"icon_kobe" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        imageView.image = image;
        imageView;
    });
    self.lineView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:0.3f];
        view;
    });
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.lineView];
    
    UIView *superView = self.contentView;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(10);
        make.centerY.equalTo(superView);
        make.size.equalTo(@(CGSizeMake(30, 30)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.bottom.right.equalTo(superView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(superView);
        make.height.mas_equalTo(0.5f);
    }];
}

@end

static NSString *kTableViewCellReuseIdentifier =  @"kTableViewCellReuseIdentifier";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrDatas;

@end

@implementation ViewController

#pragma mark - Public Interface

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];
}

#pragma mark - Delegates

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseIdentifier];
    
    NSString *text = [self.arrDatas objectAtIndex:indexPath.row];
    cell.titleLabel.text = text;
    
    return cell;
}

#pragma mark -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SuppressPerformSelectorLeakWarning([self performSelector:NSSelectorFromString([NSString stringWithFormat:@"showArrowTipsView_%zd", indexPath.row])];);
}

#pragma mark - Private Methods

- (void)setupUI {
    [self.view addSubview:self.tableView];
    UIView *superView = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

- (void)setupData {
    self.arrDatas = @[@"文本的箭头", @"固定宽度的文本的箭头", @"不同箭头方向的文本的箭头", @"固定箭头偏移位置的文本的箭头", @"带列表的箭头", @"带背景的文本箭头", @"带背景的列表箭头"];
}

- (void)showArrowTipsView_0 {
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));
    [self.tableView showArrowTipsViewWithText:@"这里可以是很长的文案;这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案" point:point];
}

- (void)showArrowTipsView_1 {
    
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));
    [self.tableView showArrowTipsViewWithText:@"这里可以是很长的文案;这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案" maxWidth:200 point:point];
}

- (void)showArrowTipsView_2 {
    
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame));
    
    FDArrowTipsViewConfig *config = [FDArrowTipsViewConfig new];
    config.gradientBeginColor = [UIColor greenColor];
    config.gradientEndColor = [UIColor greenColor];
    config.contentCornerRadius = 5;
    config.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    config.autoTimeOutClose = NO;
    config.originDirection = FDArrowDirection_Left;
    
    UIButton *customView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    customView.backgroundColor = [UIColor redColor];
    FDArrowTipsView *tipsView = [self.tableView showArrowTipsViewWithConfig:config withCustomView:customView point:point];
    @weakify(tipsView);
    [customView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(tipsView);
        [tipsView dismissTipsView];
    }];
}

- (void)showArrowTipsView_3 {
    
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame));
    
    FDArrowTipsViewConfig *config = [FDArrowTipsViewConfig new];
    config.gradientBeginColor = [UIColor greenColor];
    config.gradientEndColor = [UIColor greenColor];
    config.contentCornerRadius = 5;
    config.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    config.autoTimeOutClose = NO;
    config.fixedOffset = 40;
    config.originDirection = FDArrowDirection_Left;
    
    UIButton *customView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    customView.backgroundColor = [UIColor redColor];
    FDArrowTipsView *tipsView = [self.tableView showArrowTipsViewWithConfig:config withCustomView:customView point:point];
    @weakify(tipsView);
    [customView addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(tipsView);
        [tipsView dismissTipsView];
    }];
}

- (void)showArrowTipsView_4 {
    
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame));
    
    NSArray *titles = @[@"文字", @"相册", @"拍照", @"短视频", @"语音"];
    NSArray *images = @[[UIImage imageNamed:@"arrow_popView_text"], [UIImage imageNamed:@"arrow_popView_album"], [UIImage imageNamed:@"arrow_popView_photo"],[UIImage imageNamed:@"arrow_popView_camera"], [UIImage imageNamed:@"arrow_popView_audio"]];
    FDArrowCustomListViewConfig *listConfig = [FDArrowCustomListViewConfig new];
    listConfig.cellHeight = 50;
    listConfig.titles = titles;
    listConfig.images = images;
    listConfig.titleColor = [UIColor whiteColor];
    
    FDArrowTipsViewConfig *config = [FDArrowTipsViewConfig new];
    config.contentCornerRadius = 5;
    config.contentEdgeInsets = UIEdgeInsetsZero;
    config.autoTimeOutClose = NO;
    config.originDirection = FDArrowDirection_Left;
    
    [self.tableView showArrowTipsViewWithListConfig:listConfig withTipConfig:config withPoint:point clickBlock:^(NSInteger index) {
        LOGGO_INFO(@"click index = %zd", index);
    }];
}

- (void)showArrowTipsView_5 {
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame));
    [self.tableView showArrowTipsBackgroundViewWithText:@"这里可以是很长的文案;这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案这里可以是很长的文案" point:point];
}

- (void)showArrowTipsView_6 {
    
    FDListViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    
    CGRect frame = [cell.iconImageView.superview convertRect:cell.iconImageView.frame toView:self.tableView];
    CGPoint point = CGPointMake(CGRectGetMaxX(frame), CGRectGetMidY(frame));
    
    NSArray *titles = @[@"文字", @"相册", @"拍照", @"短视频", @"语音"];
    NSArray *images = @[[UIImage imageNamed:@"arrow_popView_text"], [UIImage imageNamed:@"arrow_popView_album"], [UIImage imageNamed:@"arrow_popView_photo"],[UIImage imageNamed:@"arrow_popView_camera"], [UIImage imageNamed:@"arrow_popView_audio"]];
    FDArrowCustomListViewConfig *listConfig = [FDArrowCustomListViewConfig new];
    listConfig.cellHeight = 50;
    listConfig.titles = titles;
    listConfig.images = images;
    listConfig.titleColor = [UIColor whiteColor];
    
    FDArrowTipsViewConfig *config = [FDArrowTipsViewConfig new];
    config.contentCornerRadius = 5;
    config.contentEdgeInsets = UIEdgeInsetsZero;
    config.autoTimeOutClose = NO;
    config.originDirection = FDArrowDirection_Left;
    
    FDAnimationManagerView *view = [self.tableView showArrowTipsBackgroundViewWithListConfig:listConfig withTipConfig:config withPoint:point clickBlock:^(NSInteger index) {
        LOGGO_INFO(@"click index = %zd", index);
    }];
    view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.4f];
}

#pragma mark - Setter or Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView registerClass:[FDListViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
            tableView.dataSource = self;
            tableView.delegate   = self;
            tableView;
        });
    }
    return _tableView;
}

@end
