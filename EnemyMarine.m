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
        
        _imageCutSizeWidth = marineImageCutSizeWidth;
        _imageCutSizeHeight= marineImageCutSizeHeight;
        
        _countComma = marineCountAnimComma;
        
        _defaultPower = marineDefaultPower;
        
    }
    return self;
}

-(void)setImage:(UIView *)parentView
{
    //イメージ設定
    [super setImage:parentView];
    
    //アニメーションイメージ設定
    [self setMoveAnimImage:@"dragon1.png"
                     countX:3
                     countY:3];
    
    
    //初期化
    
    //表示イメージ
    UIImage *img = [UIImage imageNamed:@"dragon3.png"];
    
    if(_animationImageView == nil){
        _animationImageView = [[UIImageView alloc]initWithImage:img];
        _animationImageView.tag = HumanTypeHero;
        _animationImageView.userInteractionEnabled = YES;
    }
    
    [parentView addSubview:_animationImageView];
    
    _animationImageView.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    
    
}

-(void)setMoveAnimImage:(NSString *)originalImageName
                 countX:(int)countX
                 countY:(int)countY
{
    @try{
        
        [super setMoveAnimImage:originalImageName
                         countX:countX countY:countY];
        
        _frontSceanAnimArray = [_multiSceanAnimArray objectAtIndex:0];
        _backSceanAnimArray  = [_multiSceanAnimArray objectAtIndex:1];
        _leftSceanAnimArray  = [_multiSceanAnimArray objectAtIndex:2];
        _rightSceanAnimArray = [_multiSceanAnimArray objectAtIndex:3];
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
}

@end
