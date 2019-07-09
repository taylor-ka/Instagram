//
//  Post.m
//  Instagram
//
//  Created by taylorka on 7/9/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "Post.h"

@implementation Post

// TODO: why are we usign @dynamic?
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (NSString *)parseClassName {
    return @"Post";
}

+ (void)postUserImage:(UIImage *)image withCaption:(NSString *)caption withCompletion:(PFBooleanResultBlock)completion {
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];

}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    // TODO: working on PFFile
    //return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
