//
//  PostCell.h
//  Instagram
//
//  Created by taylorka on 7/9/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;

- (void) setUpPostCell;

@end

NS_ASSUME_NONNULL_END
