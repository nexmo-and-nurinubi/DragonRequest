//
//  ViewController.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/11/24.
//  Copyright (c) 2014年 y.shibata. All rights reserved.


//背景画像取得ページ
//  http://piposozai.wiki.fc2.com

#import "ViewController.h"

#define MARGIN 8
#define BUTTON_WIDTH 20
#define ENEMY_MARINE_MAX 200
#define ENEMY_MARINE_FIREST 0
#define ENEMY_BOSS_MAX 200
#define ENEMY_BOSS_FIREST 0

@interface ViewController ()<UIAlertViewDelegate>

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
    int createCnt;
    NSTimer * timer;
    NSTimer * create;
    
    BOOL clearflag;
    BOOL heroaliveflag;
    
    int stagenumber;
    
    NSInteger score;
    NSInteger topScore;
    
    __weak IBOutlet UILabel *topScoreLabel;
    __weak IBOutlet UILabel *scoreLabel;
    
    NSString *clearmes;
}

//ここからアプリスタート
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //変数初期化
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    topScore = [defaults integerForKey:@"TOPSCORE"];
    
    topScoreLabel.text = [@(topScore) stringValue];
    score = initMainScore;
    scoreLabel.text = [@(score) stringValue];
    
    stagenumber = 1;
    
    //タッチイベントから座標を取得
    CGPoint point = CGPointMake(_hero.position.x, _hero.position.y);
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
    
    //for(int i=0;i<ENEMY_BOSS_MAX;i++)[_enemyBoss[i] moveRand];
    //for(int i=0;i<ENEMY_MARINE_MAX;i++)[_enemyMarine[i] moveRand];
    
    [_hero moveToPoint:point];
    
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
    
    //for(int i=0;i<ENEMY_BOSS_MAX;i++)[_enemyBoss[i] moveRand];
    //for(int i=0;i<ENEMY_MARINE_MAX;i++)[_enemyMarine[i] moveRand];
    
    [_hero moveToPoint:point];
    
    //タッチしたのが敵なら攻撃する
    switch (tag) {
        case HumanTypeEnemy: {
            BOOL dead[ENEMY_MARINE_MAX];
            for(int i=0;i<ENEMY_MARINE_MAX;i++)dead[i] = NO;
            for(int i=0;i<ENEMY_MARINE_MAX;i++)dead[i] = [_hero fight:_enemyMarine[i]];
            for(int i=0;i<ENEMY_MARINE_MAX;i++) {
                if (dead[i]) {
                    [_enemyMarine[i] removeImage];
                    _enemyMarine[i] = nil;
                    score += marineDeadScore;
                    scoreLabel.text = [@(score) stringValue];
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
            for(int i=0;i<ENEMY_BOSS_MAX;i++)dead[i] = [_hero fight:_enemyBoss[i]];
            for(int i=0;i<ENEMY_BOSS_MAX;i++) {
                if (dead[i]) {
                    [_enemyBoss[i] removeImage];
                    _enemyBoss[i] = nil;
                    score +=bossDeadScore;
                    scoreLabel.text = [@(score) stringValue];
                }
            }
            break;
        }
        default:
            break;
    }
    
    // 敵が殲滅したか確認する
    BOOL annihilate = YES;
    if (annihilate) {
        for (int i = 0; i<ENEMY_MARINE_MAX; i++) {
            if (_enemyMarine[i]) {
                annihilate = NO;
                break;
            }
        }
    }
    if (annihilate) {
        for (int i = 0; i<ENEMY_BOSS_MAX; i++) {
            if (_enemyBoss[i]) {
                annihilate = NO;
                break;
            }
        }
    }
    
    // ステージクリア
    if(annihilate) {
        UIAlertView *alart = [[UIAlertView alloc] initWithTitle:@"Stage Clear"
                                                        message:clearmes delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"YES", nil];
        if(score>=topScore){
            topScore = score;
            scoreLabel.text = [@(score) stringValue];;
            topScoreLabel.text = [@(topScore) stringValue];;
            
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            
            // Integerの保存
            [defaults setInteger:topScore forKey:@"TOPSCORE"];
            
            
        }
        scoreLabel.text = [@(score) stringValue];;
        
        [alart show];
        [_hero removeImage];
        clearflag = true;
        stagenumber++;
        if(stagenumber >= 4)
        {
            stagenumber = 1;
        }
    }
}

- (void)bossMove{
    for(int i=0;i<ENEMY_MARINE_MAX;i++){
        
        [_enemyMarine[i]  moveRand];
        
        if(heroaliveflag == false)
        {
            
            if(cnt % 10 == 0){
                if([_enemyMarine[i]  fight:_hero]){
                    //                [_hero removeImage];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                                    message:@"コンティニューします"
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"YES", nil];
                    if(score>=topScore){
                        topScore = score;
                        scoreLabel.text = [@(score) stringValue];;
                        topScoreLabel.text = [@(topScore) stringValue];;
                        
                        
                    }
                    score = initMainScore;
                    scoreLabel.text = [@(score) stringValue];;
                    
                    [alert show];

                    stagenumber = 1;
                    [_hero removeImage];
                    heroaliveflag = true;
                    break;
                }
            }
        }
    }
    for(int i=0;i<ENEMY_BOSS_MAX;i++){
        
        [_enemyBoss[i]  moveRand];
        
        if(heroaliveflag == false)
        {
            
            if(cnt % 10 == 0){
                if([_enemyBoss[i]  fight:_hero]){
                    //                [_hero removeImage];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                                    message:@"コンティニューします"
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"YES", nil];
                    if(score>=topScore){
                        topScore = score;
                        scoreLabel.text = [@(score) stringValue];;
                        topScoreLabel.text = [@(topScore) stringValue];;
                        
                        
                    }
                    score = initMainScore;
                    scoreLabel.text = [@(score) stringValue];;
                    
                    [alert show];
                    
                    stagenumber = 1;
                    [_hero removeImage];
                    heroaliveflag = true;
                    break;
                }
            }
        }
    }
    
    cnt++;
    
    
}

