//
//  PostViewController.m
//  Instagram
//
//  Created by taylorka on 7/11/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "PostViewController.h"
#import "ComposeViewController.h"

@interface PostViewController () <PostComposedDelegate>

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"segue");
    [self performSegueWithIdentifier:@"composeSegue" sender:nil];
}

- (void)didComposePost {
    [self didTapClose];
}

- (void)didTapClose {
    [self.parentViewController.tabBarController setSelectedIndex:0];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ComposeViewController *composeVC = [segue destinationViewController];
    composeVC.delegate = self;
}


@end
