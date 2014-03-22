//
//  NMMapView.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMMapView.h"
#import "NMBusinessLocation.h"
#import "NMBUsiness.h"
#import "NMBusinessDetailTableViewController.h"

@interface NMMapView ()

@end

@implementation NMMapView


-(id)init
{
    self = [super init];
    if (self) {
        self.mapView = [[MKMapView alloc] init];
        self.mapView.hidden = NO;
        [self.view addSubview:self.mapView];
    }
    return self;

}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.topItem.title = @"Map";
}

-(void)viewWillAppear:(BOOL)animated
{
    NSMutableArray *annotations = [NSMutableArray array];
    for (NMBusiness *business in self.locations) {
        NMBusinessLocation *loc = [[NMBusinessLocation alloc] init];
        [loc setBusiness:business];
        
        [loc setTitle:business.name];
        
        [loc setCoordinate:CLLocationCoordinate2DMake([business.latitude doubleValue],[business.longitude doubleValue])];
        [annotations addObject:loc];
        [self.mapView addAnnotation:loc];
    }
    
    [self fitMapBoundsToAnnotations:annotations];
}

-(void)fitMapBoundsToAnnotations:(NSMutableArray *)annotations
{
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
}

#pragma mark - storyboard methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"mapDetailView"])
    {
        NMBusinessDetailTableViewController *detailView = (NMBusinessDetailTableViewController *)segue.destinationViewController;
        NMBusinessLocation *loc =  [self.mapView.selectedAnnotations objectAtIndex:0];
        [detailView setBusiness:loc.business];
    }
}

#pragma mark - MKMapViewDelegate methods
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"mapDetailView" sender:view];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    //don't use custom annotation if it is the user's location
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc]     initWithAnnotation:annotation reuseIdentifier:@"pinLocation"];
    newAnnotation.canShowCallout = YES;
    newAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return newAnnotation;
}

@end
