//
//  TimerViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "TimerViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface TimerViewController ()

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *timeLabel = [UILabel new];
    [self.view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.center.mas_equalTo(self.view);
    }];
    
    NSLog(@"begin");
    //    1. 延迟某个时间后再做某件事
    [[RACScheduler mainThreadScheduler]afterDelay:2.0f schedule:^{
        
        NSLog(@"2秒之后发生的事情");
        
    }];
    
    //    2. 每个一定长度时间做一件事
    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(NSDate * date) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        timeLabel.text = [formatter stringFromDate:date];
//        NSLog(@"%@",[formatter stringFromDate:date]);
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
