//
//  ImagePickerManager.m
//  Instagram
//
//  Created by taylorka on 7/11/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ImagePickerManager.h"
#import "UIImagePickerController.h"


@interface ImagePickerManager

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;

@end


@implementation ImagePickerManager

#pragma mark - Public methods

- (instancetype) initWithSetup {
    self = [super init];
    if (self) {
        [self setUpImagePicker];
    }
    return self;
}

- (void) showImagePicker {
    
}

#pragma mark - Private methods

- (void)setUpImagePicker {
    // Set up image picker
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    // Check if camera is available
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

@end
