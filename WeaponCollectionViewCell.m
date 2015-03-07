//
//  WeaponCollectionViewCell.m
//  DragonRequest
//
//  Created by dieSonne on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "WeaponCollectionViewCell.h"

@implementation WeaponCollectionViewCell

- (void)awaker {
    // ToDo
    self.backgroundColor = [UIColor whiteColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self awaker];
}

@end
