//
//  DropItemImageView.m
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "DropItemImageView.h"

@implementation DropItemImageView

- (instancetype)initWithPoint:(CGPoint)center dropItemType:(DropItemType)type {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, DropItemImageSize, DropItemImageSize)];
    if (self) {
        self.center = center;
        self.userInteractionEnabled = YES;
        switch (type) {
            case DropItemTypeNone:
                DLog(@"Error: DropItemType is DropItemTypeNone.");
                self.tag = DropItemTypeNone;
                break;
            case DropItemTypeStatusUp:
                self.image = [UIImage imageNamed:imageName_heartPinkJacket];
                self.tag = DropItemTypeStatusUp;
                break;
            case DropItemTypeMagic:
                // ToDo
                self.tag = DropItemTypeMagic;
                break;
            case DropItemTypeWeapon:
                // ToDo
                self.tag = DropItemTypeWeapon;
                break;
        }
    }
    return self;
}

@end
