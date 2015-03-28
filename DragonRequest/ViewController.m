//
//  ViewController.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/11/24.
//  Copyright (c) 2014年 y.shibata. All rights reserved.


//背景画像取得ページ
//  http://piposozai.wiki.fc2.com

#import "ViewController.h"
#import "DropItemController.h"
#import "DropItemImageView.h"

#import <AVFoundation/AVFoundation.h>

#define MARGIN 8
#define BUTTON_WIDTH 20
#define ENEMY_MARINE_MAX 200
#define ENEMY_MARINE_FIREST 0
#define ENEMY_BOSS_MAX 200
#define ENEMY_BOSS_FIREST 0

@interface ViewController ()

@end

@implementation ViewController
{
    //heroオブジェクト
    MyHero      *_hero;
    
    //マリン保存配列
    NSMutableArray *_enemyBossArray;
    //ボス保存配列
    NSMutableArray *_enemyMarineArray;
    
    int cnt;    //ボスの攻撃頻度調整カウンタ
    int createCnt;
    
    //メインストーリ呼び出しタイマー
    NSTimer * _storyTimer;
    //敵生成タイマー
    NSTimer * _createEnemyTimer;
    
    //ステージ
    int stagenumber;

    //スコア
    NSInteger score;
    //トップスコア
    NSInteger topScore;
    
    __weak IBOutlet UILabel *heroPowerLabel;
    __weak IBOutlet UILabel *scoreLabel;
    __weak IBOutlet UILabel *playerNameLabel;
    __weak IBOutlet UIImageView *gcPlayerPictureImage;
    
    NSString *clearmes;
    
    DrUtil *_utilManager;
    
    AVAudioPlayer *_startSound;
    
    AVAudioPlayer *_deadMarineSound;
    AVAudioPlayer *_deadBossSound;
    AVAudioPlayer *_heroAttackSound;
    AVAudioPlayer *_heroScreamSound;
    AVAudioPlayer *_heroDeadSound;
    
    NSUserDefaults* defaults;
    NSMutableArray *scoreArray;
    
}

//ここからアプリスタート
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _utilManager = [DrUtil sharedInstance];

    //トップスコア初期化＆ロード
    defaults = [NSUserDefaults standardUserDefaults];
    topScore = [defaults integerForKey:@"TOPSCORE"];
    
    score = initMainScore;
    scoreLabel.text = [@(score) stringValue];
    
    // GameCenter初期化
    [[GameCenterManager sharedManager] setDelegate:self];

    //マリン保存配列初期化
    _enemyMarineArray = [NSMutableArray array];

    //ボス保存配列初期化
    _enemyBossArray = [NSMutableArray array];
    
    //スタートステージ
    stagenumber = 1;

    // AudioPlayer初期化
    NSString *path = nil;
    
    path = [[NSBundle mainBundle] pathForResource : @"264981__renatalmar__sfx-magic" ofType :@"wav"];
    _startSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [_startSound prepareToPlay];

    path = [[NSBundle mainBundle] pathForResource : @"07" ofType :@"wav"];
    _deadMarineSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [_deadMarineSound prepareToPlay];

    path = [[NSBundle mainBundle] pathForResource : @"07" ofType :@"wav"];
    _deadBossSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [_deadBossSound prepareToPlay];

    path = [[NSBundle mainBundle] pathForResource : @"118513__thefsoundman__punch-02" ofType :@"wav"];
    _heroAttackSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [_heroAttackSound prepareToPlay];
    
    path = [[NSBundle mainBundle] pathForResource : @"264981__renatalmar__sfx-magic" ofType :@"wav"];
    _heroScreamSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [_heroScreamSound prepareToPlay];

    path = [[NSBundle mainBundle] pathForResource : @"264981__renatalmar__sfx-magic" ofType :@"wav"];
    _heroDeadSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [_heroDeadSound prepareToPlay];
    
    
    //画面・キャラクター初期化
    [self startGame];
    
    heroPowerLabel.text = [@((int)_hero.power) stringValue];
    
    //タッチイベントから座標を取得
    CGPoint point = CGPointMake(_hero.position.x, _hero.position.y);
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
    [_hero gotoToPoint:point];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    _weaponCollectionView.hidden = YES;
    
    BOOL available = [[GameCenterManager sharedManager] checkGameCenterAvailability];
    if (available) {
        gcPlayerPictureImage.image = [UIImage imageNamed:@"gamecenter"];
    } else {
        gcPlayerPictureImage.image = nil;
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    
    if (player) {
        
        //GameCentereユーザ名設定
        playerNameLabel.text = player.displayName;
        
    } else {
        
        playerNameLabel.text = [NSString stringWithFormat:@"俺様"];
        
    }
}


