//
//  TapAndPickImageViewController.h
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TapAndPickImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic)  UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *tapPromptLabel;

@end

NS_ASSUME_NONNULL_END
