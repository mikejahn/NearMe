//
//  NMBusinessDetailView.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMBusinessDetailView.h"
#import <AFNetworking/AFNetworking.h>
#import "NMCategory.h"

@interface NMBusinessDetailView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *address1Label;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@end

@implementation NMBusinessDetailView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUIWithData];
   

    
}

-(void)setupUIWithData
{
    NSURL *url = [[NSURL alloc] initWithString:self.business.photo_url];
    [self.imageView setImageWithURL:url];
    
    [self.address1Label setText:self.business.address1];
    [self.stateLabel setText:self.business.state];
    [self.cityLabel setText:self.business.city];
    [self.phoneLabel setText:self.business.phone];
    
    NMCategory *category = [self.business.categories objectAtIndex:0];
    [self.categoryLabel setText:category.name];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = self.business.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
