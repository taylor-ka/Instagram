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

@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ComposeViewController

#pragma mark - Loading

- (void)viewDidLoad {
    // Super class sets up tap gesture recognizer, image picker
    [super viewDidLoad];
    
    // Set up text view
    self.captionTextView.layer.borderWidth = 1;
    self.captionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.captionTextView.layer.cornerRadius = 5;
    self.captionTextView.text = nil;
}

// Tap anywhere on screen to dismiss keyboard
- (IBAction)onScreenTap:(id)sender {
    // Dismiss key board
    [self.view endEditing:YES];
}

#pragma mark - Buttons

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

// @override
// After user takes photo/ picks image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.imageView.image = editedImage;
    self.tapPromptLabel.hidden = YES;
    
    // Dismiss UIImagePickerController
    [self dismissViewControllerAnimated:NO completion:nil];
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
