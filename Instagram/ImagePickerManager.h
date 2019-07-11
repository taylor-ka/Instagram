//
//  ImagePickerManager.h
//  Instagram
//
//  Created by taylorka on 7/11/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImagePickerManagerDelegate

- (void) imagePicked;

@end

@interface ImagePickerManager : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (instancetype) initWithSetup;
- (void) showImagePicker;

@end

NS_ASSUME_NONNULL_END
