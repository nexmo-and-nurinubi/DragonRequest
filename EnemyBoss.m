//
//  EnemyBoss.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyBoss.h"

@implementation EnemyBoss
{
    NSArray *dragonImageFileNameArray;
}

- (id)init :(CGPoint)initPos {
    
    self = [super init:initPos];
    
    if (self) {
        
        _myHumanType = HumanTypeBoss;
        
        dragonImageFileNameArray = [NSArray arrayWithObjects: bossColoreBrack,
                                                              bossColoreBlue,
                                                              bossColoreGold,
                                                              bossColoreGreen,
                                                              bossColoreRed,
                                                              bossColoreWhite,
                                                              nil];
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

-(void)setImage:(UIView *)parentView belowSubview:(UIView *)siblingSubview
{
    //イメージ設定
    [super setImage:parentView belowSubview:siblingSubview];
    
    srand((unsigned)time(nil));
    int rand = arc4random() % 6;
    
    //アニメーションイメージ設定
    [self setMoveAnimImage:dragonImageFileNameArray[rand]
                     countX:3
                     countY:4];
    
    //戦闘シーンアニメーションイメージ設定
    [super setFightAnimImage];
    
    //表示イメージ
    UIImage *img = _frontSceanAnimArray[0];
    
    if(self.animationImageView == nil){
        self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight)];
        self.animationImageView.image = img;
        self.animationImageView.tag = HumanTypeBoss;
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
        _leftSceanAnimArray  = [_walkingSceanAnimArray objectAtIndex:1];
        _rightSceanAnimArray = [_walkingSceanAnimArray objectAtIndex:2];
        _backSceanAnimArray  = [_walkingSceanAnimArray objectAtIndex:3];
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
}

@end
