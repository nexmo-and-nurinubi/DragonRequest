//
//  ViewController.h
//  DragonRequest
//
//  Created by Apple on 2014/12/06.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EnemyBoss.h"
#import "EnemyMarine.h"
#import "MyHero.h"
#import "WeaponCollectionView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *fieldView;
@property (weak, nonatomic) IBOutlet WeaponCollectionView *weaponCollectionView;

@property (nonatomic) int xPos;
@property (nonatomic) int yPos;

@end

