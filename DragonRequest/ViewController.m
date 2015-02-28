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
#define ENEMY_MARINE_MAX 5
#define ENEMY_BOSS_MAX 200
#define ENEMY_BOSS_FIREST 0

@interface ViewController ()
<UIAlertViewDelegate>

@end

@implementation ViewController
{
    //heroオブジェクト
    MyHero      *_hero;
    //Bossオブジェクト
    EnemyBoss   *_enemyBoss[ENEMY_BOSS_MAX];
    //Marineオブジェクト
    EnemyMarine *_enemyMarine[ENEMY_MARINE_MAX];
    
    int cnt;    //ボスの攻撃頻度調整カウンタ
    NSTimer * timer;
    NSTimer * create;
}

//ここからアプリスタート
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    timer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];
//    
//    create = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
//    
//    [timer fire];
//    [create fire];
    [self reset];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches count : %lu (touchesBegan:withEvent:)", (unsigned long)[touches count]);
    //タッチイベントとタグを取り出す
    UITouch *touch = [touches anyObject];
    NSInteger tag = touch.view.tag;
    
    //タッチイベントから座標を取得
    CGPoint point = [touch locationInView:self.view];
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
    
    for(int i=0;i<ENEMY_BOSS_MAX;i++)[_enemyBoss[i] moveRand];
    
    [_hero moveToPoint:point];
    
    //タッチしたのが敵なら攻撃する
    switch (tag) {
        case HumanTypeEnemy: {
            BOOL dead[ENEMY_MARINE_MAX];
            for(int i=0;i<ENEMY_MARINE_MAX;i++)dead[i] = NO;
            for(int i=0;i<ENEMY_MARINE_MAX;i++)
                dead[i] = [_hero fight:_enemyMarine[i]];
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
            {
                if (dead[i]) {
                    [_enemyMarine[i] removeImage];
                    _enemyMarine[i] = nil;
                }
            }
            break;
        }
        case HumanTypeHero: {
            // 処理なし
            break;
        }
        case HumanTypeBoss: {
            BOOL dead[ENEMY_BOSS_MAX];
            for(int i=0;i<ENEMY_BOSS_MAX;i++)dead[i] = NO;
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
                dead[i] = [_hero fight:_enemyBoss[i]];
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
            {
                if (dead[i]) {
                    [_enemyBoss[i] removeImage];
                    _enemyBoss[i] = nil;
                }
            }
            break;
        }
        default:
            break;
    }
}

- (void)bossMove{
    for(int i=0;i<ENEMY_BOSS_MAX;i++){
        [_enemyBoss[i]  moveRand];
        
        if(cnt % 10 == 0){
            if([_enemyBoss[i]  fight:_hero]){
                [_hero removeImage];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                                message:@"コンティニューします"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"はい", nil];
                [alert show];
                [timer invalidate];
                [create invalidate];
            }
        }
    }
    cnt++;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self reset];
}

//タイマーで設定した時間ごとにボスを生成
- (void)createBoss{
    for(int i=0;i<ENEMY_BOSS_MAX;i++){
        if(_enemyBoss[i] == nil){
            //Bossのインスタンス作成
            _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
            _enemyBoss[i].alpha = 1.0;
            //Bossのイメージを設定
            [_enemyBoss[i] setImage:self.view];
            break;
        }
    }
//    NSLog(@"aaaaa");
}


/** リセット */
- (void)reset {
    
    for (int i=0;i<ENEMY_BOSS_MAX;i++){
        if(_enemyBoss[i] != nil){
            [_enemyBoss[i] removeImage];
            _enemyBoss[i] = nil;
        }
    }
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake(screenSizeX/2,screenSizeY/2);
    _hero = [[MyHero alloc]init:heroPos];

    //hero イメージを設定
    [_hero setImage:self.view];
    
    for(int i=0;i<ENEMY_BOSS_FIREST;i++){
        //Bossのインスタンス作成
        _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
        _enemyBoss[i].alpha = 1.0;
        //Bossのイメージを設定
        [_enemyBoss[i] setImage:self.view];
    }
    
    //heroのx、y座標
    _xPos = _hero.position.x;
    _yPos = _hero.position.y;
    
    _resetBtn.hidden = YES;
    
    timer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];
    
    create = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
    
    
    [timer fire];
    [create fire];
}
- (IBAction)resetAction:(id)sender {
    [self reset];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
