//
//  PZBaseViewController.m
//  PZDemo
//
//  Created by 张佳佩 on 2017/03/11.
//  Copyright © 2017年 Jee. All rights reserved.
//

#import "PZBaseViewController.h"

@interface PZBaseViewController ()

@end

@implementation PZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = kRColor;
}

- (UIBarButtonItem *)customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    //图片 居左
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    return backItem;
}

- (void)back {
    [self.rt_navigationController popViewControllerAnimated:YES];
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
