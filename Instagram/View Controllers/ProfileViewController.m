//
//  ProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [PFUser currentUser].username;
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    self.tapPromptLabel.text = @"Tap to select profile photo";
}

// override
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
        // Get the image captured by the UIImagePickerController
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        
        self.imageView.image = editedImage;
        self.tapPromptLabel.hidden = YES;
        
        // Dismiss UIImagePickerController
        [self dismissViewControllerAnimated:NO completion:nil];
    
        // Upload user profile
        PFUser *user = [PFUser currentUser];
    PFFileObject *picFile = [self getPFFileFromImage:self.imageView.image];
    [user setObject: picFile forKey:@"profilePic"];
        [user saveInBackground];
}

//TODO: reduce redundancy here
// create file object from image
- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
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
