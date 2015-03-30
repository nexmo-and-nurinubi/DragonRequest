//
//  DropItemCommon.h
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

typedef NS_ENUM(NSInteger, DropItemType) {
    DropItemTypeNone = -1,
    DropItemTypeStatusUp,
    DropItemTypeMagic,
    DropItemTypeWeapon
};

typedef NS_ENUM(NSInteger, StatusUpType) {
    StatusUpTypePowerUp = 0
};

typedef NS_ENUM(NSInteger, MagicType) {
    MagicTypeFire = 0,
    MagicTypeWater,
    MagicTypeBlizzard,
    MagicTypeWind,
    MagicTypeThunder,
    MagicTypeStone
};

typedef NS_ENUM(NSInteger, WeaponType) {
    WeaponTypeFlood = 0,
    WeaponTypeFreeze,
    WeaponTypeFlare,
    WeaponTypeHoly,
    WeaponTypeUltima
};

static NSInteger const statusUpCount = 1;
static NSInteger const magicCount = 6;
static NSInteger const weaponCount = 5;

static NSString * const imageName_heartPinkJacket = @"pipo-btleffect116h_jacket.png";

static NSString * const imageName_heartPink = @"pipo-btleffect116h.png";