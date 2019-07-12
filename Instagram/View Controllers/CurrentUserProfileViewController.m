//
//  CurrentUserProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "CurrentUserProfileViewController.h"
#import "ImagePickerManagerViewController.h"
#import "Post.h"

@interface CurrentUserProfileViewController () <ImagePickerManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *editProfilePicButton;
@property (strong, nonatomic) ImagePickerManagerViewController *imagePickerManager;

@end

@implementation CurrentUserProfileViewController

#pragma mark - Loading

- (void)viewDidLoad {
    self.user = [PFUser currentUser];
    [super viewDidLoad];
    
    // Set up image picker
    self.imagePickerManager = [[ImagePickerManagerViewController alloc] initWithSetUp];
    [self addChildViewController:self.imagePickerManager];
    self.imagePickerManager.delegate = self;
}

#pragma mark - Image Picking

- (IBAction)onEditProfilePicTap:(id)sender {
    [self.imagePickerManager showImagePicker];
}

- (void)didPickImage:(nonnull UIImage *)image {
    // Update chosen profile picture
    self.profilePFImageView.image = image;
    [self updateUserProfilePicture:image];
}

#pragma mark - Update user settings

- (void)updateUserProfilePicture:(UIImage*)image {
    PFFileObject *picFile = [Post getPFFileFromImage:image];
    [self.user setObject: picFile forKey:@"profilePic"];
    [self.user saveInBackground];
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
