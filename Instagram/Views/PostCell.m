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
    // Set up image with fade in
    self.postPFImageView.file = self.post[@"image"];
    self.postPFImageView.alpha = 0.0;
    [self.postPFImageView loadInBackground];
    [UIView animateWithDuration:0.5 animations:^{
        self.postPFImageView.alpha = 1.0;
    }];
    
    // Set up caption
    self.postCaptionLabel.text = self.post[@"caption"];
}

@end
