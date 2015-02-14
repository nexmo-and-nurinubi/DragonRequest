//
//  EnemyMarine.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyMarine.h"
#import "FireSpriteImage.h"

@implementation EnemyMarine

- (id)init :(CGPoint)initPos{
    
    self = [super init:initPos];
    
    if (self) {
        
        _myHumanType = HumanTypeEnemy;
        
        self.name = marineDefaultName;
        
        self.power = marineDefaultPower;
        self.minusPower = marineMinusPower;
        
        _stepX = marineStepX;
        _stepY = marineStepY;
        
        _reach = marineReach;
        
        _imageWidth = marineImageSizeWidth;
        _imageHeight = marineImageSizeHeight;
        
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
    NSLog(@"EnemyMarine Image");
    
    UIImage *img = [UIImage imageNamed:@"front1.png"];
    
    if(self.animationImage == nil){
        self.animationImage = [[UIImageView alloc]initWithImage:img];
        self.animationImage.tag = HumanTypeEnemy;
        self.animationImage.userInteractionEnabled = YES;
    }
    
    self.animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    [parentView addSubview:self.animationImage];
    
    self.fightAnimationImage = [[UIImageView alloc] init];
    
    [parentView addSubview:self.fightAnimationImage];
    
}
-(void)setAnimation:(DirectionType)direction
{
    NSArray *ImsArray = nil;
    
    
    if (direction == DirectionTypeFromRightToLeft) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"left1.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"left2.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"left3.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromLeftToRight) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"right1.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"right2.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"right3.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];

    }
    if (direction == DirectionTypeFromBottomToTop) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"back1.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"back2.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"back3.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromTopToBottom) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"front1.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"front2.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"front3.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    
    self.animationImage.animationImages = ImsArray;
    self.animationImage.animationDuration = 0.5;
    self.animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       marineImageSizeWidth,marineImageSizeHeight);

}


    
@end
