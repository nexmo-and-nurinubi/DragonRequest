//
//  DropItemController.h
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DropItemController : NSObject

+ (DropItemType)randDropItemType;
+ (BOOL)isCreateDropItem:(DropItemType)type;


@end
