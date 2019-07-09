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
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
