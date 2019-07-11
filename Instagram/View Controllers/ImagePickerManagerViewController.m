//
//  ImagePickerManagerViewController.m
//  Instagram
//
//  Created by taylorka on 7/11/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ImagePickerManagerViewController.h"

@interface ImagePickerManagerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;

@end

@implementation ImagePickerManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype) initWithSetUp {
    self = [super init];
    if (self) {
        [self setUpImagePicker];
    }
    return self;
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

- (void)showImagePicker {
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
    [self.parentViewController presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void) pickImageWithPhotoLibrary {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.parentViewController presentViewController:self.imagePickerVC animated:YES completion:nil];
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
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    // Present as modal popover
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    [self.parentViewController presentViewController: alertController animated: YES completion: nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    [self.delegate didPickImage:editedImage];
    
    // Dismiss UIImagePickerController
    [self.parentViewController dismissViewControllerAnimated:NO completion:nil];
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
