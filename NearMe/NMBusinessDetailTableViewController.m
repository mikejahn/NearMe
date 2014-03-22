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
#import "NMUtilities.h"

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
        return [self createHeaderCellWithTableView:tableView andIndexPath:indexPath];
    } else {
        return [self createReviewCellWithTableView:tableView andIndexPath:indexPath];
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

#pragma mark - UIButton actions
-(void)phoneNumberTapped
{
    NSString *phoneAction = [NSString stringWithFormat:@"tel:%@", self.business.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneAction]];
}

#pragma mark - Create cell methods
-(NMReviewHeaderCell *)createHeaderCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
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
}

-(NMReviewTableViewCell *)createReviewCellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark - configure header cell
- (void)configureHeaderCell:(NMReviewHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView
{
    [cell configureBusinessImagewithBusiness:self.business];
    [cell configureRatingImagewithBusiness:self.business];
    [cell configureAddresswithBusiness:self.business];
    [cell configureStatewithBusiness:self.business];
    [cell configureCitywithBusiness:self.business];
    [cell configureCategorywithBusiness:self.business];
    [cell configurePhoneNumberwithBusiness:self.business];
    [cell.phoneNumberButton addTarget:self action:@selector(phoneNumberTapped) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - configure review cell
- (void)configureReviewCell:(NMReviewTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView
{
    NMReview *review = [self.business.reviews objectAtIndex:indexPath.row];
    [cell configureUserImagewithReview:review];
    [cell configureUserLabelwithReview:review];
    [cell configureRatingImagewithReview:review];
    [cell configureExcerptwithReview:review];
}

@end
