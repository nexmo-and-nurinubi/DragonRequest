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

-(void)setImage:(UIView *)parentView belowSubview:(UIView *)siblingSubview
{
    //イメージ設定
    [super setImage:parentView belowSubview:siblingSubview];
    
    //ワーキングアニメーションイメージ設定
    [self setMoveAnimImage:@"shadow01.png"
                     countX:3
                     countY:4];
    
    //戦闘シーンアニメーションイメージ設定
    [super setFightAnimImage];
    
    //表示イメージ
    UIImage *img = _frontSceanAnimArray[0];
    
    if(self.animationImageView == nil){
        self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight)];
        self.animationImageView.image = img;
        self.animationImageView.tag = HumanTypeEnemy;
        self.animationImageView.userInteractionEnabled = YES;
    }
    
    [parentView insertSubview:self.animationImageView belowSubview:siblingSubview];
    
    self.animationImageView.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    
    
}

-(void)setMoveAnimImage:(NSString *)originalImageName
                 countX:(int)countX
                 countY:(int)countY
{
    @try{
        
        [super setMoveAnimImage:originalImageName
                         countX:countX countY:countY];
        
        _frontSceanAnimArray = [_walkingSceanAnimArray objectAtIndex:0];
        _backSceanAnimArray  = [_walkingSceanAnimArray objectAtIndex:1];
        _leftSceanAnimArray  = [_walkingSceanAnimArray objectAtIndex:2];
        _rightSceanAnimArray = [_walkingSceanAnimArray objectAtIndex:3];
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
}

@end
