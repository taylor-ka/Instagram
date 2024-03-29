//
//  FeedViewController.m
//  Instagram
//
//  Created by taylorka on 7/8/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

#import "FeedViewController.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"
#import "DetailsViewController.h"

#import "Post.h"
#import "PostCell.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation FeedViewController

#pragma mark - Loading

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up activity indicator
    [self.activityIndicator startAnimating];
    
    // Set up table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.posts = [[NSMutableArray alloc] init];
    
    // Set up refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self fetchPosts];
}

- (void)fetchPosts {
    // Create query for 20 most recent tweets
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"likeCount"];
    postQuery.limit = 20;
    
    // Fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable postsArray, NSError * _Nullable error) {
        if (postsArray) {
            self.posts = [NSMutableArray arrayWithArray:postsArray];
            [self.tableView reloadData];
            NSLog(@"Posts fetched");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
    }];
}

#pragma mark - Buttons

- (IBAction)onLogoutTap:(id)sender {
    // Log out user
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        //TODO: code in case of error
        if (error) {
            NSLog(@"Error logging out: %@", error.localizedDescription);
        }
    }];
    
    // Return to login screen
    // Get single instance of app delegate
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // Create new instance of storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Create new instance of login view controller using identifier
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    // Set root view controller to swich views
    appDelegate.window.rootViewController = loginViewController;
}

#pragma mark - Table View

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.post = self.posts[indexPath.row];
    [cell setUpPostCell];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Row will only be selected when user clicks
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        /*
        // Segue to details view of post
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        DetailsViewController *detailsVC = [segue destinationViewController];
        detailsVC.post = self.posts[indexPath.row];
         */
        
        // Segue to user profile
        NSLog(@"Trying to segue to user");
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        UINavigationController *navigationController = [segue destinationViewController];
        ProfileViewController *profileVC = (ProfileViewController*)[navigationController topViewController];
        Post *post = self.posts[indexPath.row];
        profileVC.user = post.author;
        profileVC.title = post.author.username;
}







@end
