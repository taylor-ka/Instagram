//
//  TapAndPickImageViewController.h
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//
//  This class manages a imageView with a prompt to tap, which will then pull up and image picker.

// This class is abstract and should be subclassed.
// The subclass should set the prompt text and implement what happens after an image is picked.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TapAndPickImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic)  UIImagePickerController *imagePickerVC;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tapPromptLabel;


// Resize image
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
