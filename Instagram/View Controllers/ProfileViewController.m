//
//  ProfileViewController.m
//  Instagram
//
//  Created by taylorka on 7/10/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/PFImageView.h>
#import "Post.h"
#import "PostCollectionViewCell.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollisionBehaviorDelegate>

@property (strong, nonatomic) NSArray *userPosts;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ProfileViewController

#pragma mark - Displaying view

- (void)viewDidLoad {
    [super viewDidLoad];
    // Reduce flicker
    self.profilePFImageView.image = nil;
    
    self.navigationItem.title = self.user.username;
    
    // Make profile picture circular
    self.profilePFImageView.layer.cornerRadius = self.profilePFImageView.frame.size.width / 2;
    self.profilePFImageView.clipsToBounds = true;
    
    // Set up profile picture
    PFFileObject *profilePicFile = self.user[@"profilePic"];
    if (profilePicFile) { // User has profile picture
        self.profilePFImageView.file = profilePicFile;
        [self.profilePFImageView loadInBackground];
    }
    
    [self setUpCollectionView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self fetchUserPosts];
}

#pragma mark - Fetching Data

- (void)fetchUserPosts {
    // Create query for 20 most recent tweets
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery whereKey:@"author" equalTo:self.user];

    // Fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable postsArray, NSError * _Nullable error) {
        if (postsArray) {
            self.userPosts = [NSMutableArray arrayWithArray:postsArray];
            [self.collectionView reloadData];
            NSLog(@"User posts fetched");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Collection View
- (void) setUpCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // Set up layout of collection view
    // Two movies per row with border in between
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postsPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postsPerLine - 1)) / postsPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    PostCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    cell.postPFImageView.alpha = 0.0;
    
    // Load post image
    Post *post = self.userPosts[indexPath.row];
    cell.postPFImageView.file = post.image;
    [cell.postPFImageView loadInBackground];
    
    // Fade in
    [UIView animateWithDuration:0.5 animations:^{
        cell.postPFImageView.alpha = 1.0;
    }];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return self.userPosts.count;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
