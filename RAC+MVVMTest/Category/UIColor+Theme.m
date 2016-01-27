//
//  UIColor+Theme.m
//  RAC+MVVMTest
//
//  Created by ZpyZp on 16/1/27.
//  Copyright © 2016年 zpy. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)customBlueColor
{
    return [self colorWithRed:52 green:152 blue:219];
}

#pragma mark - Private class methods

+ (UIColor *)colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue
{
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:1.f];
}
@end
