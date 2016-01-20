//
//  HomeTableViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "HomeTableViewController.h"

@interface HomeTableViewController ()
{
    NSArray *_titles;
    NSArray *_tableTitles;
}
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalCell"];
    
    self.tableView.tableFooterView = [UIView new];
    _titles = @[@"TextFieldSignalViewController",@"ButtonTargetActionViewController",@"GestureViewController",@"NotificationViewController",@"TimerViewController",@"DelegateViewController"];
    _tableTitles = @[@"监听文本框",@"监听事件",@"手势事件",@"通知事件",@"计时器",@"代理事件"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
    cell.textLabel.text = _tableTitles[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Class class = NSClassFromString(_titles[indexPath.row]);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _tableTitles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

@end
