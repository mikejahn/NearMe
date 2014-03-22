//
//  NMBusinessListViewTableCell.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMBusinessListViewTableCell.h"
#import "NMCategory.h"
#import <AFNetworking/AFNetworking.h>
#import "NMUtilities.h"

@implementation NMBusinessListViewTableCell


-(void)configureNamewithBusiness:(NMBusiness *)business
{
    self.name.text = business.name;
    self.name.font = [UIFont fontWithName:@"OpenSans-Semibold" size:16.0f];
}

-(void)configureCategorywithBusiness:(NMBusiness *)business
{
    NMCategory *category = [business.categories objectAtIndex:0];
    self.category.text = category.name;
    self.category.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configureImageThumbnailwithBusiness:(NMBusiness *)business
{
    NSURL *url = [[NSURL alloc] initWithString:business.photo_url];
    [self.imageThumbnail setImageWithURL:url];
    
    CALayer * l = [self.imageThumbnail layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:3.0];
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor grayColor] CGColor]];
}

-(void)configureDistancewithBusiness:(NMBusiness *)business
{
    [self.distance setText:business.distanceToString];
    self.distance.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configureStatuswithBusiness:(NMBusiness *)business
{
    [self.status setText:business.isOpen];
    if(!business.isOpen)
    {
        [self.status setTextColor:[UIColor redColor]];
    }
    self.status.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

@end