// 敵を倒した時の処理
- (void)deadWithCharactor:(Human *)enemy type:(int)type
{
    int point = 0;
    if (type == HumanTypeBoss) {
        point = bossDeadScore;
    } else if (type == HumanTypeEnemy) {
        point = marineDeadScore;
    }
    
    // DropItemの生成
    DropItemType dropItemType = [DropItemController randDropItemType];
    if ([DropItemController isCreateDropItem:dropItemType]) {
        DropItemImageView *dropItemImageView = [[DropItemImageView alloc] initWithPoint:enemy.animationImageView.center dropItemType:dropItemType];
        [self.view addSubview:dropItemImageView];
    }
    
    [enemy removeImage];
    enemy = nil;
    score += point;
    scoreLabel.text = [@(score) stringValue];
    
    
    // 敵を倒した時の音を再生
    [_deadMarineSound stop];
    _deadMarineSound.currentTime = 0;
    [_deadMarineSound play];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 敵を倒した時の音を再生
    [_heroAttackSound stop];
    _heroAttackSound.currentTime = 0;
    [_heroAttackSound play];
    
    NSLog(@"touches count : %lu (touchesBegan:withEvent:)", (unsigned long)[touches count]);
    //タッチイベントとタグを取り出す
    UITouch *touch = [touches anyObject];
    
    NSInteger tag = 0;
    
    UIView *view = touch.view;
    
    tag = view.tag;
    
    //タッチしたのがDropItemなら拾う
    if ([view isKindOfClass:[DropItemImageView class]]) {
        
        DropItemType dropItemType = (DropItemType)tag;
        switch (dropItemType) {
            case DropItemTypeNone:
                DLog(@"Error: DropItemType is DropItemTypeNone.");
                break;
            case DropItemTypeStatusUp:
                // ToDo
                break;
            case DropItemTypeMagic:
                // ToDo
                break;
            case DropItemTypeWeapon:
                // ToDo
                break;
        }
    }
    //DropItem以外
    //背景をタッチ
    else if(tag==0){
        
        //タッチイベントから座標を取得移動
        CGPoint point = [touch locationInView:self.view];
        
        [_hero gotoToPoint:point];
        
    }
    //マリンもしくはボスをタッチ
    else if(tag<heroTagNumber){
        
        Human *enemy = [self getView2Human:view];
        
        if(enemy != nil){
            
            BOOL ret = [_hero enemyIsNear:enemy];
            
            //敵が近くにいる？
            if(ret == YES){
                
                //戦え〜
                [_hero fight:enemy];
                
                if(enemy.power<=0.0){
                    
                    [enemy removeImage];
                    
                    if([enemy isKindOfClass:[EnemyBoss class]]){
                        
                        // 敵を倒した時の音を再生
                        [_deadBossSound stop];
                        _deadBossSound.currentTime = 0;
                        [_deadBossSound play];
                        
                        [_enemyBossArray removeObject:enemy];
                        
                        _hero.power += 100;
                        
                    }
                    else if([enemy isKindOfClass:[EnemyMarine class]]){
                        
                        // 敵を倒した時の音を再生
                        [_deadMarineSound stop];
                        _deadMarineSound.currentTime = 0;
                        [_deadMarineSound play];
                        
                        [_enemyMarineArray removeObject:enemy];

                        _hero.power += 10;
                        
                    }
                }
            }
            
            //タッチイベントから座標を取得移動
            CGPoint point = [touch locationInView:self.view];
            [_hero gotoToPoint:point];
                
        }
        
    }
    
    
/*
    switch (tag) {
            
        case HumanTypeEnemy: {
            
            BOOL dead[ENEMY_MARINE_MAX];
            for(int i=0;i<ENEMY_MARINE_MAX;i++)
                dead[i] = NO;
            for(int i=0;i<ENEMY_MARINE_MAX;i++)
                dead[i] = [_hero fight:_enemyMarine[i]];
            for(int i=0;i<ENEMY_MARINE_MAX;i++) {
                if (dead[i]) {
                    [self deadWithCharactor:_enemyMarine[i] type:HumanTypeEnemy];
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
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
                dead[i] = NO;
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
                dead[i] = [_hero fight:_enemyBoss[i]];
            for(int i=0;i<ENEMY_BOSS_MAX;i++) {
                if (dead[i]) {
                    [self deadWithCharactor:_enemyBoss[i] type:HumanTypeBoss];
                }
            }
            break;
        }
        default:
            break;
    }
*/    

}
-(Human *)getView2Human:(UIView *)view
{
    if(![view isKindOfClass:[UIImageView class]])return nil;
    
    UIImageView *thisView = (UIImageView *)view;
    
    Human *thisHuman = nil;
    
    for(Human *human in _enemyMarineArray){
        
        if(human.animationImageView == thisView){
         
            thisHuman = human;
            break;
        }
    }

    for(Human *human in _enemyBossArray){
        
        if(human.animationImageView == thisView){
            
            thisHuman = human;
            break;
        }
    }
    
    return thisHuman;
}

