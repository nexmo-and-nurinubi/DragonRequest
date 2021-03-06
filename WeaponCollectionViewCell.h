//
//  WeaponCollectionViewCell.h
//  DragonRequest
//
//  Created by dieSonne on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeaponCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *weaponImageView;

- (void)setData:(WeaponType)weaponType;

@end
