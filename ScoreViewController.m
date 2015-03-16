//
//  ScoreViewController.m
//  DragonRequest
//
//  Created by 柴田　義也 on 2015/03/16.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end


enum {
    Number1 = 1,
    Number2,
    Number3
};


@implementation ScoreViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int num1 = 0;
    int num2 = 0;
    int num3 = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"SCORE_ARRAY"];
    NSMutableArray *scoreArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    for (NSString *numStr in scoreArray) {
        NSLog(@"スコア : %@", numStr);
        int score = [numStr intValue];
        if (num1 <= score) {
            num3 = num2;
            num2 = num3;
            num1 = score;
        } else if (num2 <= score) {
            num3 = num2;
            num2 = score;
        } else if (num3 <= score) {
            num3 = score;
        }
    }
    
    UILabel *label1 = (UILabel *)[self.view viewWithTag:Number1];
    label1.text = [NSString stringWithFormat:@"1 : %d", num1];
    UILabel *label2 = (UILabel *)[self.view viewWithTag:Number2];
    label2.text = [NSString stringWithFormat:@"2 : %d", num2];
    UILabel *label3 = (UILabel *)[self.view viewWithTag:Number3];
    label3.text = [NSString stringWithFormat:@"3 : %d", num3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
