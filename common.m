//
//  common.m
//  DragonRequest
//
//  Created by dieSonne on 2015/03/14.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "common.h"

@implementation common

+ (NSInteger)screenSizeWidth {
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger width = size.width;
    return width;
}

+ (NSInteger)screenSizeHeight {
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger height = size.height;
    return height;
}

@end
