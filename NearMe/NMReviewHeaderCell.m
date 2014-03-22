//
//  NMReviewHeaderCell.m
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMReviewHeaderCell.h"
#import <AFNetworking/AFNetworking.h>
#import "NMUtilities.h"
#import "NMCategory.h"

@implementation NMReviewHeaderCell

-(void)configureBusinessImagewithBusiness:(NMBusiness *)business
{
    NSURL *businessImageUrl = [[NSURL alloc] initWithString:business.photo_url];
    [self.businessImage setImageWithURL:businessImageUrl];
    CALayer * l = [self.businessImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:3.0];
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor grayColor] CGColor]];
}

-(void)configureRatingImagewithBusiness:(NMBusiness *)business
{
    NSURL *ratingImageURL = [[NSURL alloc] initWithString:business.rating_img_url];
    [self.ratingImageView setImageWithURL:ratingImageURL];
    
}

-(void)configureAddresswithBusiness:(NMBusiness *)business
{
    [self.address1Label setText:business.address1];
    self.address1Label.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configureStatewithBusiness:(NMBusiness *)business
{
    [self.stateLabel setText:business.state];
    self.stateLabel.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configureCitywithBusiness:(NMBusiness *)business
{
    [self.cityLabel setText:business.city];
    self.cityLabel.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configureCategorywithBusiness:(NMBusiness *)business
{
    NMCategory *category = [business.categories objectAtIndex:0];
    [self.categoryLabel setText:category.name];
    self.categoryLabel.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configurePhoneNumberwithBusiness:(NMBusiness *)business
{
    [self.phoneNumberButton setTitle:business.phone forState:UIControlStateNormal];
    self.phoneNumberButton.titleLabel.font = [NMUtilities getDefaultFontwithSize:13.0f];
}
@end
