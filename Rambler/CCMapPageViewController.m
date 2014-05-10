//
//  CCMapPageViewController.m
//  Rambler
//
//  Created by Chad D Colby on 5/5/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapPageViewController.h"
#import "CCDrawableView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CCPinAnnotations.h"


@interface CCMapPageViewController () <CLLocationManagerDelegate, RouteLineDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *routingIndicator;

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CCDrawableView *drawableView;

@property (nonatomic) CLLocationCoordinate2D startCoordinate;
@property (nonatomic) CLLocationCoordinate2D endCoordinate;

@property (strong, nonatomic) NSArray *annotationsArray;
@property (strong, nonatomic) MKPlacemark *endPlacemark;
@property (strong, nonatomic) MKPlacemark *startPlacemark;
@property (strong, nonatomic) MKRoute *routeDetails;

@end

@implementation CCMapPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    self.routeButton.enabled = NO;
    
    MKCoordinateRegion region;
    self.locationManager = [[CLLocationManager alloc] init];
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span = MKCoordinateSpanMake(0.05, 0.05);
    [self.mapView setRegion:region];
    [self.view addSubview:self.mapView];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.selectorControl setTitle:@"Search" forSegmentAtIndex:0];
    [self.selectorControl setTitle:@"Draw" forSegmentAtIndex:1];
    [self.selectorControl addTarget:self action:@selector(segmentedIndexChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.drawableView = [[CCDrawableView alloc] initWithFrame:self.view.bounds];
    self.drawableView.hidden = YES;
    [self.view addSubview:self.drawableView];
    
    self.drawableView.delegate = self;


}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)segmentedIndexChanged:(UISegmentedControl *)sender
{
    if ([sender isEqual:self.selectorControl]) {
        NSInteger selectedIndex = [sender selectedSegmentIndex];
        
        if (selectedIndex == 0) {
            self.mapView.scrollEnabled = YES;
            self.mapView.zoomEnabled = YES;
            self.mapView.rotateEnabled = YES;
            self.drawableView.hidden = YES;
            self.routeButton.enabled = NO;
            
        } else if (selectedIndex == 1)
        {
            self.mapView.scrollEnabled = NO;
            self.mapView.zoomEnabled = NO;
            self.mapView.rotateEnabled = NO;
            self.drawableView.hidden = NO;
            self.routeButton.enabled = YES;
            
            [self.mapView removeAnnotations:self.annotationsArray];
            [self.mapView removeOverlay:self.routeDetails.polyline];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)mapPointsFromDrawnLine:(CCLine *)drawnLine
{
    NSLog(@">>>>> %f and %f", drawnLine.startPoint.x, drawnLine.startPoint.y);
    self.startCoordinate = [self.mapView convertPoint:drawnLine.startPoint toCoordinateFromView:self.mapView];
    self.endCoordinate = [self.mapView convertPoint:drawnLine.endPoint toCoordinateFromView:self.mapView];

}

- (IBAction)routeButtonPressed:(id)sender
{
    CCPinAnnotations *startPin = [[CCPinAnnotations alloc] initWithStart:self.startCoordinate];
    [self.mapView addAnnotation:startPin];
    CCPinAnnotations *endPin = [[CCPinAnnotations alloc] initWithStart:self.endCoordinate];
    [self.mapView addAnnotation:endPin];
    
    self.annotationsArray = [NSArray arrayWithObjects:startPin, endPin, nil];
    
    [self.drawableView clearAllLines];
    self.selectorControl.selectedSegmentIndex = 0;
    [self segmentedIndexChanged:self.selectorControl];
    
    [self requestRouteFromPoints];
    
}

- (void)requestRouteFromPoints
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:self.endCoordinate.latitude longitude:self.endCoordinate.longitude];
    //CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    [geocoder reverseGeocodeLocation:endLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        } else {

            self.endPlacemark = [[MKPlacemark alloc] initWithPlacemark:[placemarks lastObject]];
            MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
            [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
            [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:self.endPlacemark]];
            directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
            MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"Error >> %@", error.description);
                } else {
                    self.routeDetails = response.routes.lastObject;
                    [self.mapView addOverlay:self.routeDetails.polyline];

                }
            }];
        }
    }];
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:self.routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor colorWithRed:23.f/255 green:20.f/255 blue:70.f/255 alpha:1.f];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
}
@end
