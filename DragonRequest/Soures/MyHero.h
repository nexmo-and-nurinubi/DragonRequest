//
//  MyHero.h
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//
//-----------------------------------------------------------
// MyHero
//-----------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Human.h"
#import "HeroSpriteImageTrim.h"

@interface MyHero : Human

@property (nonatomic) UIImage *orgImage;

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
