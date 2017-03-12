//
//  PZSearchViewController.m
//  PZDemo
//
//  Created by 张佳佩 on 2017/03/10.
//  Copyright © 2017年 Jee. All rights reserved.
//

#import "PZSearchViewController.h"
#import "PZResultViewController.h"

@interface PZSearchViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

/**
 搜索栏
 通过UItextField实现
 */
@property (strong, nonatomic) UITextField *textField;
/// 搜索提示列表视图
@property (strong, nonatomic) UITableView *tipTableView;

/// 热门搜索和历史搜索列表视图
@property (strong, nonatomic) UITableView *searchTableView;
/// 热门搜索容器
@property (strong, nonatomic) UIView *tableViewHeaderView;

/// 历史搜索数据
@property (strong, nonatomic) NSArray *histories;
/// 搜索提示数据
@property (strong, nonatomic) NSArray *tips;
/// 热门搜索数据
@property (strong, nonatomic) NSArray *hots;

@property (nonatomic, strong) PZResultViewController *resultVC;
@end

@implementation PZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSearchContainerView];
    [self createTableView];
    _tips = @[].copy;
    _hots = @[].copy;
    _histories = @[@"感冒灵", @"云南白药", @"西瓜霜", @"人生如梦", @"爱如潮水", @"你是个猪", @"测试数据"];
    _resultVC = [PZResultViewController new];
}

/// 开始搜索
- (void)beginSearch:(NSString *)text {
    _textField.text = text;
    // 去空格
    NSString *result = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    // 看剩下的字符串的长度是否为零
    if (result.length > 0) {
        // 模拟数据
        _tips = @[@"搜索提示111", @"搜索提示11123123", @"搜索提示111231312", @"阿3123我是大师傅", @"达瓦发额外确认", @"挖到哇等我", @"服务费特发"];
        [_tipTableView setHidden:NO];
        [self.tipTableView reloadData];
    } else {
        _tips = @[];
        [_tipTableView setHidden:YES];
    }
}

/// 重写返回按钮
- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action {
    return nil;
}

/// 初始化tableView
- (void)createTableView {
    // 热门搜索视图
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    // 头部视图(用来防止热门搜索标签)
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSW, 200)];
    _tableViewHeaderView.backgroundColor = kRColor;
    _searchTableView.tableHeaderView = _tableViewHeaderView;
    _searchTableView.tableFooterView = [UIView new];
    [self.view addSubview:_searchTableView];
    [_searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 搜索提示视图
    _tipTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tipTableView.delegate = self;
    _tipTableView.dataSource = self;
    _tipTableView.tableFooterView = [UIView new];
    [_tipTableView setHidden:YES];
    [self.view addSubview:_tipTableView];
    [_tipTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tips.count == 0) {
        return _histories.count;
    }
    return _tips.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_tips.count > 0) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_tips.count > 0) {
        return nil;
    }
    UIView *headerView = [UIView new];
    headerView.backgroundColor = kRGB(0XFFFFFF);
    headerView.frame = CGRectMake(0, 0, kSW, 40);
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, headerView.height)];
//    title.backgroundColor = kRColor;
    [title setText:@"搜索历史"];
    [title setFont:kFont(14)];
    [title setTextColor:kRGB(0x31323A)];
    [headerView addSubview:title];
    // 清空按钮
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    clearButton.backgroundColor = kRColor;
    [clearButton sizeToFit];
    [clearButton setFrame:CGRectMake(kSW - 80, 0, 80, headerView.height)];
    [clearButton setTitle:@"清除记录" forState:UIControlStateNormal];
    [clearButton setTitleColor:kRGB(0x31323A) forState:UIControlStateNormal];
    [clearButton.titleLabel setFont:kFont(14)];
    [clearButton addTarget:self action:@selector(clearHistories) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:clearButton];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tips.count > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipsCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tipsCell"];
        }
        [cell.textLabel setText:_tips[indexPath.row]];
        return cell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historiesCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"historiesCell"];
        }
        [cell.textLabel setFont:kFont(14)];
        [cell.textLabel setText:_histories[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_tips.count > 0) {
        // 点击了搜索提示
        _resultVC.searchText = _tips[indexPath.row];
    } else {
        // 点击了历史记录
        _resultVC.searchText = _histories[indexPath.row];
    }
    @weakify(self);
    [self.rt_navigationController pushViewController:_resultVC animated:YES complete:^(BOOL finished) {
        @strongify(self);
        [self removeViewController:self.resultVC];
    }];
    
}

/// 移除重复的搜索和搜索结果视图控制器
- (void)removeViewController:(UIViewController *)viewController {
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.rt_navigationController rt_viewControllers]];
    for (int i = 0; i < array.count; i++) {
        UIViewController *vc = [array objectAtIndex:i];
        if ([vc isKindOfClass:[self class]]) {
            // 去掉之前的搜索界面
            [array removeObject:vc];
            i--;
        } else if ([vc isKindOfClass:[viewController class]]) {
            // 去掉重复的药品列表界面
            [array removeObject:vc];
            i--;
        }
    }
    [array addObject:viewController];
    [self.rt_navigationController setViewControllers:array animated:NO];

}

/// 初始化导航栏搜索栏
- (void)createSearchContainerView {
    // 文本输入框
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, kSW - 60, 30)];
    _textField.backgroundColor = kRGB(0xEFEFEF);
    _textField.layer.cornerRadius = 8.0f;
    _textField.placeholder = @"联想笔记本";
    _textField.font = kFont(14);
    _textField.textColor = kRGB(0x31323A);
    _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    // 输入框文字改变
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    // 点击了搜索按钮
    [_textField addTarget:self action:@selector(searchFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.navigationController.navigationBar addSubview:_textField];
    [_textField becomeFirstResponder];
    // 左边搜索小图标
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    [searchIcon setCenter:CGPointMake(15, 15)];
    [searchView addSubview:searchIcon];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.leftView = searchView;
    // 取消按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:kRGB(0x31323A) forState:UIControlStateNormal];
    [button.titleLabel setFont:kFont(14)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(kSW - 50, 7, 50, 30)];
    [self.navigationController.navigationBar addSubview:button];
}

/// 开始输入文字 展示搜索提示
- (void)textFieldDidChange:(UITextField *)textField {
    [self beginSearch:textField.text];
}

/// 点击搜索按钮
- (void)searchFinished:(UITextField *)textField {
    // 去空格
    NSString *result = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (result.length > 0) {
        _resultVC.searchText = textField.text;
    } else {
        _resultVC.searchText = textField.placeholder;
    }
    @weakify(self);
    [self.rt_navigationController pushViewController:self.resultVC animated:YES complete:^(BOOL finished) {
        @strongify(self);
        [self removeViewController:self.resultVC];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_textField resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_textField resignFirstResponder];
}

/// 扫码
- (void)scan {
    DLog(@"扫码....");
}

/// 取消
- (void)cancel {
    DLog(@"取消搜索了...");
    [_textField resignFirstResponder];
    [self.rt_navigationController popViewControllerAnimated:NO];
}

/// 清除历史记录
- (void)clearHistories {
    DLog(@"清除记录....");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
