//
//  SportStepViewController.m
//  LocatorWatch
//
//  Created by hongwei Zheng on 2018/7/19.
//  Copyright © 2018年 hongwei Zheng. All rights reserved.
//

#import "SportStepViewController.h"
#import "CircleProgressView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface SportStepViewController ()
@property(nonatomic,strong)CircleProgressView *progressView;
@end

@implementation SportStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动计步";
    self.view.backgroundColor = [UIColor whiteColor];
    //圆形加载View
    _progressView = [[CircleProgressView alloc] init];
    _progressView.frame = CGRectMake(SCREEN_WIDTH/2 - 125, 100, 250, 250);
    _progressView.progress = 6899.0 / 10000.0;
    [self.view addSubview:_progressView];
    
    [self addRefreshBtn];
    
}


-(void)refreshBtn:(UIButton *)sender{
    _progressView.progress = 3000.0 / 10000.0;
    [_progressView setNeedsDisplay];//重绘View
}


-(void)addRefreshBtn{
    UIButton *refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 450, 70, 35)];
    refreshBtn.layer.cornerRadius = 10;
    refreshBtn.layer.borderWidth = 1;
    refreshBtn.layer.borderColor = [UIColor greenColor].CGColor;
    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [refreshBtn addTarget:self action:@selector(refreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
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
