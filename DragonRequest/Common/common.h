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
    HumanTypeEnemy,
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
#define humanStepX                    4
#define humanStepY                    4
#define humanImageSizeWidth              24
#define humanImageSizeHeight             24

// ヒーロー初期情報
#define heroStepX                       12
#define heroStepY                       12
#define heroImageSizeWidth              6
#define heroImageSizeHeight             6

#define heroDefaultName                 @"まさと"
#define heroDefaultPower                50
#define heroMinusPower                  10
#define heroDefaultPosX                 10
#define heroDefaultPosY                 10

//marine初期情報
#define marineStepX                     10
#define marineStepY                     10
#define marineImageSizeWidth            24
#define marineImageSizeHeight           24

#define marineDefaultName               @"Marine"
#define marineDefaultPower              10
#define marineMinusPower                1
#define marineDefaultPosX               10
#define marineDefaultPosY               10

//boss初期情報
#define bossStepX                       20
#define bossStepY                       20
#define bossImageSizeWidth              48
#define bossImageSizeHeight             48

#define bossDefaultName                 @"Boss"
#define bossDefaultPower                10
#define bossMinusPower                  1
#define bossDefaultPosX                 10
#define bossDefaultPosY                 10




