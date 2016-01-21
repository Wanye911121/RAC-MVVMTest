//
//  ListTableViewController.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/20.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListViewModel.h"
#import "Book.h"

@interface ListTableViewController ()

@property (nonatomic,strong) ListViewModel *listModel;
@end

@implementation ListTableViewController


-(ListViewModel *)listModel
{
    if (!_listModel) {
        _listModel = [[ListViewModel alloc] init];
    }
    return _listModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.dataSource = self.listModel;
    
    // 执行请求
    RACSignal *requesSiganl = [self.listModel.listRequestCommand execute:nil];
    // 获取请求的数据
    [requesSiganl subscribeNext:^(NSArray *x) {
        
        self.listModel.models = x;
        
        [self.tableView reloadData];
        
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModel.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Book *book = self.listModel.models[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
