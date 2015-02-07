//
//  Human.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "Human.h"

@implementation Human{
    
}

- (id)init {
    
    self = [super init];
    
    return self;
}

- (id)init :(CGPoint)initPos{

    self = [super init];
    
    if (self) {
        
        self.position = CGPointMake(initPos.x, initPos.y);
        
        self.name = @"human";
        self.power = 0;
        
        _stepX = humanStepX;
        _stepY = humanStepY;
        
        _screenSizeX = screenSizeX;
        _screenSizeY = screenSizeY;
        
        _imageWidth = humanImageSizeWidth;
        _imageHeight = humanImageSizeHeight;
        
        _animationImage = nil;
        
        srand((unsigned)time(NULL));
    }
    
    return self;
   
}

- (NSString *)whoAreYou {
    
    NSString *str = [NSString stringWithFormat:@"%@[ p:%zd : %zd ]",
                     self.name, self.power, _myHumanType];
    
    return str;
    
}

- (NSString *)whereAreYou{
    
    NSString *str = [NSString stringWithFormat:@" %@ [ %.0f : %.0f ]",self.name,self.position.x,self.position.y];
    
    return str;
}

- (BOOL)fight:(Human *)target {
    
    //human super class
    target.power -= self.minusPower;
    if (target.power <= 0) {
        return YES;
    }
    
    return NO;
}

- (NSString *)sayToWin:(NSInteger)power {
    
    NSString *str = [NSString stringWithFormat:@"%@勝利! [ %ld ]",self.name,(long)power];
    
    return str;
    
}

- (NSString *)sayToDefeat:(NSInteger)power {
    
    NSString *str = [NSString stringWithFormat:@"%@敗北... [ %ld ]",self.name,(long)power];
    
    return str;
    
}
-(void)setImage:(UIView *)parentView
{
    
}

-(void)setAnimation:(DirectionType)direction
{
    
}

- (void)removeImage
{
    [_animationImage removeFromSuperview];
}

-(void)moveRand
{
    if (_moveRestCount == 0) {
        _direction = (DirectionType)arc4random() % 4;
        _moveRestCount = arc4random() % maxMoveCount + 1;
    }
    _moveRestCount--;
    
    [self move:_direction];
    
}
-(void)stopToWalk
{
    [_animationImage stopAnimating];
   
}

-(void)move:(DirectionType) direction
{
    
    CGPoint position = self.position;
    
    switch (direction) {
            
        case DirectionTypeFromLeftToRight:
            //右
            position.x+=_stepX;
            
            break;
            
        case DirectionTypeFromRightToLeft:
            //左
            position.x-=_stepX;
            
            break;
            
        case DirectionTypeFromBottomToTop:
            //上
            position.y-=_stepY;
            break;
            
        case DirectionTypeFromTopToBottom:
            //下
            position.y+=_stepY;
            break;
            
        default:
            break;
    }
    
    position.x = MIN(MAX(0,position.x),_screenSizeX-_imageWidth);   //限界地点判別
    position.y = MIN(MAX(0,position.y),_screenSizeY-_imageHeight);  //限界地点判別
    
    self.position = position;
    
    [self setAnimation:direction];
    
    [_animationImage startAnimating];
    
}


@end
