//
//  Human.h
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//
//-----------------------------------------------------------
// parent : Human
//-----------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "common.h"

@interface Human : NSObject {
    
    //キャラクタータイプ（human / marine / boss など）
    HumanType _myHumanType;
    
    //移動方向
    DirectionType _direction;
    
    //移動残り数
    u_int32_t _moveRestCount;

    //キャラクターイメージを表示するiOS obect
    UIImageView *_animationImage;
    
    //キャラクターサイズ
    int _imageWidth;
    int _imageHeight;
    
    //１回移動時のサイズ
    int _stepX;
    int _stepY;
    
    //画面サイズ
    int _screenSizeX;
    int _screenSizeY;
    
    
}

//キャラクター名
@property (nonatomic,copy) NSString *name;

//相手に与えるダメージ
@property (nonatomic,assign) NSInteger minusPower;

//自分のパワー
@property (nonatomic,assign) NSInteger power;

//自分の位置
@property (nonatomic,assign) CGPoint position;

//自分のキャラクターサイズ
@property (nonatomic,assign) CGRect frameSize;

- (id)init :(CGPoint)initPos;

- (NSString *)whoAreYou;
- (NSString *)whereAreYou;
- (NSString *)fight:(NSInteger)enemyPower;

-(void)setImage:(UIView *)parentView;
-(void)moveRand;
-(void)move:(DirectionType) direction;
-(void)stopToWalk;
-(void)setAnimation:(DirectionType)direction;

@end
