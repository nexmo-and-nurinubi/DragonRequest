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
#import "DrUtil.h"

@interface Human : NSObject {
    
    //キャラクタータイプ（human / marine / boss など）
    HumanType _myHumanType;
    
    //移動方向
    DirectionType _direction;
    
    //移動残り数
    u_int32_t _moveRestCount;

    //キャラクターイメージを表示するiOS obect
    UIImage *_originalAnimationImage;
    
    //キャラクターPowerを表示するiOS obect
    UIImageView *_powerImageView;

    //キャラクターPowerBgを表示するiOS obect
    UIImageView *_powerBgImageView;
    
    //キャラクターサイズ
    NSInteger _imageWidth;
    NSInteger _imageHeight;

    NSInteger _imageCutSizeWidth;
    NSInteger _imageCutSizeHeight;

    NSInteger _countComma;
    
    //１回移動時のサイズ
    NSInteger _stepX;
    NSInteger _stepY;
    
    //攻撃範囲
    NSInteger _reach;
    
    //画面サイズ
    int _screenSizeX;
    int _screenSizeY;
    
    float _defaultPower;
    
    NSInteger _level;
    
    //向きアニメーション配列
    NSMutableArray *_walkingSceanAnimArray;
    
    //向きことのアニメーション
    NSArray *_frontSceanAnimArray;
    NSArray *_backSceanAnimArray;
    NSArray *_leftSceanAnimArray;
    NSArray *_rightSceanAnimArray;
    
    //戦闘シーンアニメーション
    NSMutableArray *_fightAnimArray;
    
}

//キャラクター名
@property (nonatomic,copy) NSString *name;

//相手に与えるダメージ
@property (nonatomic,assign) NSInteger minusPower;

//自分のパワー
@property (nonatomic,assign) float power;

//自分の位置
@property (nonatomic,assign) CGPoint position;

//自分のキャラクターサイズ
@property (nonatomic,assign) CGRect frameSize;

// 透明度
@property (nonatomic,assign) float alpha;

//キャラクターイメージを表示するiOS obect
@property (nonatomic, strong)UIImageView *animationImageView;

//キャラクターバトルイメージを表示するiOS obect
@property (nonatomic, strong) UIImageView *fightAnimationImageView;

- (id)init :(CGPoint)initPos;

- (NSString *)whoAreYou;
- (NSString *)whereAreYou;
- (BOOL)fight:(Human *)target;

-(void)setImage:(UIView *)parentView belowSubview:(UIView *)siblingSubview;
-(void)removeImage;
-(void)moveRand;
-(void)setPowerImage;
-(void)move:(DirectionType) direction;
-(void)moveToPoint:(CGPoint)toPoint;
-(void)stopToWalk;
-(void)setAnimation:(DirectionType)direction;
-(void)setMoveAnimImage:(NSString *)originalImageName
                 countX:(int)countX
                 countY:(int)countY;

@end
