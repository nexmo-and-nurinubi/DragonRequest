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

- (instancetype)initWithPoint:(CGPoint)center human:(Human *)enemy dropItemType:(DropItemType)type {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, DropItemImageSize, DropItemImageSize)];
    if (self) {
        self.center = center;
        self.userInteractionEnabled = YES;
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
                        self.image = [UIImage imageNamed:imageName_heartPinkJacket];
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
                                self.powerHealingValue = powerHealingValueByMarine;
                                self.powerUpValue = powerUpValueByMarine;
                                break;
                            }
                            case HumanTypeBoss: {
                                self.powerHealingValue = powerHealingValueByBoss;
                                self.powerUpValue = powerUpValueByBoss;
                                break;
                            }
                        }
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
    }
    return self;
}

@end
