//
//  WeaponCollectionView.m
//  DragonRequest
//
//  Created by dieSonne on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "WeaponCollectionView.h"
#import "WeaponCollectionReusableHeaderView.h"
#import "WeaponCollectionReusableFooterView.h"
#import "WeaponCollectionViewCell.h"

static NSString * const weaponReusableHeaderViewReuseIdentifier = @"WeaponReusableHeaderView";
static NSString * const weaponReusableFooterViewReuseIdentifier = @"WeaponReusableFooterView";
static NSString * const weaponCellReuseIdentifier = @"WeaponCell";

@implementation WeaponCollectionView

- (void)awaker {
    self.delegate = self;
    self.dataSource = self;
    
    // weaponAnimations
    NSArray *weapon;
    self.weaponAnimations = [NSMutableArray array];
    weapon = [[DrUtil sharedInstance] animArray:[UIImage imageNamed:imageName_flood] countX:2 countY:5 charactarWidth:320 charactarHeight:240 imageScale:YES];
    [self.weaponAnimations addObject:weapon];
    weapon = [[DrUtil sharedInstance] animArray:[UIImage imageNamed:imageName_freeze] countX:2 countY:7 charactarWidth:320 charactarHeight:240 imageScale:YES];
    [self.weaponAnimations addObject:weapon];
    weapon = [[DrUtil sharedInstance] animArray:[UIImage imageNamed:imageName_flare] countX:2 countY:7 charactarWidth:320 charactarHeight:240 imageScale:YES];
    [self.weaponAnimations addObject:weapon];
    weapon = [[DrUtil sharedInstance] animArray:[UIImage imageNamed:imageName_holy] countX:2 countY:7 charactarWidth:320 charactarHeight:240 imageScale:YES];
    [self.weaponAnimations addObject:weapon];
    weapon = [[DrUtil sharedInstance] animArray:[UIImage imageNamed:imageName_ultima] countX:2 countY:7 charactarWidth:320 charactarHeight:240 imageScale:YES];
    [self.weaponAnimations addObject:weapon];
    
    // weaponAnimationImageView
    self.weaponAnimationImageView.animationDuration = 1.0;
    self.weaponAnimationImageView.animationRepeatCount = 1.0;
    
    // ToDo
    self.stock = [@[@(WeaponTypeFlood), @(WeaponTypeFreeze), @(WeaponTypeFlare), @(WeaponTypeHoly), @(WeaponTypeUltima)] mutableCopy];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self awaker];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.stock count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    WeaponType weaponType = [self.stock[row] integerValue];
    
    WeaponCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weaponCellReuseIdentifier forIndexPath:indexPath];
    [cell setData:weaponType];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    WeaponType weaponType = [self.stock[row] integerValue];
    
    self.weaponAnimationImageView.animationImages = self.weaponAnimations[weaponType];
    [self.weaponAnimationImageView startAnimating];
}

@end