// オブジェクトの並べ替え
- (void)checkCharacterLayer
{
    for(EnemyMarine *enemyMarine in _enemyMarineArray){
        
        NSInteger marinePosY = enemyMarine.animationImageView.frame.origin.y + enemyMarine.animationImageView.frame.size.height;
        NSInteger heroPosY = _hero.animationImageView.frame.origin.y + _hero.animationImageView.frame.size.height;
        
        if ( marinePosY > heroPosY){
            [enemyMarine moveToFront:self.view];
        }
        else{
            [_hero moveToFront:self.view];
        }
        
    }
    
    for(EnemyBoss *enemyBoss in _enemyBossArray){
        
        NSInteger bossPosY = enemyBoss.animationImageView.frame.origin.y + enemyBoss.animationImageView.frame.size.height;
        NSInteger heroPosY = _hero.animationImageView.frame.origin.y + _hero.animationImageView.frame.size.height;
        
        if ( bossPosY > heroPosY)
            [enemyBoss moveToFront:self.view];
        else
            [_hero moveToFront:self.view];
        
    }
    
    // ToDo. 必要に応じて、DropItemImageViewも追加
//    [self.view bringSubviewToFront:_weaponCollectionView];
//    [self.view bringSubviewToFront:topScoreLabel];
//    [self.view bringSubviewToFront:scoreLabel];
//    [self.view bringSubviewToFront:playerNameLabel];
//    [self.view bringSubviewToFront:gcPlayerPictureImage];
}


- (void)checkGameStory{
    
    score++;
    
    //マリン移動
    for(EnemyMarine *_enemyMarine in _enemyMarineArray){
        
        [_enemyMarine  moveRand:_hero];
        
    }

    //ボス移動
    for(EnemyBoss *_enemyBoss in _enemyBossArray){
        
        [_enemyBoss  moveRand:_hero];
        
    }
    
    //キャラクタレイアをチェック
    [self checkCharacterLayer];

    //ゲームオーバーチェック（Hero命パワーが０？）
    if(_hero.power<=0.0){

        // 敵を倒した時の音を再生
        [_heroDeadSound stop];
        _heroDeadSound.currentTime = 0;
        [_heroDeadSound play];
        
        //_storyTimerストップ
        [_storyTimer invalidate];
        _storyTimer = nil;
        
        //敵生成Timerストップ
        [_createEnemyTimer invalidate];
        _createEnemyTimer = nil;
        
        //アラート表示
        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
        
        [alertView setContainerView:[self showAlertView]];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Continue", @"Menu", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        
        if(score>=topScore){
            
            topScore = score;
            
            [[GameCenterManager sharedManager] saveAndReportScore:(int)topScore leaderboard:@"dragonRequest"  sortOrder:GameCenterSortOrderHighToLow];
            
            
            // Integerの保存
            [defaults setInteger:topScore forKey:@"TOPSCORE"];
            
        }
        
    }

    if(topScore<=score)topScore=score;
    scoreLabel.text = [NSString stringWithFormat:@"%zd/%zd",score,topScore];
    
    heroPowerLabel.text = [@((int)_hero.power) stringValue];

    
/*
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
        
        // スコアをNSUserDefaultsに配列で保存
        [scoreArray addObject:[NSString stringWithFormat:@"%ld", (long)score]];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:scoreArray];
        [defaults setObject:data forKey:@"SCORE_ARRAY"];
        [defaults synchronize];
        
        if(score>=topScore){
            topScore = score;
            scoreLabel.text = [@(score) stringValue];
            topScoreLabel.text = [@(topScore) stringValue];
            
            [[GameCenterManager sharedManager] saveAndReportScore:topScore leaderboard:@"dragonRequest"  sortOrder:GameCenterSortOrderHighToLow];
            
            
            // Integerの保存
            [defaults setInteger:topScore forKey:@"TOPSCORE"];
            
        }
        scoreLabel.text = [@(score) stringValue];
        
        [alart show];
        [_hero removeImage];
        clearflag = true;
        stagenumber++;
        if(stagenumber >= 4)
        {
            stagenumber = 1;
        }
    }
    

    if(heroaliveflag == false)
    {
 
        if(cnt % 10 == 0){
 
            if([_enemyBoss[i]  fight:_hero]){
 
                // Here we need to pass a full frame
                CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
                
                // Add some custom content to the alert view
                [alertView setContainerView:[self showAlertView]];
                
                // Modify the parameters
                [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Continue", @"Menu", nil]];
                [alertView setDelegate:self];
                
                // You may use a Block, rather than a delegate.
                [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
                    NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                    [alertView close];
                }];
                
                [alertView setUseMotionEffects:true];
                
                // And launch the dialog
                [alertView show];
                
                if(score>=topScore){
                    topScore = score;
                    scoreLabel.text = [@(score) stringValue];
                    topScoreLabel.text = [@(topScore) stringValue];
                    
                    
                }
                score = initMainScore;
                scoreLabel.text = [@(score) stringValue];
                
                stagenumber = 1;
                [_hero removeImage];
                heroaliveflag = true;
                break;
            }
        }
    }
    
    cnt++;
    
*/
    
}

