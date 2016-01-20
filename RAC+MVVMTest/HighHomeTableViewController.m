//
//  HighHomeTableViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "HighHomeTableViewController.h"

@interface HighHomeTableViewController ()
{
    NSArray *_titles;
    NSArray *_tableTitles;
}
@end

@implementation HighHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalCell"];
    
    self.tableView.tableFooterView = [UIView new];
    _titles = @[@"InstantSearchViewController",@"LoginViewController"];
    _tableTitles = @[@"即时搜索",@"MVVM+RAC"];
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
