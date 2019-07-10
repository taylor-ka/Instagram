//
//  TapAndPickImageViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//
//  This class manages a imageView with a prompt to tap, which will then pull up and image picker.

// This class is abstract and should be subclassed.
// The subclass should set the prompt text and implement what happens after an image is picked.

#import "TapAndPickImageViewController.h"

@interface TapAndPickImageViewController ()


@end

@implementation TapAndPickImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpPhotoWithTapRecognizer];
    
    [self setUpImagePicker];
}

- (void)setUpPhotoWithTapRecognizer {
    // Image and tap prompt
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    self.tapPromptLabel.hidden = NO;
    
    // Link tap gesture recognizer with image view
    UITapGestureRecognizer *photoTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onPhotoTap:)];
    [self.imageView addGestureRecognizer:photoTapGestureRecognizer];
    [self.imageView setUserInteractionEnabled:YES];
}

- (void)setUpImagePicker {
    // Set up image picker
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    // Check if camera is available
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void)onPhotoTap:(id)sender {
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    NSLog(@"Presented ComposeVC");
}

// Subclass must override this method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"You must override this method in a subclass"
                                 userInfo:nil];
}

// Resize image - 10 MB limit to upload
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
