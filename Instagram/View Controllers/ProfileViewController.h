//
//  ProfileViewController.h
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFUser *user;
@property (weak, nonatomic) IBOutlet PFImageView *profilePFImageView;

@end

NS_ASSUME_NONNULL_END
