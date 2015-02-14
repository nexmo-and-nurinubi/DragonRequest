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

//画面サイズ
#define screenSizeX                 320
#define screenSizeY                 568

// ヒュマン初期情報
#define humanStepX                      8
#define humanStepY                      8
#define humanReach                      8
#define humanImageSizeWidth             16
#define humanImageSizeHeight            16
#define maxMoveCount                    5

// ヒーロー初期情報
#define heroMoveTimeInterval            0.1f

#define heroStepX                       3
#define heroStepY                       3
#define heroReach                       24
#define heroImageSizeWidth              16
#define heroImageSizeHeight             16

#define heroDefaultName                 @"まさと"
#define heroDefaultPower                50
#define heroMinusPower                  10
#define heroDefaultPosX                 10
#define heroDefaultPosY                 10

//marine初期情報
#define marineMoveTimeInterval          1.0f
#define marineStepX                     8
#define marineStepY                     8
#define marineReach                     8
#define marineImageSizeWidth            16
#define marineImageSizeHeight           16

#define marineDefaultName               @"Marine"
#define marineDefaultPower              50
#define marineMinusPower                1
#define marineDefaultPosX               10
#define marineDefaultPosY               10

//boss初期情報
#define bossMoveTimeInterval            1.0f
#define bossPatrolRadius                72

#define bossStepX                       20
#define bossStepY                       20
#define bossReach                       12
#define bossImageSizeWidth              48
#define bossImageSizeHeight             48

#define bossDefaultName                 @"Boss"
#define bossDefaultPower                100
#define bossMinusPower                  1
#define bossDefaultPosX                 10
#define bossDefaultPosY                 10




