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
        
        self.power = heroDefaultPower;
        self.minusPower = heroMinusPower;
        
        _level = 0;
        
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

-(void)setImage:(UIView *)parentView belowSubview:(UIView *)siblingSubview
{
    //イメージ設定
    [super setImage:parentView belowSubview:siblingSubview];
    
    //アニメーションイメージ設定
    //[self setMoveAnimImage:@"hero-comma.png"
    [self setMoveAnimImage:@"hero1"
                     countX:3
                     countY:4];
    
    //戦闘シーンアニメーションイメージ設定
    [self setFightAnimImage];
    
    //表示イメージ
    UIImage *img = _frontSceanAnimArray[0];
    
    if(self.animationImageView == nil){
        self.animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight)];
        self.animationImageView.image = img;
        self.animationImageView.tag = HumanTypeHero;
        self.animationImageView.userInteractionEnabled = YES;
    }
    
    self.animationImageView.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    
    [parentView addSubview:self.animationImageView];

    
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

-(void)setFightAnimImage
{
    @try{
        
        if(_fightAnimArray==nil)_fightAnimArray = [NSMutableArray array];
        
        else [_fightAnimArray removeAllObjects];
        
        //fight アニメーションロード
        UIImage *fightImage = nil;
        
        NSArray *fightSceanArray = nil;
        
        //fight アニメーションロード1
        fightImage = [UIImage imageNamed:@"pipo-btleffect025.png"];
        
        fightSceanArray = [[DrUtil sharedInstance] animArray:fightImage
                                                      countX:8
                                                      countY:1
                                              charactarWidth:240
                                             charactarHeight:240];
        
        [_fightAnimArray addObject:fightSceanArray];

        //fight アニメーションロード2
        fightImage = [UIImage imageNamed:@"pipo-btleffect037.png"];
        
        fightSceanArray = [[DrUtil sharedInstance] animArray:fightImage
                                                      countX:8
                                                      countY:1
                                              charactarWidth:240
                                             charactarHeight:240];
        
        [_fightAnimArray addObject:fightSceanArray];
        
        //fight アニメーションロード3
        fightImage = [UIImage imageNamed:@"pipo-btleffect030.png"];
        
        fightSceanArray = [[DrUtil sharedInstance] animArray:fightImage
                                                      countX:1
                                                      countY:8
                                              charactarWidth:640
                                             charactarHeight:240];
        
        [_fightAnimArray addObject:fightSceanArray];
        
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
}


@end
