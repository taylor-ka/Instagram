//
//  DetailsViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "DetailsViewController.h"
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"
#import "NSDate+DateTools.h"


@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *profilePFImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postPFImageView;

@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

// Liking
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end

@implementation DetailsViewController


// TODO: REDUCE REDUNDANCY!!
- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameLabel.text = self.post.author.username;
    self.postCaptionLabel.text = self.post.caption;
    self.timeStampLabel.text = self.post.createdAt.timeAgoSinceNow;
    
    // Set up post image
    self.postPFImageView.file = self.post.image;
    [self.postPFImageView loadInBackground];
    
    [self setUpProfilePicture];
    [self setUpLikeStatus];
}

- (void) setUpProfilePicture {
    // Make profile picture circular
    self.profilePFImageView.layer.cornerRadius = self.profilePFImageView.frame.size.width / 2;
    self.profilePFImageView.clipsToBounds = true;
    
    // Set up profile picture
    self.profilePFImageView.file = self.post.author[@"profilePic"];
    [self.profilePFImageView loadInBackground];
}

- (void)setUpLikeStatus {
    if ([self.post.likeCount isEqualToNumber:@(0)]) {
        [self.likeButton setImage:[UIImage imageNamed:@"heartOutline"] forState:UIControlStateNormal];
        self.likeLabel.text = @"0 likes";
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"heartRed"] forState:UIControlStateNormal];
        self.likeLabel.text = @"1 like";
    }
}

- (IBAction)onLikeTap:(id)sender {
    if ([self.post.likeCount isEqualToNumber:@(0)]) {
        // Like post
        [self.likeButton setImage:[UIImage imageNamed:@"heartRed"] forState:UIControlStateNormal];
        self.likeLabel.text = @"1 like";
        self.post.likeCount = @(1);
        [self.post saveInBackground];
    } else {
        // Unlike post
        [self.likeButton setImage:[UIImage imageNamed:@"heartOutline"] forState:UIControlStateNormal];
        self.likeLabel.text = @"0 likes";
        self.post.likeCount = @(0);
        [self.post saveInBackground];
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
