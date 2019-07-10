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
    NSLog(@"finished picking");
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
