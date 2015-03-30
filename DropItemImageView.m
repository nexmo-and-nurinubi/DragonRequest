//
//  DropItemImageView.m
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "DropItemImageView.h"
#import "DropItemController.h"

@implementation DropItemImageView

#define smallFrame CGRectMake(0.0, 0.0, DropItemImageSmallSize, DropItemImageSmallSize)
#define bigFrame CGRectMake(0.0, 0.0, DropItemImageBigSize, DropItemImageBigSize)

- (instancetype)initWithPoint:(CGPoint)center human:(Human *)enemy dropItemType:(DropItemType)type {
    self = [super init];
    if (self) {
        HumanType humanType = enemy.myHumanType;
        self.dropItemType = type;
        switch (type) {
            case DropItemTypeNone:
                DLog(@"Error: DropItemType is DropItemTypeNone.");
                break;
            case DropItemTypeStatusUp:
                self.statusUpType = [DropItemController randStatusUpType];
                switch (self.statusUpType) {
                    case StatusUpTypePowerUp: {
                        switch (humanType) {
                            case HumanTypeHuman: {
                                DLog(@"Error: HumanType is HumanTypeHuman.");
                                break;
                            }
                            case HumanTypeHero: {
                                DLog(@"Error: HumanType is HumanTypeHero.");
                                break;
                            }
                            case HumanTypeEnemy: {
                                self.frame = smallFrame;
                                self.powerHealingValue = powerHealingValueByMarine;
                                self.powerUpValue = powerUpValueByMarine;
                                break;
                            }
                            case HumanTypeBoss: {
                                self.frame = bigFrame;
                                self.powerHealingValue = powerHealingValueByBoss;
                                self.powerUpValue = powerUpValueByBoss;
                                break;
                            }
                        }
                        self.image = [UIImage imageNamed:imageName_heartPinkJacket];
                        break;
                    }
                }
                break;
            case DropItemTypeMagic:
                // ToDo
                self.magicType = MagicTypeFire;
                break;
            case DropItemTypeWeapon:
                // ToDo
                self.weaponType = WeaponTypeFlood;
                break;
        }
        self.center = center;
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
