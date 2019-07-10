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
@property (weak, nonatomic) IBOutlet UILabel *tapPromptLabel;

@property (strong, nonatomic)  UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ComposeViewController

#pragma mark - Loading and Set Up

- (void)viewDidLoad {
    // Super class sets up tap gesture recognizer, image picker
    [super viewDidLoad];
    
    // Set up text view
    self.captionTextView.layer.borderWidth = 1;
    self.captionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.captionTextView.layer.cornerRadius = 5;
    self.captionTextView.text = nil;
    
    [self setUpPhotoWithTapRecognizer];
    [self setUpImagePicker];
}

#pragma mark - Photo Tap

- (void)setUpPhotoWithTapRecognizer {
    // Image and tap prompt
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    self.tapPromptLabel.hidden = NO;
    
    // Link tap gesture recognizer with image view
    UITapGestureRecognizer *photoTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onPhotoTap:)];
    [self.imageView addGestureRecognizer:photoTapGestureRecognizer];
    [self.imageView setUserInteractionEnabled:YES];
    
}

- (void)onPhotoTap:(id)sender {
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    NSLog(@"Presented ComposeVC");
}

#pragma mark - Image Picker controller

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

// After user takes photo/ picks image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.imageView.image = editedImage;
    self.tapPromptLabel.hidden = YES;
    
    // Dismiss UIImagePickerController
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - User actions

// Tap anywhere on screen to dismiss keyboard
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
