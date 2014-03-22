//
//  NMReviewTableViewCell.h
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMReview.h"

@interface NMReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userThumbnailImageView;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImageView;

-(void)configureUserLabelwithReview:(NMReview *)review;
-(void)configureUserImagewithReview:(NMReview *)review;
-(void)configureRatingImagewithReview:(NMReview *)review;
-(void)configureExcerptwithReview:(NMReview *)review;
@end
