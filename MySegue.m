//
//  MySegue.m
//  DragonRequest
//
//  Created by 柴田　義也 on 2015/03/15.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "MySegue.h"

@implementation MySegue


- (void)perform
{
    // 遷移元と遷移先のViewControllerの生成
    UIViewController *sourceViewController = (UIViewController *)self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *)self.destinationViewController;
    
    
    // アニメーションの設定
    destinationViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    // modal繊維
    [sourceViewController presentViewController:destinationViewController animated:YES completion:nil];
}


@end
