//
//  ViewController.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/11/24.
//  Copyright (c) 2014年 y.shibata. All rights reserved.
//

#import "ViewController.h"

#define MARGIN 8
#define BUTTON_WIDTH 20

@interface ViewController ()

@end

@implementation ViewController
{
    //heroオブジェクト
    MyHero      *_hero;
    //Bossオブジェクト
    EnemyBoss   *_enemyBoss;
    //Marineオブジェクト
    EnemyMarine *_enemyMarine;
    
}

//ここからアプリスタート
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self reset];
        
}


/** リセット */
- (void)reset {
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake(screenSizeX/2,screenSizeY/2);
    _hero = [[MyHero alloc]init:heroPos];
    //hero イメージを設定
    [_hero setImage:self.view];

    
    //Bossのインスタンス作成
    CGPoint bossPos = CGPointMake(100,screenSizeY/2);
    _enemyBoss = [[EnemyBoss alloc]init:bossPos];
    //Bossのイメージを設定
    [_enemyBoss setImage:self.view];
    
    //heroのx、y座標
    _xPos = _hero.position.x;
    _yPos = _hero.position.y;
    
    _actionTextView.text = @"";
    _positionTextField.text = [_hero whereAreYou];
    _resetBtn.hidden = YES;

}
- (IBAction)resetAction:(id)sender {
    [self reset];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)moveAction:(id)sender {
    
    [_enemyBoss moveRand];
    
    DirectionType direction = DirectionTypeFromLeftToRight;
    
    // ↑（上）ボタンをタップした時の処理
    
    if ([sender tag] == KeyTAGUp){
        direction = DirectionTypeFromBottomToTop;
    }
    
    // →（右）ボタンをタップした時の処理
    if ([sender tag] == KeyTAGRight){
        
        direction = DirectionTypeFromLeftToRight;
    
    }
    
    //↓ （下）ボタンをタップした時の処理
    if ([sender tag] == KeyTAGDown){
        direction = DirectionTypeFromTopToBottom;
        
    }
    
    // ←（左）ボタンをタップした時の処理
    if ([sender tag] == KeyTAGLeft){
        direction = DirectionTypeFromRightToLeft;
        
    }

    [_hero move:direction];
    
    //キャラクターステータス出力
    _actionTextView.text = [NSString stringWithFormat:@"%@は歩いている",_hero.name];
    
    //キャラクター位置出力
    //_positionTextField.text = [_hero whereAreYou];
    _positionTextField.text = [_enemyBoss whereAreYou];

}


@end