//タイマーで設定した時間ごとにボスを生成
- (void)createEnemy{
    
    createCnt++;
    
    if(_enemyBossArray.count<ENEMY_MARINE_MAX && (createCnt % 10 == 0)){
    
        NSInteger tag = _enemyBossArray.count+1;
        EnemyBoss *enemyBoss = [[EnemyBoss alloc] init:CGPointZero
                                                   tag:tag];
        
        //EnemyBoss設定
        enemyBoss.alpha = 1.0;
        [enemyBoss setImage:self.view belowSubview:self.weaponCollectionView];
        [enemyBoss setEnemy:_hero];
        
        [_enemyBossArray addObject:enemyBoss];
        
        createCnt = 0;
    
    }
    else if(_enemyMarineArray.count<ENEMY_MARINE_MAX){
        
        NSInteger tag = _enemyMarineArray.count+ENEMY_MARINE_MAX+1;
        EnemyMarine *enemyMarine = [[EnemyMarine alloc] init:CGPointZero
                                                         tag:tag];
        
        //EnemyMarine設定
        enemyMarine.alpha = 1.0;
        [enemyMarine setImage:self.view belowSubview:self.weaponCollectionView];
        [enemyMarine setEnemy:_hero];
        
        [_enemyMarineArray addObject:enemyMarine];
        
    }
}

