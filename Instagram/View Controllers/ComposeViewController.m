//
//  ComposeViewController.m
//  Instagram
//
//  Created by taylorka on 7/8/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Image
    self.imageView.image = nil;
    
    // Text view
    self.captionTextView.layer.borderWidth = 1;
    self.captionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.captionTextView.layer.cornerRadius = 5;
    self.captionTextView.text = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    // If image hasn't been picked yet
    if (!self.imageView.image) {
        // Set up image picker
        UIImagePickerController *imagePickerVC = [UIImagePickerController new];
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = YES;
        
        // Check if camera is available
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        NSLog(@"Presented ComposeVC");
    }
}

// Tap anywhere on screen
- (IBAction)onScreenTap:(id)sender {
    // Dismiss key board
    [self.view endEditing:YES];
}

// Close button tapped
- (IBAction)onCloseTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Share button tapped
- (IBAction)onShareTap:(id)sender {
    [Post postUserImage:self.imageView.image withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error posting: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully posted!");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

// After user takes photo/ picks image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // TODO: Save image to post
    self.imageView.image = editedImage;
    
    // Dismiss UIImagePickerController
    [self dismissViewControllerAnimated:NO completion:nil];
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
