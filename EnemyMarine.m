//
//  EnemyMarine.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "EnemyMarine.h"

@implementation EnemyMarine

- (id)init :(CGPoint)initPos
        tag:(NSInteger)tag
{
    
    self = [super init:initPos
                   tag:tag];
    
    if (self) {
        
        _myHumanType = HumanTypeEnemy;
        
        self.name = marineDefaultName;
        
        self.power = marineDefaultPower;
        self.defaultPower = marineDefaultPower;
        self.minusPower = marineMinusPower;
        
        _stepX = marineStepX;
        _stepY = marineStepY;
        
        _reach = marineImageSizeWidth;
        _radarRange = marineRadarRange;
        
        _imageWidth = marineImageSizeWidth;
        _imageHeight = marineImageSizeHeight;
        
        _imageCutSizeWidth = marineImageCutSizeWidth;
        _imageCutSizeHeight= marineImageCutSizeHeight;
        
        _countComma = marineCountAnimComma;
        
        
    }
    return self;
}

-(void)setImage:(UIView *)parentView
   belowSubview:(UIView *)siblingSubview
{
    //イメージ設定
    [super setImage:parentView belowSubview:siblingSubview];
    
    //ワーキングアニメーションイメージ設定
    [self setMoveAnimImage:@"shadow01.png"
                     countX:3
                     countY:4];
    
    //戦闘シーンアニメーションイメージ設定
    [self setFightAnimImage];
    
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

-(void)setFightAnimImage
{
    @try{
        
        if(_fightAnimArray==nil) {
            _fightAnimArray = [NSMutableArray array];
        } else {
            [_fightAnimArray removeAllObjects];
        }
        
        //fight アニメーションロード
        UIImage *fightImage = nil;
        
        NSMutableArray *effectArray = [NSMutableArray array];
        NSArray *fightSceanArray = nil;
        
        //fight アニメーションロード1
        fightImage = [UIImage imageNamed:@"pipo-btleffect026.png"];
        
        fightSceanArray = [[DrUtil sharedInstance] animArray:fightImage
                                                      countX:8
                                                      countY:1
                                              charactarWidth:0
                                             charactarHeight:0];
        
        [effectArray addObject:fightSceanArray];
        
        //fight アニメーションロード2
        fightImage = [UIImage imageNamed:@"pipo-btleffect027.png"];
        
        fightSceanArray = [[DrUtil sharedInstance] animArray:fightImage
                                                      countX:8
                                                      countY:1
                                              charactarWidth:0
                                             charactarHeight:0];
        
        [effectArray addObject:fightSceanArray];
        
        //fight アニメーションロード3
        fightImage = [UIImage imageNamed:@"pipo-btleffect028.png"];
        
        fightSceanArray = [[DrUtil sharedInstance] animArray:fightImage
                                                      countX:1
                                                      countY:8
                                              charactarWidth:640
                                             charactarHeight:240];
        
        [effectArray addObject:fightSceanArray];
        
        [_fightAnimArray addObject:effectArray];
        
        DLog();
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
}

@end
