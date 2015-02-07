//
//  EnemyMarine.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyMarine.h"

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


-(void)setImage:(UIView *)parentView
{
    NSLog(@"EnemyMarine Image");
    
    UIImage *img = [UIImage imageNamed:@"front1.png"];
    
    if(_animationImage == nil){
        _animationImage = [[UIImageView alloc]initWithImage:img];
        _animationImage.tag = HumanTypeEnemy;
        _animationImage.userInteractionEnabled = YES;
    }
    
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    [parentView addSubview:_animationImage];
    
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
    
    _animationImage.animationImages = ImsArray;
    _animationImage.animationDuration = 0.5;
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       marineImageSizeWidth,marineImageSizeHeight);

}


    
@end
