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

@interface PostCell ()

// Header
@property (weak, nonatomic) IBOutlet PFImageView *profilePFImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

// Post
@property (weak, nonatomic) IBOutlet PFImageView *postPFImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;


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
    // Set up header
    self.usernameLabel.text = self.post.author.username;
    
    // Reduce flicker
    self.profilePFImageView.image = nil;
    self.postPFImageView.image = nil;
    
    // Make profile picture circular
    self.profilePFImageView.layer.cornerRadius = self.profilePFImageView.frame.size.width / 2;
    self.profilePFImageView.clipsToBounds = true;
    self.profilePFImageView.alpha = 0.0;
    
    // Set up profile picture
    PFFileObject *profilePicFile = self.post.author[@"profilePic"];
    if (profilePicFile) { // User has profile picture
        self.profilePFImageView.file = profilePicFile;
        [self.profilePFImageView loadInBackground];
    }
    
    // Set up post image
    self.postPFImageView.file = self.post.image;
    self.postPFImageView.alpha = 0.0;
    [self.postPFImageView loadInBackground];
    
    // Fade in profile pic and post
    [UIView animateWithDuration:0.5 animations:^{
        self.postPFImageView.alpha = 1.0;
        self.profilePFImageView.alpha = 1.0;
    }];
    
    // Set up caption
    self.postCaptionLabel.text = self.post.caption;
}

@end
