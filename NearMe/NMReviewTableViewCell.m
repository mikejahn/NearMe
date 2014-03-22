//
//  NMReviewTableViewCell.m
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMReviewTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "NMUtilities.h"

@implementation NMReviewTableViewCell

-(void)configureUserLabelwithReview:(NMReview *)review
{
    [self.userLabel setText:review.user_name];
    self.userLabel.font = [NMUtilities getDefaultFontwithSize:13.0f];
}

-(void)configureUserImagewithReview:(NMReview *)review
{
    NSURL *userPhotoUrl = [[NSURL alloc] initWithString:review.user_photo_url_small];
    [self.userThumbnailImageView setImageWithURL:userPhotoUrl];
    CALayer * l = [self.userThumbnailImageView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:2.0];
}

-(void)configureRatingImagewithReview:(NMReview *)review
{
    NSURL *reviewPhotoUrl = [[NSURL alloc] initWithString:review.rating_img_url_small];
    [self.reviewImageView setImageWithURL:reviewPhotoUrl];
}

-(void)configureExcerptwithReview:(NMReview *)review
{
    [self.reviewTextView setText:review.text_excerpt];
    self.reviewTextView.font = [NMUtilities getDefaultFontwithSize:12.0f];
}


@end
