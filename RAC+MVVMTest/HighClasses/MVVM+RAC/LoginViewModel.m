//
//  LoginViewModel.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "LoginViewModel.h"
#import "PYProgressHUD.h"

@implementation LoginViewModel
- (Account *)account
{
    if (_account == nil) {
        _account = [[Account alloc] init];
    }
    return _account;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

// 初始化绑定
- (void)initialBind
{
    // 监听账号的属性值改变，把他们聚合成一个信号。如果账号和密码都不为空，则为YES
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account),RACObserve(self.account, pwd)] reduce:^id(NSString *account,NSString *pwd){
        
        return @(account.length && pwd.length);
        
    }];
    
    // 处理登录业务逻辑
    _LoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        NSLog(@"点击了登录");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"登录成功"];
                
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    // 监听登录状态，跳过第一个信号
    [[_LoginCommand.executing skip:1] subscribeNext:^(id x) {
        
        if ([x isEqualToNumber:@(YES)]) {
            
            // 正在登录ing...
            // 用蒙版提示
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            
        }else
        {
            
            // 登录成功
            // 隐藏蒙版
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
//            NSLog( @"登录成功,隐藏蒙板");
        }
    }];
}
@end
