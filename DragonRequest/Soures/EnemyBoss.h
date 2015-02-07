//
//  EnemyBoss.h
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//
//-----------------------------------------------------------
// EnemyBoss
//-----------------------------------------------------------

#import "Human.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "heroSpriteImageTrim.h"
#import "BossSpriteImage.h"

@interface EnemyBoss : Human
@property (nonatomic) UIImage *orgImage;

@property (nonatomic) int width;
@property (nonatomic) int height;


@property (nonatomic) NSArray *frontArray;
@property (nonatomic) NSArray *backArray;
@property (nonatomic) NSArray *leftArray;
@property (nonatomic) NSArray *rightArray;
//- (id)initWithImageName:(NSString *)imageName
//         charactarWidth:(int)charactarWidth
//        charactarHeight:(int)charactarHeiht;

@end
