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
        
        _reach = heroReach;
        
        _imageWidth = heroImageSizeWidth;
        _imageHeight = heroImageSizeHeight;
        
        _imageCutSizeWidth = heroImageCutSizeWidth;
        _imageCutSizeHeight= heroImageCutSizeHeight;
        
        _countComma = heroCountAnimComma;
        
        _defaultPower = heroDefaultPower;
        
    }
    
    return self;
}

-(void)setImage:(UIView *)parentView
{
    //イメージ設定
    [super setImage:parentView];
    
    //アニメーションイメージ設定
    //[self setMoveAnimImage:@"hero-comma.png"
    [self setMoveAnimImage:@"hero1"
                     countX:3
                     countY:4];
    

    //初期化
    
    //表示イメージ
    UIImage *img = [UIImage imageNamed:@"hero3.png"];
    
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
