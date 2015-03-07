//
//  WeaponCollectionView.h
//  DragonRequest
//
//  Created by dieSonne on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeaponCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *weaponAnimations;
@property (nonatomic, weak) IBOutlet UIImageView *weaponAnimationImageView;
@property (nonatomic, strong) NSMutableArray *stock;

@end
