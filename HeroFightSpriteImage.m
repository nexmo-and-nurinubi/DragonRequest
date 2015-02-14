//
//  HeroFightSpriteImage.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/12/20.
//  Copyright (c) 2014年 y.shibata. All rights reserved.
//

#import "HeroFightSpriteImage.h"

@implementation HeroFightSpriteImage


- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht {
    
    if (self = [super init]) {
        
        _image = [UIImage imageNamed:imageName];
        _width = charactarWidth;
        _height = charactarHeiht;
        
        [self initArray];
    }
    
    return self;
}


- (void)initArray {
    UIImage *image01 = [self createImageArrayWithPosX:_width*0 posY:_height*0];
    UIImage *image02 = [self createImageArrayWithPosX:_width*1 posY:_height*0];
    UIImage *image03 = [self createImageArrayWithPosX:_width*2 posY:_height*0];
    UIImage *image04 = [self createImageArrayWithPosX:_width*3 posY:_height*0];
    UIImage *image05 = [self createImageArrayWithPosX:_width*4 posY:_height*0];
    UIImage *image06 = [self createImageArrayWithPosX:_width*5 posY:_height*0];
    UIImage *image07 = [self createImageArrayWithPosX:_width*6 posY:_height*0];
    UIImage *image08 = [self createImageArrayWithPosX:_width*7 posY:_height*0];
    _spriteArray = @[image01, image02, image03, image04, image05, image06, image07, image08];
}


- (UIImage *)createImageArrayWithPosX:(int)posX posY:(int)posY {
    
    CGRect trimArea = CGRectMake(posX, posY, _width, _height);
    CGImageRef imageRef = [_image CGImage];
    CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
    UIImage *trimeImage = [UIImage imageWithCGImage:trimeImageRef];
    
    return trimeImage;
}


@end
