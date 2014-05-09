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


@interface CCMapPageViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CCDrawableView *drawableView;


@end

@implementation CCMapPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedDrawingRouteLine:) name:@"doneDrawingLine" object:nil];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
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
        } else if (selectedIndex == 1)
        {
            self.mapView.scrollEnabled = NO;
            self.mapView.zoomEnabled = NO;
            self.mapView.rotateEnabled = NO;
            self.drawableView.hidden = NO;
        }
    }
}

- (void)finishedDrawingRouteLine:(CCDrawableView *)sender
{
    NSLog(@"%@", [sender class] );
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

@end
