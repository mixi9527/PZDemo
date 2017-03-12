//
//  PZResultViewController.m
//  PZDemo
//
//  Created by 张佳佩 on 2017/03/10.
//  Copyright © 2017年 Jee. All rights reserved.
//

#import "PZResultViewController.h"
#import "PZSearchViewController.h"


@interface PZResultViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *sb;
@property (strong, nonatomic) IBOutlet UITableView *resultTableView;

@end

@implementation PZResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"%@", _searchText);
    [self createSB];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsCell"];
    }
    [cell.textLabel setFont:kFont(14)];
    [cell.textLabel setText:@"商品2"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)createSB {
    _sb = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    _sb.searchBarStyle = UISearchBarStyleDefault;
    [_sb setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    _sb.delegate = self;
    _sb.text = _searchText;
    _sb.placeholder = @"请输入搜索关键字";
    //设置背景图是为了去掉上下黑线
    //    sb.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    //    sb.barTintColor = [UIColor groupTableViewBackgroundColor];
    UITextField *searchField = [_sb valueForKey:@"searchField"];
    if (searchField) {
        searchField.returnKeyType = UIReturnKeySearch;
        searchField.backgroundColor = kRGB(0xEFEFEF);
        searchField.textColor = kRGB(0x31323A);
        searchField.clearButtonMode = UITextFieldViewModeNever;
    }
    [self.navigationItem setTitleView:_sb];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    PZSearchViewController *searchVC = [PZSearchViewController new];
    [self.rt_navigationController pushViewController:searchVC animated:NO complete:^(BOOL finished) {
        [self.sb resignFirstResponder];
        [searchVC beginSearch:searchBar.text];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
