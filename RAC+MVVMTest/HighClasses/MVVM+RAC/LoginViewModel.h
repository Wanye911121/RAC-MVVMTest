//
//  LoginViewModel.h
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewModel : NSObject

@property (nonatomic,strong) Account *account;

// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *LoginCommand;
@end
