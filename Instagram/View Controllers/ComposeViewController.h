//
//  ComposeViewController.h
//  Instagram
//
//  Created by taylorka on 7/8/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostComposedDelegate

// TODO: figure out how to pass back new post so don't to have make api call
//- (void) didComposePost:(Post*)post;
- (void) fetchPosts;

@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) id<PostComposedDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
