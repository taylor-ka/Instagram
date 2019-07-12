//
//  PostCell.m
//  Instagram
//
//  Created by taylorka on 7/9/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "PostCell.h"
#import <Parse/PFCollectionViewCell.h>
#import <Parse/PFImageView.h>
#import "NSDate+DateTools.h"
#import "ProfileViewController.h"

@interface PostCell ()

// Header
@property (weak, nonatomic) IBOutlet PFImageView *profilePFImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

// Post
@property (weak, nonatomic) IBOutlet PFImageView *postPFImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

// Likes
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setUpPostCell {
    // Set up labels
    self.usernameLabel.text = self.post.author.username;
    self.postCaptionLabel.text = self.post.caption;
    self.timeStampLabel.text = self.post.createdAt.timeAgoSinceNow;
    
    [self setUpImages];
    [self setUpLikeStatus];
    
    // Fade in profile pic and post
    [UIView animateWithDuration:0.5 animations:^{
        self.postPFImageView.alpha = 1.0;
        self.profilePFImageView.alpha = 1.0;
    }];
    
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

- (void)setUpImages {
    // Reduce flicker
    self.profilePFImageView.image = nil;
    self.profilePFImageView.alpha = 0.0;
    self.postPFImageView.image = nil;
    self.postPFImageView.alpha = 0.0;
    
    // Make profile picture circular
    self.profilePFImageView.layer.cornerRadius = self.profilePFImageView.frame.size.width / 2;
    self.profilePFImageView.clipsToBounds = true;
    
    // Set up profile picture
    self.profilePFImageView.file = self.post.author[@"profilePic"];
    [self.profilePFImageView loadInBackground];
    
    // Set up post image
    self.postPFImageView.file = self.post.image;
    [self.postPFImageView loadInBackground];
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

@end
