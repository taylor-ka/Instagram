//
//  ComposeViewController.m
//  Instagram
//
//  Created by taylorka on 7/8/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "ImagePickerManagerViewController.h"

@interface ComposeViewController () <ImagePickerManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tapPromptLabel;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) ImagePickerManagerViewController *imagePickerManager;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation ComposeViewController

#pragma mark - Loading and Set Up

- (void)viewDidLoad {
    // Super class sets up tap gesture recognizer, image picker
    [super viewDidLoad];
    
    [self setUpTextView];
    [self setUpPhotoWithTapRecognizer];
    
    // Set up image picker
    self.imagePickerManager = [[ImagePickerManagerViewController alloc] initWithSetUp];
    [self addChildViewController:self.imagePickerManager];
    self.imagePickerManager.delegate = self;
}

- (void)setUpTextView {
    self.captionTextView.layer.borderWidth = 1;
    self.captionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.captionTextView.layer.cornerRadius = 5;
    self.captionTextView.text = nil;
}

- (void)setUpPhotoWithTapRecognizer {
    // Image and tap prompt
    self.tapPromptLabel.hidden = NO;
    
    // Link tap gesture recognizer with image view
    UITapGestureRecognizer *photoTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onPhotoTap:)];
    [self.imageView addGestureRecognizer:photoTapGestureRecognizer];
    [self.imageView setUserInteractionEnabled:YES];
}

#pragma mark - Picking an image

- (void)onPhotoTap:(id)sender {
    [self.imagePickerManager showImagePicker];
}

- (void)didPickImage:(UIImage *)image {
    self.imageView.image = image;
    self.tapPromptLabel.hidden = YES;
}

#pragma mark - User actions

// Tap anywhere on screen to dismiss keyboard
- (IBAction)onScreenTap:(id)sender {
    // Dismiss key board
    [self.view endEditing:YES];
}

// Close button tapped
- (IBAction)onCloseTap:(id)sender {
    [self.delegate didTapClose];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Share button tapped
// TODO: error if blank
- (IBAction)onShareTap:(id)sender {
    // prevent double taps
    self.shareButton.userInteractionEnabled = NO;
    
    // Loading indicator
    [self.activityIndicator startAnimating];
    
    // Post image
    [Post postUserImage:self.imageView.image withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error posting: %@", error.localizedDescription);
            
        } else {
            NSLog(@"Successfully posted!");
            [self.delegate didComposePost];
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [self.activityIndicator stopAnimating];
        self.shareButton.userInteractionEnabled = YES;

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