//アラートのボタンを押したとき
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self reset];
    
}

//タイマーで設定した時間ごとにボスを生成
- (void)createBoss{
    
    if (clearflag) {
        NSLog(@"リターン");
        return;
    }
    
    for(int i=0;i<ENEMY_MARINE_MAX;i++){
        if(_enemyMarine[i] == nil){
            //Bossのインスタンス作成
            _enemyMarine[i] = [[EnemyMarine alloc] init:CGPointZero];
            _enemyMarine[i].alpha = 1.0;
            //Bossのイメージを設定
            [_enemyMarine[i] setImage:self.view belowSubview:self.weaponCollectionView];
            createCnt++;
            break;
            
        }
    }
    NSLog(@"雑魚生成");
    
    if(createCnt % 10 == 0){
        for(int i=0;i<ENEMY_BOSS_MAX;i++){
            if(_enemyBoss[i] == nil){
                //Bossのインスタンス作成
                _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
                _enemyBoss[i].alpha = 1.0;
                //Bossのイメージを設定
                [_enemyBoss[i] setImage:self.view belowSubview:self.weaponCollectionView];
                break;
            }
        }
        NSLog(@"ボス生成");
    }
}


/** リセット */
- (void)reset {
    
    clearflag = false;
    heroaliveflag = false;
    
    clearmes = @"次のステージに進みます";
    
    int createtime = 0;
    switch (stagenumber) {
        case 1:
            _fieldView.image = [UIImage imageNamed:@"mapbg01.png"];
            createtime = bossCreatetime1;
            break;
        case 2:
            _fieldView.image = [UIImage imageNamed:@"mapbg02.png"];
            createtime = bossCreatetime2;
            break;
        case 3:
            _fieldView.image = [UIImage imageNamed:@"mapbg04.png"];
            createtime = bossCreatetime3;
            clearmes = @"すべてのステージをクリアしました";
            break;
            
        default:
            break;
    }
    
    
    for (int i=0;i<ENEMY_BOSS_MAX;i++){
        if(_enemyBoss[i] != nil){
            [_enemyBoss[i] removeImage];
            _enemyBoss[i] = nil;
        }
    }
    for (int i=0;i<ENEMY_MARINE_MAX;i++){
        if(_enemyMarine[i] != nil){
            [_enemyMarine[i] removeImage];
            _enemyMarine[i] = nil;
        }
    }
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake(screenSizeX/2,screenSizeY/2);
    _hero = [[MyHero alloc]init:heroPos];
    
    //hero イメージを設定
    [_hero setImage:self.view belowSubview:self.weaponCollectionView];
    
    for(int i=0;i<ENEMY_BOSS_FIREST;i++){
        //Bossのインスタンス作成
        _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
        _enemyBoss[i].alpha = 1.0;
        //Bossのイメージを設定
        [_enemyBoss[i] setImage:self.view belowSubview:self.weaponCollectionView];
    }
    
    for(int i=0;i<ENEMY_MARINE_FIREST;i++){
        //Marineのインスタンス作成
        _enemyMarine[i] = [[EnemyMarine alloc] init:CGPointZero];
        _enemyMarine[i].alpha = 1.0;
        //Marineのイメージを設定
        [_enemyMarine[i] setImage:self.view belowSubview:self.weaponCollectionView];
    }
    
    //heroのx、y座標
    _xPos = _hero.position.x;
    _yPos = _hero.position.y;
    
    if(timer == nil){
        timer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];
        
        create = [NSTimer scheduledTimerWithTimeInterval:bossCreatetime1 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
    }
    
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:bossMoveTimeInterval]];
    [timer fire];
    [create setFireDate:[NSDate dateWithTimeIntervalSinceNow:createtime]];
    [create fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
