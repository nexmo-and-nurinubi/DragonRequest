//
//  DropItemController.m
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "DropItemController.h"

@implementation DropItemController

+ (DropItemType)randDropItemType {
    // ToDo
    // NSInteger i = arc4random() % 100;
    return DropItemTypeStatusUp;
}

+ (BOOL)isCreateDropItem:(DropItemType)type {
    switch (type) {
        case DropItemTypeNone:
            return NO;
        case DropItemTypeStatusUp:
        case DropItemTypeMagic:
        case DropItemTypeWeapon:
            return YES;
    }
}

@end
