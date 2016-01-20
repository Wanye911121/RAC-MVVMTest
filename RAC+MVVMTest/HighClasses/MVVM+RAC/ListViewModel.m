//
//  ListViewModel.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/20.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "ListViewModel.h"
#import "Book.h"

@implementation ListViewModel

- (instancetype)init
{
    if (self = [super init]) {
        
        [self initialBind];
    }
    return self;
}


- (void)initialBind
{
    
    _listRequestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [PYProgressHUD showMessage:@"加载列表中"];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [PYProgressHUD hideHud];
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                [subscriber sendError:error];
                [PYProgressHUD hideHud];
            }];
            
            return nil;
        }];
        
        
        
        
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            
//            return [Book mj_objectArrayWithKeyValuesArray:dictArr];
//
//            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                
                return [Book mj_objectWithKeyValues:value];
            }] array];
            
            return modelArr;
        }];
        
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Book *book = self.models[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    
    return cell;
}

@end
