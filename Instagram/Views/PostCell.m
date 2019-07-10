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
    self.postPFImageView.file = self.post[@"image"];
    [self.postPFImageView loadInBackground];
    
    self.postCaptionLabel.text = self.post[@"caption"];
    NSLog(@"%@", self.postCaptionLabel.text);
}

@end
