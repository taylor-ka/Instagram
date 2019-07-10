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

@property (strong, nonatomic)  UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *tapPromptLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpPhotoWithTapRecognizer];
    
    // Set up text view
    self.captionTextView.layer.borderWidth = 1;
    self.captionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.captionTextView.layer.cornerRadius = 5;
    self.captionTextView.text = nil;
    
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
    // Loading indicator
    [self.activityIndicator startAnimating];
    
    [Post postUserImage:self.imageView.image withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error posting: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully posted!");
            [self.delegate fetchPosts];
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [self.activityIndicator stopAnimating];
    }];
}

// After user takes photo/ picks image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.imageView.image = editedImage;
    self.tapPromptLabel.hidden = YES;
    
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
