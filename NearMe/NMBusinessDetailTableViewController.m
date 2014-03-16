//
//  NMBusinessDetailTableViewController.m
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMBusinessDetailTableViewController.h"
#import "NMReviewTableViewCell.h"
#import "NMReview.h"
#import <AFNetworking/AFNetworking.h>
#import "NMReviewHeaderCell.h"
#import "NMCategory.h"

@interface NMBusinessDetailTableViewController ()

@end

@implementation NMBusinessDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = self.business.name;
}

#pragma mark - Table view data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *headerIdentifier = @"ReviewHeaderCell";
        NMReviewHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        if (headerCell == nil)
        {
            headerCell = [[NMReviewHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:headerIdentifier];
        }
        [self configureHeaderCell:headerCell atIndexPath:indexPath withTableView:tableView];
        return headerCell;
    } else {
        static NSString *reviewIdentifier = @"ReviewCell";
        NMReviewTableViewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:reviewIdentifier];
        if (reviewCell == nil)
        {
            reviewCell = [[NMReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:reviewIdentifier];
        }
        [self configureReviewCell:reviewCell atIndexPath:indexPath withTableView:tableView];
        return reviewCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.section == 0)
   {
       return 150;
   } else {
       return 200;
   }
}

#pragma mark - UIButton action
-(void)call
{
    NSString *phoneAction = [NSString stringWithFormat:@"tel:%@", self.business.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneAction]];
}

#pragma mark - Configure Cell Methods
- (void)configureHeaderCell:(NMReviewHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView
{
    NSURL *url = [[NSURL alloc] initWithString:self.business.photo_url];
    [cell.businessImage setImageWithURL:url];
    
    CALayer * l = [cell.businessImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:3.0];
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor grayColor] CGColor]];
    
    NSURL *ratingImageURL = [[NSURL alloc] initWithString:self.business.rating_img_url];
    [cell.ratingImageView setImageWithURL:ratingImageURL];
    
    [cell.address1Label setText:self.business.address1];
    [cell.stateLabel setText:self.business.state];
    [cell.cityLabel setText:self.business.city];
    NMCategory *category = [self.business.categories objectAtIndex:0];
    [cell.categoryLabel setText:category.name];
    [cell.phoneNumberButton setTitle:self.business.phone forState:UIControlStateNormal];
    
    [cell.phoneNumberButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureReviewCell:(NMReviewTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView
{
    NMReview *review = [self.business.reviews objectAtIndex:indexPath.row];
    
    [cell.userLabel setText:review.user_name];
    NSURL *userPhotoUrl = [[NSURL alloc] initWithString:review.user_photo_url_small];
    [cell.userThumbnailImageView setImageWithURL:userPhotoUrl];
    CALayer * l = [cell.userThumbnailImageView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:2.0];
    NSURL *reviewPhotoUrl = [[NSURL alloc] initWithString:review.rating_img_url_small];
    [cell.reviewImageView setImageWithURL:reviewPhotoUrl];
    [cell.reviewTextView setText:review.text_excerpt];
}




@end
