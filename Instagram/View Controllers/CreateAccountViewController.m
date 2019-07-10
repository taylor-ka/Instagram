//
//  CreateAccountViewController.m
//  Instagram
//
//  Created by taylorka on 7/8/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "Parse/Parse.h"

@interface CreateAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onSignUpTap:(id)sender {
    // TODO: verify passwords are the same
    
    // Register user
    // Initialize user object
    PFUser *newUser = [PFUser user];
    
    // Set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    newUser.email = self.emailField.text;
    
    // Set default user profile picture
    PFFileObject *picFile = [CreateAccountViewController getPFFileFromImage: [UIImage imageNamed:@"defaultProfilePic"]];
    [newUser setObject: picFile forKey:@"profilePic"];
    
    // Call sign up function
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            // TODO: error message for user - unsuccessful account sign in
        } else {
            NSLog(@"User registered successfully");
            
            // TODO: Segue to main feed OR log in screen (have user relogin?)
            [self performSegueWithIdentifier:@"accountCreatedSegue" sender:self];
        }
    }];
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
                             
                             

- (IBAction)onCloseTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
