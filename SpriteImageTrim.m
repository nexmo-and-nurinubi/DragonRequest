//
//  SpriteImageTrim.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/12/20.
//  Copyright (c) 2014年 y.shibata. All rights reserved.
//

#import "SpriteImageTrim.h"

@implementation SpriteImageTrim


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
    
    UIImage *frontImage1  = [self createImageArrayWithPosX:0 posY:0];
    UIImage *frontImage2  = [self createImageArrayWithPosX:_width posY:0];
    UIImage *frontImage3  = [self createImageArrayWithPosX:_width*2 posY:0];
    _frontArray = @[frontImage1,frontImage2,frontImage3];
    
    UIImage *leftImage1  = [self createImageArrayWithPosX:0 posY:_height];
    UIImage *leftImage2  = [self createImageArrayWithPosX:_width posY:_height];
    UIImage *leftImage3  = [self createImageArrayWithPosX:_width*2 posY:_height];
    _leftArray = @[leftImage1,leftImage2,leftImage3];
    
    UIImage *rightImage1  = [self createImageArrayWithPosX:0 posY:_height*2];
    UIImage *rightImage2  = [self createImageArrayWithPosX:_width posY:_height*2];
    UIImage *rightImage3  = [self createImageArrayWithPosX:_width*2 posY:_height*2];
    _rightArray = @[rightImage1,rightImage2,rightImage3];
    
    UIImage *backImage1 = [self createImageArrayWithPosX:0 posY:_height*3];
    UIImage *backImage2 = [self createImageArrayWithPosX:_width posY:_height*3];
    UIImage *backImage3 = [self createImageArrayWithPosX:_width*2 posY:_height*3];
    _backArray = @[backImage1,backImage2,backImage3];
}


- (UIImage *)createImageArrayWithPosX:(int)posX posY:(int)posY {
    
    CGRect trimArea = CGRectMake(posX, posY, _width, _height);
    CGImageRef imageRef = [_image CGImage];
    CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
    UIImage *trimeImage = [UIImage imageWithCGImage:trimeImageRef];
    
    return trimeImage;
}


@end
