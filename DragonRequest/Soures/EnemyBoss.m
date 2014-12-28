//
//  EnemyBoss.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyBoss.h"

@implementation EnemyBoss

- (id)init :(CGPoint)initPos{

    self = [super init:initPos];
    
    if (self) {
        
        _myHumanType = HumanTypeBoss;
        
        self.name = bossDefaultName;
        
        self.power = bossDefaultPower;
        self.minusPower = bossMinusPower;
        
        _stepX = bossStepX;
        _stepY = bossStepY;
        
        _imageWidth = bossImageSizeWidth;
        _imageHeight = bossImageSizeHeight;
        
    }
    return self;
}

-(void)setImage:(UIView *)parentView
{
    NSLog(@"EnemyBoss Image");
    
    UIImage *img = [UIImage imageNamed:@"front01.png"];
    
    if(_animationImage == nil)
        _animationImage = [[UIImageView alloc]initWithImage:img];
    
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    [parentView addSubview:_animationImage];
    
}
-(void)setAnimation:(DirectionType)direction
{
    NSArray *ImsArray = nil;
    
    
    if (direction == DirectionTypeFromRightToLeft) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"dragon_orange_rl01@2x.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"dragon_orange_rl02@2x.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"dragon_orange_rl03@2x.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromLeftToRight) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"dragon_orange_lr01@2x.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"dragon_orange_lr02@2x.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"dragon_orange_lr03@2x.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
        
    }
    if (direction == DirectionTypeFromBottomToTop) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"dragon_orange_bt01@2x.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"dragon_orange_bt02@2x.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"dragon_orange_bt03@2x.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromTopToBottom) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"dragon_orange_tb01@2x.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"dragon_orange_tb02@2x.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"dragon_orange_tb03@2x.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    
    _animationImage.animationImages = ImsArray;
    _animationImage.animationDuration = 0.5;
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       bossImageSizeWidth,bossImageSizeHeight);
    
}

@end
