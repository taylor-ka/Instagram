//
//  ImagePickerManagerViewController.h
//  Instagram
//
//  Created by taylorka on 7/11/19.
//  Copyright © 2019 taylorka. All rights reserved.
//
// Image Picker Manager displays an image picker with the option to choose photo source.
// It should never be displayed, only added as a child view controller

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImagePickerManagerDelegate

- (void) didPickImage:(UIImage *)image;

@end

@interface ImagePickerManagerViewController : UIViewController

@property (weak, nonatomic) id<ImagePickerManagerDelegate> delegate;

- (instancetype) initWithSetUp;
- (void)showImagePicker;

@end

NS_ASSUME_NONNULL_END
