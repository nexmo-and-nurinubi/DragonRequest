//
//  DropItemImageView.h
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItemImageView : UIImageView

- (instancetype)initWithPoint:(CGPoint)center human:(Human *)enemy dropItemType:(DropItemType)type;

@property (nonatomic, assign) DropItemType dropItemType;
@property (nonatomic, assign) StatusUpType statusUpType;
@property (nonatomic, assign) MagicType magicType;
@property (nonatomic, assign) WeaponType weaponType;

// StatusUpTypePowerUp's Parameter
@property (nonatomic, assign) float powerHealingValue;
@property (nonatomic, assign) float powerUpValue;

@end
