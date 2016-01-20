//
//  PYProgressHUD.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/19.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "PYProgressHUD.h"

@implementation PYProgressHUD

+(void)showMessage:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[self alloc] initWithView:window];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    [window addSubview:hud];
    [hud show:YES];
}

+(void)hideHud
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [self HUDForView:window];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES];
    }
}

@end
