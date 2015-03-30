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
    self.backgroundColor = [UIColor blackColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self awaker];
}

- (void)setData:(WeaponType)weaponType {
    switch (weaponType) {
        case WeaponTypeFlood: {
            self.weaponImageView.image = [UIImage imageNamed:imageName_floodJacket];
            break;
        }
        case WeaponTypeFreeze: {
            self.weaponImageView.image = [UIImage imageNamed:imageName_freezeJacket];
            break;
        }
        case WeaponTypeFlare: {
            self.weaponImageView.image = [UIImage imageNamed:imageName_flareJacket];
            break;
        }
        case WeaponTypeHoly: {
            self.weaponImageView.image = [UIImage imageNamed:imageName_holyJacket];
            break;
        }case WeaponTypeUltima: {
            self.weaponImageView.image = [UIImage imageNamed:imageName_ultimaJacket];
            break;
        }
    }
}

@end
