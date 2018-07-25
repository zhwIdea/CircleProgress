//
//  ViewController.m
//  CircleProgress
//
//  Created by zhw_mac on 2018/7/25.
//  Copyright © 2018年 zhw_mac. All rights reserved.
//

#import "ViewController.h"
#import "SportStepViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"push";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPushBtn];
}


-(void)pushBtn:(UIButton *)sender{
    SportStepViewController *sportStepVC = [[SportStepViewController alloc] init];
    [self.navigationController pushViewController:sportStepVC animated:YES];
}


-(void)addPushBtn{
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(135, 300, 100, 40)];
    pushBtn.layer.cornerRadius = 10;
    pushBtn.layer.borderWidth = 1;
    pushBtn.layer.borderColor = [UIColor redColor].CGColor;
    [pushBtn setTitle:@"点击跳转" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [pushBtn addTarget:self action:@selector(pushBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
