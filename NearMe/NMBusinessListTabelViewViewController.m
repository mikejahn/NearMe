//
//  NMBusinessListTabelViewViewController.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMBusinessListTabelViewViewController.h"
#import "NMBusinessListViewTableCell.h"
#import "NMAPIClient.h"
#import "NMBusinessReviewSearch.h"
#import "NMBusiness.h"
#import <AKLocationManager/AKLocationManager.h>
#import "NMMapView.h"
#import "NMCategory.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "NMBusinessDetailTableViewController.h"
#import "NMUtilities.h"

@interface NMBusinessListTabelViewViewController ()

@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSMutableArray *filteredLocations;
@property (strong, nonatomic) NMMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation NMBusinessListTabelViewViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.locations = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView = [[NMMapView alloc] init];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self setupLocationManager];
    [self setupPullToRefresh];
}

#pragma mark - setup methods
-(void)setupPullToRefresh
{
    __weak NMBusinessListTabelViewViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[AKLocationManager mostRecentCoordinate].latitude longitude:[AKLocationManager mostRecentCoordinate].longitude];
        [weakSelf loadData:loc];
    }];
}

-(void)setupLocationManager
{
    __weak NMBusinessListTabelViewViewController *weakSelf = self;
    [AKLocationManager startLocatingWithUpdateBlock:^(CLLocation *location){
        [weakSelf.tableView.pullToRefreshView startAnimating];
        [self loadData:location];
    }failedBlock:^(NSError *error){
        NSLog(@"Could not get location... %@", error);
    }];
}

-(void)setupNavBarTitle
{
    self.navigationController.navigationBar.topItem.title = @"Locations";
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"OpenSans-Semibold" size:18], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setupNavBarTitle];
}


#pragma mark - Data loading methods
-(void)loadData:(CLLocation *)location
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    NMAPIClient *api = [[NMAPIClient alloc] init];
    
    void (^successBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
    successBlock = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        app.networkActivityIndicatorVisible = NO;
        [self onSuccessWithMappingResult:mappingResult];
    };
    void (^failureBlock)(RKObjectRequestOperation *operation, NSError *error);
    failureBlock = ^(RKObjectRequestOperation *operation, NSError *error) {
        app.networkActivityIndicatorVisible = NO;
        [self onFailureWithOperation:operation andError:error];
    };
    [api getBusinesses:location withSuccessBLock:successBlock withFailureBlock:failureBlock];
}

#pragma mark - On Success of Network Call method
-(void)onSuccessWithMappingResult:(RKMappingResult *)mappingResult
{
    NMBusinessReviewSearch *search = mappingResult.array[0];
    NSArray *sortedArray;
    sortedArray = [search.businesses sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(NMBusiness *)a distance];
        NSString *second = [(NMBusiness *)b distance];
        return [first compare:second];
    }];
    
    self.locations = [sortedArray mutableCopy];
    self.filteredLocations = [NSMutableArray arrayWithCapacity:[self.locations count]];
    [self.tableView reloadData];
    [self.tableView.pullToRefreshView stopAnimating];
}

#pragma mark - On Failure of Network Call method
-(void)onFailureWithOperation:(RKObjectRequestOperation *)operation andError:(NSError *)error
{
    [self.tableView.pullToRefreshView stopAnimating];
    NSLog(@"ERROR: %@", error);
    NSLog(@"Response: %@", operation.HTTPRequestOperation.responseString);
}

#pragma mark - Table view data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredLocations count];
    } else {
        return [self.locations count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BusinessCell";
    NMBusinessListViewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil ) {
        cell = [[NMBusinessListViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath withTableView:tableView];
    return cell;
}

#pragma mark  - configure business cell
- (void)configureCell:(NMBusinessListViewTableCell *)cell atIndexPath:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView
{
    NMBusiness *business = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        business = [self.filteredLocations objectAtIndex:indexPath.row];
    } else {
        business = [self.locations objectAtIndex:indexPath.row];
    }
    [cell configureCategorywithBusiness:business];
    [cell configureNamewithBusiness:business];
    [cell configureImageThumbnailwithBusiness:business];
    [cell configureDistancewithBusiness:business];
    [cell configureStatuswithBusiness:business];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredLocations removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredLocations = [NSMutableArray arrayWithArray:[self.locations filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];

}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Storyboard methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[NMMapView class]]){
        NMMapView *mapViewController = (NMMapView *)segue.destinationViewController;
        [mapViewController setLocations:self.locations];
    } else {
          NMBusinessDetailTableViewController *detailTableViewController = (NMBusinessDetailTableViewController *)segue.destinationViewController;
        NMBusiness *business = [self.locations objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailTableViewController.business = business;
    }
}

@end
