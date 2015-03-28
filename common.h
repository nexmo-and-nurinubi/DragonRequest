//
//  common.h
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//
//-----------------------------------------------------------
// enum : HumanType
//-----------------------------------------------------------

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HumanType) {
    HumanTypeHuman = 100,
    HumanTypeHero,
    HumanTypeEnemy,
    HumanTypeBoss
};

typedef NS_ENUM(NSUInteger, DirectionType) {
    DirectionTypeFromLeftToRight,
    DirectionTypeFromRightToLeft,
    DirectionTypeFromBottomToTop,
    DirectionTypeFromTopToBottom,
};

#define KeyTAGLeft                  4
#define KeyTAGRight                 2
#define KeyTAGUp                    1
#define KeyTAGDown                  3

// Fightのアニメーション
#define fightDuration                   0.1

// ヒュマン初期情報
#define humanPowerImgGapY               8
#define humanPowerImgHeight             3
#define humanPowerImgWidth              32

#define humanStepX                      8
#define humanStepY                      8
#define humanReach                      8
#define humanImageSizeWidth             16
#define humanImageSizeHeight            16
#define humanFightImageSizeWidth        128
#define humanFightImageSizeHeight       128
#define humanImageCutSizeWidth          16
#define humanImageCutSizeHeight         16

#define humanCountAnimComma             3

#define maxMoveCount                    5

// ヒーロー初期情報
#define heroMoveTimeInterval            0.1f

#define heroStepX                       15
#define heroStepY                       15
#define heroReach                       200
#define heroImageSizeWidth              32
#define heroImageSizeHeight             32
#define heroImageCutSizeWidth           32
#define heroImageCutSizeHeight          32

#define heroCountAnimComma              3

#define heroDefaultName                 @"まさと"
#define heroDefaultPower                500.0f
#define heroMinusPower                  10.0f
#define heroDefaultPosX                 10
#define heroDefaultPosY                 10

#define heroTagNumber                   10000

//marine初期情報
#define marineMoveTimeInterval          0.1f
#define marineStepX                     5
#define marineStepY                     5
#define marineReach                     8
#define marineRadarRange                180
#define marineImageSizeWidth            60
#define marineImageSizeHeight           60
#define marineImageCutSizeWidth         60
#define marineImageCutSizeHeight        60

#define marineCountAnimComma            3

#define marineDefaultName               @"Marine"
#define marineDefaultPower              25.0f
#define marineMinusPower                1.0f
#define marineDefaultPosX               10
#define marineDefaultPosY               10

//boss初期情報
#define bossMoveTimeInterval            0.1f
#define bossPatrolRadius                72

#define bossStepX                       3
#define bossStepY                       3
#define bossReach                       24
#define bossRadarRange                  300
#define bossImageSizeWidth              100
#define bossImageSizeHeight             100
#define bossImageCutSizeWidth           80
#define bossImageCutSizeHeight          64

#define bossCountAnimComma              3


#define bossDefaultName                 @"Boss"
#define bossDefaultPower                300.0f
#define bossMinusPower                  5.0f
#define bossDefaultPosX                 10
#define bossDefaultPosY                 10

#define bossCreatetime1                 3
#define bossCreatetime2                 2
#define bossCreatetime3                 1

#define bossColoreBrack                 @"dora10.png"
#define bossColoreWhite                 @"dora09.png"
#define bossColoreBlue                  @"dora12.png"
#define bossColoreRed                   @"dora17.png"
#define bossColoreGreen                 @"dora14.png"
#define bossColoreGold                  @"dora18.png"

//DropItem情報
#define DropItemImageSize               24

//Score初期情報
#define bossDeadScore                   100
#define marineDeadScore                 10
#define initMainScore                   0
#define highScore                       0

#define bgFileName01                    @"bgimage01.png"
#define bgFileName02                    @"bgimage02.png"
#define bgFileName03                    @"bgimage03.png"

@interface common : NSObject

//画面サイズ
+ (NSInteger)screenSizeWidth;
+ (NSInteger)screenSizeHeight;

@end



