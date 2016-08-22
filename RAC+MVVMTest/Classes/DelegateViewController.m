//
//  DelegateViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//  局限性：返回是void

#import "DelegateViewController.h"

@interface DelegateViewController ()

@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"是否确认登录?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple * tuple) {
//        NSLog(@"%@",tuple.first);
//        NSLog(@"%@",tuple.second);
//        NSLog(@"%@",tuple.third);
//    }];
    [alertView show];
    
    
//    //	更简单的方式：
    [[alertView rac_buttonClickedSignal]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    // Do any additional setup after loading the view.
    
    
    //KVO
    
//    UIScrollView * scrollView = [[UIScrollView alloc]init];
//    scrollView.delegate = (id<UIScrollViewDelegate>)self;
//    [self.view addSubview:scrollView];
//    
//    UIView * scrollViewContentView = [[UIView alloc]init];
//    scrollViewContentView.backgroundColor = [UIColor yellowColor];
//    [scrollView addSubview:scrollViewContentView];
//    
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(80, 80, 80, 80));
//    }];
//    
//    [scrollViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scrollView);
//        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)));
//    }];
//    
//    [RACObserve(scrollView, contentOffset) subscribeNext:^(id x) {
//        NSLog(@"contentOffset:%@",x);
//    }];
    
    
// 核心类 signal
    
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//       
//        //request
//        
////        [subscriber sendNext:@"response"];
////        
////        [subscriber sendCompleted];
//        
//        
//        [subscriber sendError:[NSError errorWithDomain:@"domain" code:214 userInfo:nil]];
//        
//        return nil;
//    }];
//    
//    [signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    } error:^(NSError *error) {
//        NSLog(@"%@",error);
//    } completed:^{
//        
//    }];
    
    
    
//    RACSignal *signal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil];
//    
//   RACDisposable *disposable = [signal subscribeNext:^(id x) {
//       NSLog(@"%@",x);
//    }];
//    
//    [disposable dispose];
    
    
//// 组合
//
//    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        [subscriber sendNext:@1];
//        
//        [subscriber sendCompleted];
//        
//        return nil;
//    }];
//    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        [subscriber sendNext:@2];
//        
//        return nil;
//    }];
//    
//    // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
//    RACSignal *concatSignal = [signalA concat:signalB];
//    
//    // 以后只需要面对拼接信号开发。
//    // 订阅拼接的信号，不需要单独订阅signalA，signalB
//    // 内部会自动订阅。
//    // 注意：第一个信号必须发送完成，第二个信号才会被激活
//    [concatSignal subscribeNext:^(id x) {
//        
//        NSLog(@"%@",x);
//        
//    }];
    
    
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
