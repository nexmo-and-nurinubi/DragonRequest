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
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];
    [timer fire];
}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches count : %lu (touchesBegan:withEvent:)", (unsigned long)[touches count]);
    //タッチイベントを取り出す
    UITouch *touch = [touches anyObject];
    //タッチイベントから座標を取得
    CGPoint point = [touch locationInView:self.view];
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
   
    [_enemyBoss moveRand];

    [_hero moveToPoint:point];
}

- (void)bossMove{
    [_enemyBoss moveRand];

}


/** リセット */
- (void)reset {
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake(screenSizeX/2,screenSizeY/2);
    _hero = [[MyHero alloc]init:heroPos];
    _hero.orgImage = [UIImage imageNamed:@"animation.png"];

    //hero イメージを設定
    [_hero setImage:self.view];
    
    //Bossのインスタンス作成
    CGPoint bossPos = CGPointMake(100,screenSizeY/2);
    _enemyBoss = [[EnemyBoss alloc] init:bossPos
                                   alpha:1.0];
    _enemyBoss.orgImage = [UIImage imageNamed:@"dragonSprite_orange.png"];
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
    _positionTextField.text = [_enemyBoss whereAreYou];

}


@end
