//
//  GestureViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "GestureViewController.h"

static CGFloat percent  = 1;

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *tapView = [UIView new];
    tapView.userInteractionEnabled = YES;
    tapView.backgroundColor = [UIColor redColor];
    [self.view addSubview:tapView];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
    [[tap rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer * tap) {
        NSLog(@"手势事件触发后的处理%@",tap);

        [UIView animateWithDuration:0.5 animations:^{
            percent = percent - 0.1;
            tapView.transform = CGAffineTransformMakeScale(percent, percent);
        } completion:^(BOOL finished) {
            tapView.transform = CGAffineTransformIdentity;
        }];
    }];
    [tapView addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
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
