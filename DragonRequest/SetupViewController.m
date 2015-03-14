//
//  SetupViewController.m
//  DragonRequest
//
//  Created by msjune on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSInteger backgroundType;
    
}
@property (retain, nonatomic) UIImagePickerController *imgPicker;
@property (weak, nonatomic) IBOutlet UIButton *pickupButton1;
@property (weak, nonatomic) IBOutlet UIButton *pickupButton2;
@property (weak, nonatomic) IBOutlet UIButton *pickupButton3;

@end


@implementation SetupViewController

@synthesize imgPicker;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    backgroundType = 0;
    
    [self.pickupButton1 setBackgroundImage:[UIImage imageNamed:@"mapbg01.png"] forState:UIControlStateNormal];
    [self.pickupButton2 setBackgroundImage:[UIImage imageNamed:@"mapbg02.png"] forState:UIControlStateNormal];
    [self.pickupButton3 setBackgroundImage:[UIImage imageNamed:@"mapbg04.png"] forState:UIControlStateNormal];
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}
- (IBAction)pickupBackgroundImage01:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        backgroundType = 1;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setAllowsEditing:YES];
        [imagePickerController setDelegate:self];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
- (IBAction)pickupBackgroundImage02:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        backgroundType = 2;
        
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setAllowsEditing:YES];
        [imagePickerController setDelegate:self];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
- (IBAction)pickupBackgroundImage03:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        backgroundType = 3;
        
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePickerController setAllowsEditing:YES];
        [imagePickerController setDelegate:self];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

//画像が選択された時に呼ばれるデリゲートメソッド
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //画像が選択されたとき。オリジナル画像をUIImageViewに突っ込む
    UIImage *origImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (origImage) {
        
        if(backgroundType==1)
            [self.pickupButton1 setBackgroundImage:origImage forState:UIControlStateNormal];
        else if(backgroundType==2)
            [self.pickupButton2 setBackgroundImage:origImage forState:UIControlStateNormal];
        else if(backgroundType==3)
            [self.pickupButton3 setBackgroundImage:origImage forState:UIControlStateNormal];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
