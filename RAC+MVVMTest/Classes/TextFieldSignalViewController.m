//
//  TextFieldSignalViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "TextFieldSignalViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface TextFieldSignalViewController ()

@end

@implementation TextFieldSignalViewController

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
    
    [[[[[textField.rac_textSignal
        distinctUntilChanged]
        //这次和上次信号不一样，才会发送,
        //注：用于刷新页面，当数据不一样才刷新
        delay:1]
        //延迟1秒接收到信号
        ignore:@"1"]
        //忽略“1”的信号发送
        filter:^BOOL(NSString* text) {
        //过滤事件，只允许长度大于2发信号
        //每次信号发出，会先执行过滤条件判断.
        return text.length > 2;
    }] subscribeNext:^(id x) {
        //接收订阅的信号
        //Tip: id x -> NSString * text
        NSLog(@"当前字符串:%@",x);
    }] ;
    
    
    UITextField *textField1 = [UITextField new];
    textField1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:textField1];
    [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(textField.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
    [[textField1.rac_textSignal map:^id(NSString *text) {
        return @(text.length);
    }] subscribeNext:^(id x) {
        NSLog(@"当前字符串长度%@",x);
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
