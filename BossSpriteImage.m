//
//  BossSpriteImage.m
//  DragonRequest
//
//  Created by 長沢　遼 on 2015/01/17.
//  Copyright (c) 2015年 Apple. All rights reserved.
//


#import "BossSpriteImage.h"
@implementation  BossSpriteImage
//{
//    float alphaFloat;
//}


- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht
{
    
    if (self = [super init]) {
        
        _image = [UIImage imageNamed:imageName];
        _width = charactarWidth;
        _height = charactarHeiht;
        
        
//        alphaFloat = alpha;
//        alphaFloat = alpha;
        
        
        [self initArray];
    }
    
    return self;
}


- (void)initArray {
    
    // ドラゴン
    UIImage *frontImage1  = [self createImageArrayWithPosX:_width*0 posY:_height*0];
    UIImage *frontImage2  = [self createImageArrayWithPosX:_width*1 posY:_height*0];
    UIImage *frontImage3  = [self createImageArrayWithPosX:_width*2 posY:_height*0];
    // 棒人間
//    UIImage *frontImage1  = [UIImage imageNamed:@"BossNomal1.png"];
//    UIImage *frontImage2  = [UIImage imageNamed:@"BossNomal2.png"];
//    UIImage *frontImage3  = [UIImage imageNamed:@"BossNomal3.png"];
    _frontArray = @[frontImage1, frontImage2, frontImage3];
    
    UIImage *leftImage1  = [self createImageArrayWithPosX:_width*0 posY:_height*1];
    UIImage *leftImage2  = [self createImageArrayWithPosX:_width*1 posY:_height*1];
    UIImage *leftImage3  = [self createImageArrayWithPosX:_width*2 posY:_height*1];
//    UIImage *leftImage1  = [UIImage imageNamed:@"BossNomal1.png"];
//    UIImage *leftImage2  = [UIImage imageNamed:@"BossNomal2.png"];
//    UIImage *leftImage3  = [UIImage imageNamed:@"BossNomal3.png"];
    _leftArray = @[leftImage1, leftImage2, leftImage3];
    
    UIImage *backImage1  = [self createImageArrayWithPosX:_width*0 posY:_height*3];
    UIImage *backImage2  = [self createImageArrayWithPosX:_width*1 posY:_height*3];
    UIImage *backImage3  = [self createImageArrayWithPosX:_width*2 posY:_height*3];
//    UIImage *backImage1  = [UIImage imageNamed:@"BossNomal1.png"];
//    UIImage *backImage2  = [UIImage imageNamed:@"BossNomal2.png"];
//    UIImage *backImage3  = [UIImage imageNamed:@"BossNomal3.png"];
    _backArray = @[backImage1, backImage2, backImage3];
    
    UIImage *rightImage1 = [self createImageArrayWithPosX:_width*0 posY:_height*2];
    UIImage *rightImage2 = [self createImageArrayWithPosX:_width*1 posY:_height*2];
    UIImage *rightImage3 = [self createImageArrayWithPosX:_width*2 posY:_height*2];
//    UIImage *rightImage1 = [UIImage imageNamed:@"BossNomal1.png"];
//    UIImage *rightImage2 = [UIImage imageNamed:@"BossNomal2.png"];
//    UIImage *rightImage3 = [UIImage imageNamed:@"BossNomal3.png"];
    _rightArray = @[rightImage1, rightImage2, rightImage3];
}


- (UIImage *)createImageArrayWithPosX:(int)posX posY:(int)posY {
    
    CGRect trimArea = CGRectMake(posX, posY, _width, _height);
    CGImageRef imageRef = [_image CGImage];
    CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
    UIImage *trimeImage = [UIImage imageWithCGImage:trimeImageRef];
    
    return trimeImage;
}


@end
