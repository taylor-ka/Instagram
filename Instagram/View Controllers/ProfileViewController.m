//
//  ProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/PFImageView.h>

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Reduce flicker
    self.profilePFImageView.image = nil;
    
    self.navigationItem.title = self.user.username;
    
    // Make profile picture circular
    self.profilePFImageView.layer.cornerRadius = self.profilePFImageView.frame.size.width / 2;
    self.profilePFImageView.clipsToBounds = true;
    
    // Set up profile picture
    PFFileObject *profilePicFile = self.user[@"profilePic"];
    if (profilePicFile) { // User has profile picture
        self.profilePFImageView.file = profilePicFile;
        [self.profilePFImageView loadInBackground];
    }
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
