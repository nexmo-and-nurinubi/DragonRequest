//
//  SetupViewController.m
//  DragonRequest
//
//  Created by msjune on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SetupViewController.h"
#import "DrUtil.h"

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
    
    UIImage *bgImage = nil;
    DrUtil *utilManager = [DrUtil sharedInstance];
    
    bgImage = utilManager.backgroundImage01;
    [self.pickupButton1 setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    bgImage = utilManager.backgroundImage02;
    [self.pickupButton2 setBackgroundImage:bgImage forState:UIControlStateNormal];
    
    bgImage = utilManager.backgroundImage03;
    [self.pickupButton3 setBackgroundImage:bgImage forState:UIControlStateNormal];

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

    DrUtil *utilManager = [DrUtil sharedInstance];
    
    if (origImage) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        if(backgroundType==1){
            
            utilManager.backgroundImage01 = origImage;
            [self.pickupButton1 setBackgroundImage:origImage forState:UIControlStateNormal];
            
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:bgFileName01];
            BOOL ret = [UIImagePNGRepresentation(origImage) writeToFile:filePath atomically:YES];
            
            NSLog(@"bgFileName01:%@",(ret?@"success":@"fail"));
            
        }
        else if(backgroundType==2){
            
            utilManager.backgroundImage02 = origImage;
            [self.pickupButton2 setBackgroundImage:origImage forState:UIControlStateNormal];

            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:bgFileName02];
            BOOL ret = [UIImagePNGRepresentation(origImage) writeToFile:filePath atomically:YES];
            
            NSLog(@"bgFileName02:%@",(ret?@"success":@"fail"));

        }
        else if(backgroundType==3){
            
            utilManager.backgroundImage03 = origImage;
            [self.pickupButton3 setBackgroundImage:origImage forState:UIControlStateNormal];

            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:bgFileName03];
            BOOL ret = [UIImagePNGRepresentation(origImage) writeToFile:filePath atomically:YES];
            
            NSLog(@"bgFileName03:%@",(ret?@"success":@"fail"));

        }
        
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

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
