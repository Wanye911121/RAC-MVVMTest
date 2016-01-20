//
//  InstantSearchViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "InstantSearchViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface InstantSearchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_searchArray;
}
@end

@implementation InstantSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *searchBar = [UITextField new];
    searchBar.placeholder = @"点击搜索";
    searchBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width,44));
        make.top.mas_equalTo(self.view).offset(64);
        make.left.mas_equalTo(self.view);
    }];
    
    UITableView *listTableView = [UITableView new];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    [listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(searchBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    [listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normal"];
    
    //throttle截流，在0.3秒之内，只允许通过一次信号
    //switchToLatest用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。
    [[[[[[searchBar.rac_textSignal throttle:0.3] distinctUntilChanged]ignore:@""] map:^id(id value) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSLog(@"请求：%@",value);
            //  network request
            [subscriber sendNext:value];
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
                //  cancel request
            }];
        }];
    }]switchToLatest] subscribeNext:^(id x) {
        
    }];
    
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
    cell.textLabel.text = _searchArray[indexPath.row];
    return cell;
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
