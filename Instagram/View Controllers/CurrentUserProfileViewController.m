//
//  CurrentUserProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "CurrentUserProfileViewController.h"
#import "ImagePickerManagerViewController.h"

@interface CurrentUserProfileViewController () <ImagePickerManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *editProfilePicButton;
@property (strong, nonatomic) ImagePickerManagerViewController *imagePickerManager;

@end

@implementation CurrentUserProfileViewController

- (void)viewDidLoad {
    self.user = [PFUser currentUser];
    [super viewDidLoad];
    
    // Set up image picker
    self.imagePickerManager = [[ImagePickerManagerViewController alloc] initWithSetUp];
    [self addChildViewController:self.imagePickerManager];
    self.imagePickerManager.delegate = self;
}

#pragma mark - Image picking

- (IBAction)onEditProfilePicTap:(id)sender {
    [self.imagePickerManager showImagePicker];
}

- (void)didPickImage:(nonnull UIImage *)image {
    // Update chosen profile picture
    [self dismissViewControllerAnimated:YES completion:nil];
    self.profilePFImageView.image = image;
    [self updateUserProfilePicture:image];
}

#pragma mark - Update user settings

- (void)updateUserProfilePicture:(UIImage*)image {
    PFFileObject *picFile = [CurrentUserProfileViewController getPFFileFromImage:image];
    [self.user setObject: picFile forKey:@"profilePic"];
    [self.user saveInBackground];
}

//TODO: reduce redundancy here
// create file object from image
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    // return object with image
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
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