/** リセット */
- (void)startGame {
    
    clearmes = @"次のステージに進みます";
    int createtime = 0;
    score = 0;
    
    switch (stagenumber) {
        case 1:
            _fieldView.image = _utilManager.backgroundImage01;
            createtime = bossCreatetime1;
            break;
        case 2:
            _fieldView.image = _utilManager.backgroundImage02;
            createtime = bossCreatetime2;
            break;
        case 3:
            _fieldView.image = _utilManager.backgroundImage03;
            createtime = bossCreatetime3;
            clearmes = @"すべてのステージをクリアしました";
            break;
            
        default:
            break;
    }

    //マリン初期化
    [_enemyMarineArray removeAllObjects];
    
    //ボス初期化
    [_enemyBossArray removeAllObjects];
    
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake([common screenSizeWidth]/2, [common screenSizeHeight]/2);
    _hero = [[MyHero alloc]init:heroPos
                            tag:heroTagNumber];
    
    //hero イメージを設定
    [_hero setImage:self.view belowSubview:self.weaponCollectionView];

    //heroのx、y座標
    _xPos = _hero.position.x;
    _yPos = _hero.position.y;
    
    // 敵を倒した時の音を再生264981__renatalmar__sfx-magic
    // AudioPlayer初期化
    [_startSound stop];
    _startSound.currentTime = 0;
    [_startSound play];
    
    
    [self createEnemy];
    [self createEnemy];
    [self createEnemy];
    [self createEnemy];
    [self createEnemy];
    [self createEnemy];
    [self createEnemy];
    
    if(_storyTimer == nil){
        _storyTimer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(checkGameStory) userInfo:nil repeats:YES];
        [_storyTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:bossMoveTimeInterval]];
        
    }
    if(_createEnemyTimer == nil){
        _createEnemyTimer = [NSTimer scheduledTimerWithTimeInterval:bossCreatetime1 target:self selector:@selector(createEnemy) userInfo:nil repeats:YES];
        [_createEnemyTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:bossCreatetime1]];
        
    }

    if(![_storyTimer isValid]){
     
        [_storyTimer fire];
        
    }

    if(![_createEnemyTimer isValid]){
     
        [_createEnemyTimer fire];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameKit Delegate -----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameKit Delegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (gameCenterViewController.viewState == GKGameCenterViewControllerStateAchievements) {
//        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter achievements."];
    } else if (gameCenterViewController.viewState == GKGameCenterViewControllerStateLeaderboards) {
//        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter leaderboard."];
    } else {
//        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter controller."];
    }
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Manager Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Manager Delegate

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

- (void)gameCenterManager:(GameCenterManager *)manager availabilityChanged:(NSDictionary *)availabilityInformation {
    NSLog(@"GC Availabilty: %@", availabilityInformation);
    if ([[availabilityInformation objectForKey:@"status"] isEqualToString:@"GameCenter Available"]) {
        [self.navigationController.navigationBar setValue:@"GameCenter Available" forKeyPath:@"prompt"];
//        statusDetailLabel.text = @"Game Center is online, the current player is logged in, and this app is setup.";
    } else {
        [self.navigationController.navigationBar setValue:@"GameCenter Unavailable" forKeyPath:@"prompt"];
//        statusDetailLabel.text = [availabilityInformation objectForKey:@"error"];
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
//            actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
            playerNameLabel.text = player.displayName;
//            playerStatus.text = @"Player is not underage and is signed-in";
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
                gcPlayerPictureImage.image = playerPhoto;
            }];
        } else {
            playerNameLabel.text = player.displayName;
//            playerStatus.text = @"Player is underage";
//            actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
        }
    } else {
//        actionBarLabel.title = [NSString stringWithFormat:@"No GameCenter player found."];
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager error:(NSError *)error {
    NSLog(@"GCM Error: %@", error);
    //topScoreLabel.text = error.domain;
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedAchievement:(GKAchievement *)achievement withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Achievement: %@", achievement);
//        actionBarLabel.title = [NSString stringWithFormat:@"Reported achievement with %.1f percent completed", achievement.percentComplete];
    } else {
        NSLog(@"GCM Error while reporting achievement: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedScore:(GKScore *)score withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Score: %@", score);
//        actionBarLabel.title = [NSString stringWithFormat:@"Reported leaderboard score: %lld", score.value];
    } else {
        NSLog(@"GCM Error while reporting score: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveScore:(GKScore *)score {
    NSLog(@"Saved GCM Score with value: %lld", score.value);
//    actionBarLabel.title = [NSString stringWithFormat:@"Score saved for upload to GameCenter."];
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveAchievement:(GKAchievement *)achievement {
    NSLog(@"Saved GCM Achievement: %@", achievement);
//    actionBarLabel.title = [NSString stringWithFormat:@"Achievement saved for upload to GameCenter."];
}

//------------------------------------------------------------------------------------------------------------//
//------- CustomIOS7AlertView Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    
    if(buttonIndex==0){

        //敵イメージクリア
        for(EnemyMarine *enemyMarine in _enemyMarineArray){
            
            [enemyMarine removeImage];
        }
        
        for(EnemyBoss *enemyBoss in _enemyBossArray){
            
            [enemyBoss removeImage];
            
        }

        //_heroイメージクリア
        [_hero removeImage];
        
        [self startGame];
        
        [alertView close];

    }
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (UIView *)showAlertView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    [imageView setImage:[UIImage imageNamed:@"gamecenter.png"]];
    [demoView addSubview:imageView];
    
    return demoView;
}

@end
