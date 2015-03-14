//
//  SetupViewController.m
//  DragonRequest
//
//  Created by msjune on 2015/03/07.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgPreviewImageView;
@property (retain, nonatomic) UIImagePickerController *imgPicker;

@end


@implementation SetupViewController

@synthesize imgPicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}
- (IBAction)pickupBackgroundImage:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
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
        [self.bgPreviewImageView setImage:origImage];
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
