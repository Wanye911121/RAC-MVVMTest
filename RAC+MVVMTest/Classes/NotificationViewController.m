//
//  NotificationViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITextField *textField = [UITextField new];
    textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@44);
    }];
    
    [[textField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(id x) {
        //return之后隐藏键盘
        //x是TextField
        NSLog(@"%@",x);
    }];
    
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        //这里x是NSNotification
        NSLog(@"键盘即将弹出的通知%@",x);
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(id x) {
        //这里x是NSNotification
        NSLog(@"键盘即将关闭的通知%@",x);
    }];
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
