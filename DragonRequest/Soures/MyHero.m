//
//  MyHero.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "MyHero.h"

@implementation MyHero

- (id)init :(CGPoint)initPos{
    
    self = [super init:initPos];
    
    if (self) {
        
        _myHumanType = HumanTypeHero;
        
        self.name = heroDefaultName;
        
        self.power = heroDefaultPower;
        self.minusPower = heroMinusPower;
        
        _stepX = heroStepX;
        _stepY = heroStepY;
        
        _imageWidth = heroImageSizeWidth;
        _imageHeight = heroImageSizeHeight;
        
    }
    return self;
}


-(void)setImage:(UIView *)parentView
{
    NSLog(@"myhero setImage");
    
    UIImage *img = [UIImage imageNamed:@"lr01.png"];
    
    if(_animationImage == nil)
        _animationImage = [[UIImageView alloc]initWithImage:img];
    
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    [parentView addSubview:_animationImage];
    
}

-(void)setAnimation:(DirectionType)direction
{
    NSArray *ImsArray = nil;
    
    
    if (direction == DirectionTypeFromRightToLeft) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"rl01.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"rl02.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"rl03.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromLeftToRight) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"lr01.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"lr02.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"lr03.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromBottomToTop) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"bt01.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"bt02.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"bt03.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }
    if (direction == DirectionTypeFromTopToBottom) {
        
        UIImage *imgLR01 = [UIImage imageNamed:@"tb01.png"];
        UIImage *imgLR02 = [UIImage imageNamed:@"tb02.png"];
        UIImage *imgLR03 = [UIImage imageNamed:@"tb03.png"];
        ImsArray = @[imgLR01, imgLR02, imgLR03 ];
    }

    _animationImage.animationImages = ImsArray;
    _animationImage.animationDuration = 0.5;
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       heroImageSizeWidth,heroImageSizeHeight);

}

@end
