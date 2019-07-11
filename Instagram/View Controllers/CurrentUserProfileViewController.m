//
//  CurrentUserProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "CurrentUserProfileViewController.h"

@interface CurrentUserProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *editProfilePicButton;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;

@end

@implementation CurrentUserProfileViewController

- (void)viewDidLoad {
    self.user = [PFUser currentUser];
    [super viewDidLoad];
    [self setUpImagePicker];
}

#pragma mark - Image Picker
//TODO: REDUCE REDUNDANCY
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

- (IBAction)onEditProfilePicTap:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Both image source types are available
        [self pickImageWithSourceSelection];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        // Only camera is available
        [self pickImageWithCamera];
    } else {
        // Only photo library is available
        [self pickImageWithPhotoLibrary];
    }
    
}

- (void) pickImageWithCamera {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void) pickImageWithPhotoLibrary {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void) pickImageWithSourceSelection {
    // Create alert controller with actions
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle: UIAlertControllerStyleActionSheet];
    // Take photo
    [alertController addAction: [UIAlertAction actionWithTitle: @"Take Photo" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self pickImageWithCamera];
    }]];
    
    // Choose existing photo
    [alertController addAction: [UIAlertAction actionWithTitle: @"Choose Existing Photo" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self pickImageWithPhotoLibrary];
    }]];
    
    // Cancel
    [alertController addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    // Present as modal popover
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController: alertController animated: YES completion: nil];
}

// After user takes photo/ picks profile image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Update chosen profile picture
    self.profilePFImageView.image = editedImage;
    [self updateUserProfilePicture:editedImage];
    
    // Dismiss UIImagePickerController
    [self dismissViewControllerAnimated:NO completion:nil];
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
