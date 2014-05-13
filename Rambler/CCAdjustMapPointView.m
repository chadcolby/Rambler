//
//  CCAdjustMapPointView.m
//  Rambler
//
//  Created by Chad D Colby on 5/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCAdjustMapPointView.h"
#import <CoreLocation/CoreLocation.h>

@interface CCAdjustMapPointView ()

@property (nonatomic) CLLocationCoordinate2D endCoordinate;

@end

@implementation CCAdjustMapPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.adjustView = [[MKMapView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 20, self.bounds.size.width, self.bounds.size.height - 20)];
        self.adjustView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.adjustView];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-21, self.bounds.size.height-280, 27, 21)];
        closeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Checkbox"]];
        [closeButton addTarget:self action:@selector(closeZoomView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMapCenter:) name:@"endCoordinates" object:nil];
        
        UIImageView *centerPinView = [[UIImageView alloc] initWithFrame:CGRectMake(self.adjustView.center.x - 25, self.adjustView.center.y - 25, 30, 30)];
        centerPinView.image = [UIImage imageNamed:@"Map_Pin"];
        [self.adjustView addSubview:centerPinView];
    }
    return self;
}

- (void)closeZoomView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeButtonPressed" object:self userInfo:nil]; //updates drawable view to allow re-drawing of new route
    [self removeFromSuperview];

}

- (void)updateMapCenter:(NSNotification *)notification //gets correct CLLocationCoord2D based on main map location
{
    if ([notification.name isEqualToString:@"endCoordinates"]) {
        NSNumber *latitude = [notification.userInfo objectForKey:@"endLat"];
        NSNumber *longitude = [notification.userInfo objectForKey:@"endLon"];
        
        self.endCoordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        [self centerFromMainMap:self.endCoordinate];
        
    }

}

- (void)centerFromMainMap:(CLLocationCoordinate2D)centerCoordinate
{
    MKCoordinateRegion zoomedInRegion;
    zoomedInRegion.center = centerCoordinate;
    zoomedInRegion.span = MKCoordinateSpanMake(0.005, 0.005);
    
    [self.adjustView setRegion:zoomedInRegion];
}

@end
