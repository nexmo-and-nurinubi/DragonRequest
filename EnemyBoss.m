//
//  EnemyBoss.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyBoss.h"

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
        
        _imageCutSizeWidth = bossImageCutSizeWidth;
        _imageCutSizeHeight= bossImageCutSizeHeight;

        _countComma = bossCountAnimComma;
        
        _defaultPower = bossDefaultPower;

        
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
                     countY:4];
    
    
    //初期化
    
    //表示イメージ
    UIImage *img = [UIImage imageNamed:@"dragon3.png"];
    
    if(_animationImageView == nil){
        _animationImageView = [[UIImageView alloc]initWithImage:img];
        _animationImageView.tag = HumanTypeBoss;
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
        _leftSceanAnimArray  = [_multiSceanAnimArray objectAtIndex:1];
        _rightSceanAnimArray = [_multiSceanAnimArray objectAtIndex:2];
        _backSceanAnimArray  = [_multiSceanAnimArray objectAtIndex:3];
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
}

@end
