//
//  DelegateViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "DelegateViewController.h"

@interface DelegateViewController ()

@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否确认登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple * tuple) {
        NSLog(@"%@",tuple);
    }];
    [alertView show];
    
    
    
//    //	更简单的方式：
//    [[alertView rac_buttonClickedSignal]subscribeNext:^(id x) {
//
//    }];
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
