//
//  EnemyFightSpriteImage.h
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/12/20.
//  Copyright (c) 2014年 y.shibata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EnemyFightSpriteImage : NSObject


@property (nonatomic) UIImage *image;

@property (nonatomic) int width;
@property (nonatomic) int height;

//@property (nonatomic) NSString *imageName;

@property (nonatomic) NSArray *frontArray;
@property (nonatomic) NSArray *backArray;
@property (nonatomic) NSArray *leftArray;
@property (nonatomic) NSArray *rightArray;

- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht;


@end
