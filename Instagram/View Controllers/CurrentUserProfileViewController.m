//
//  CurrentUserProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "CurrentUserProfileViewController.h"

@interface CurrentUserProfileViewController ()

@property (weak, nonatomic) IBOutlet UIButton *editProfilePicButton;

@end

@implementation CurrentUserProfileViewController

- (void)viewDidLoad {
    self.user = [PFUser currentUser];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)updateUserProfilePicture:(UIImage*)image {
    
    PFFileObject *picFile = [CurrentUserProfileViewController getPFFileFromImage:image];
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
