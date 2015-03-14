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
    HumanTypeEnemy = 100,
    HumanTypeHero,
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

// ヒュマン初期情報
#define humanPowerImgGapY               8
#define humanPowerImgHeight             3

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
#define heroMoveTimeInterval            0.4f

#define heroStepX                       15
#define heroStepY                       15
#define heroReach                       24
#define heroImageSizeWidth              32
#define heroImageSizeHeight             32
#define heroImageCutSizeWidth           32
#define heroImageCutSizeHeight          32

#define heroCountAnimComma              3

#define heroDefaultName                 @"まさと"
#define heroDefaultPower                30.0f
#define heroMinusPower                  10.0f
#define heroDefaultPosX                 10
#define heroDefaultPosY                 10

//marine初期情報
#define marineMoveTimeInterval          1.0f
#define marineStepX                     8
#define marineStepY                     8
#define marineReach                     8
#define marineImageSizeWidth            16
#define marineImageSizeHeight           16
#define marineImageCutSizeWidth         16
#define marineImageCutSizeHeight        16

#define marineCountAnimComma             3

#define marineDefaultName               @"Marine"
#define marineDefaultPower              50.0f
#define marineMinusPower                1.0f
#define marineDefaultPosX               10
#define marineDefaultPosY               10

//boss初期情報
#define bossMoveTimeInterval            0.1f
#define bossPatrolRadius                72

#define bossStepX                       3
#define bossStepY                       3
#define bossReach                       24
#define bossImageSizeWidth              48
#define bossImageSizeHeight             48
#define bossImageCutSizeWidth           73
#define bossImageCutSizeHeight          58

#define bossCountAnimComma              3


#define bossDefaultName                 @"Boss"
#define bossDefaultPower                30.0f
#define bossMinusPower                  5.0f
#define bossDefaultPosX                 10
#define bossDefaultPosY                 10

#define bossCreatetime1                 3
#define bossCreatetime2                 2
#define bossCreatetime3                 1

//Score初期情報
#define bossDeadScore                   100
#define marineDeadScore                 10
#define initMainScore                   0
#define highScore                       0

#define bgFileName01                    @"bgimage01.png"
#define bgFileName02                    @"bgimage02.png"
#define bgFileName03                    @"bgimage03.png"





