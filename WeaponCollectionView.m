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
    // ToDo
    return 17;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weaponCellReuseIdentifier forIndexPath:indexPath];
    
    // ToDo
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // ToDo
}


@end
