//
//  EnemyBoss.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyBoss.h"
#import "FireSpriteImage.h"

@implementation EnemyBoss

- (id)init :(CGPoint)initPos {
    
    self = [super init:initPos];
    
    if (self) {
        
        _myHumanType = HumanTypeBoss;
        
        self.name = bossDefaultName;
        
        self.power = bossDefaultPower;
        self.minusPower = bossMinusPower;
        
        _stepX = bossStepX;
        _stepY = bossStepY;
        
        _reach = bossReach;
        
        _imageWidth = bossImageSizeWidth;
        _imageHeight = bossImageSizeHeight;
        
    }
    return self;
}

- (BOOL)fight:(Human *)target {
    
    //human super class
    if (ABS(self.animationImage.center.x - target.animationImage.center.x) <= _reach && ABS(self.animationImage.center.y - target.animationImage.center.y) <= _reach) {
        // バトルアニメーション
        FireSpriteImage *spriteImage = [[FireSpriteImage alloc] initWithImageName:@"pipo-btleffect024.png" charactarWidth:240 charactarHeight:240];
        self.fightAnimationImage.frame = CGRectMake(0, 0, 64, 64);
        self.fightAnimationImage.center = target.animationImage.center;
        self.fightAnimationImage.animationImages = spriteImage.spriteArray;
        self.fightAnimationImage.animationDuration = 1.0;
        self.fightAnimationImage.animationRepeatCount = 1.0;
        [self.fightAnimationImage startAnimating];
        
        // 体力を減らす
        target.power -= self.minusPower;
        if (target.power <= 0) {
            return YES;
        }
    }
    
    return NO;
}

-(void)setImage:(UIView *)parentView
{
    NSLog(@"EnemyBoss Image");
    
    UIImage *img = [UIImage imageNamed:@"dragon3.png"];
    
    if(self.animationImage == nil){
        self.animationImage = [[UIImageView alloc]initWithImage:img];
        self.animationImage.tag = HumanTypeBoss;
        self.animationImage.userInteractionEnabled = YES;
    }
    
    self.animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    [parentView addSubview:self.animationImage];
    
    self.fightAnimationImage = [[UIImageView alloc] init];
    
    [parentView addSubview:self.fightAnimationImage];
}



/** 画像から切り取り */
- (UIImage *)createImageArrayWithPosX:(int)posX
                                 posY:(int)posY
{
    CGRect trimArea = CGRectMake(posX, posY, _imageWidth, _imageHeight);
    CGImageRef imageRef = [_orgImage CGImage];
    CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
    UIImage *trimeImage = [UIImage imageWithCGImage:trimeImageRef];
    
    return trimeImage;
}



/** 向きと座標を変更する */
- (void)setAnimation:(DirectionType)direction
{
    NSArray *imsArray = nil;
    
    _width = 48;
    _height = 48;
    
    BossSpriteImage *bossSpriteImage = [[BossSpriteImage alloc] initWithImageName:@"dragon1.png"
                                                                   charactarWidth:73
                                                                  charactarHeight:58];
    
    if (direction == DirectionTypeFromRightToLeft) {
        imsArray = bossSpriteImage.rightArray;
    }
    if (direction == DirectionTypeFromLeftToRight) {
        imsArray= bossSpriteImage.leftArray;
    }
    if (direction == DirectionTypeFromBottomToTop) {
        imsArray = bossSpriteImage.backArray;
    }
    if (direction == DirectionTypeFromTopToBottom) {
        imsArray = bossSpriteImage.frontArray;
    }
    
    self.animationImage.animationImages = imsArray;
    self.animationImage.animationDuration = 0.5;
    self.animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       bossImageSizeWidth,bossImageSizeHeight);
    
    
    // 透明度を設定
    self.animationImage.alpha = alphaFloat;
    
    
    [self.animationImage startAnimating];
}


@end
