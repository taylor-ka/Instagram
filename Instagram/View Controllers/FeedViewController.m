//
//  FeedViewController.m
//  Instagram
//
//  Created by taylorka on 7/8/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "FeedViewController.h"
#import "LoginViewController.h"

@interface FeedViewController ()

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome %@!", PFUser.currentUser.username];
}

- (IBAction)onLogoutTap:(id)sender {
    // Log out user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // TODO: code in case of error
        NSLog(@"Error logging out: %@", error.localizedDescription);
    }];
    
    // Return to login screen
    // Get single instance of app delegate
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // Create new instance of storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Create new instance of login view controller using identifier
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    // Set root view controller to swich views
    appDelegate.window.rootViewController = loginViewController;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    // TODO: Save image to post
    
    // Dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onCameraTap:(id)sender {
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
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
