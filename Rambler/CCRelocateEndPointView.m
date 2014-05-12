//
//  CCRelocateEndPointView.m
//  Rambler
//
//  Created by Chad D Colby on 5/11/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCRelocateEndPointView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CCRelocateEndPointView ()

@property (strong, nonatomic) MKMapView *zoomMapView;
@property (nonatomic) CLLocationCoordinate2D endingCoordinate;

@end

@implementation CCRelocateEndPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(retrieveEndCoordinates:) name:@"endCoordinates" object:nil];
        //self.backgroundColor = [UIColor clearColor];
        self.zoomMapView = [[MKMapView alloc] init];
        self.zoomMapView.frame = CGRectMake(self.bounds.origin.x + 10, self.bounds.origin.y + 10,
                                                self.bounds.size.width-20, self.bounds.size.height - 20);

        MKCoordinateRegion zoomRegion;
        if (!self.endingCoordinate.longitude) {
            NSLog(@"empty");
        }
        zoomRegion.center.latitude = self.endingCoordinate.latitude;
        zoomRegion.center.longitude = self.endingCoordinate.longitude;
        zoomRegion.span = MKCoordinateSpanMake(0.005, 0.005);
        
        [self.zoomMapView setRegion:zoomRegion];
        [self addSubview:self.zoomMapView];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-21, self.bounds.size.height-200, 27, 21)];
        closeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Checkbox"]];
        //    closeButton.clipsToBounds = YES;
        //    closeButton.layer.cornerRadius = 15.f;
        [closeButton addTarget:self action:@selector(closeZoomView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
    }
    return self;
}

- (void)retrieveEndCoordinates:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"endCoordinates"]) {
        NSNumber *latitude = [notification.userInfo objectForKey:@"endLat"];
        NSNumber *longitude = [notification.userInfo objectForKey:@"endLon"];
        self.endingCoordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        
    }
}


- (void)closeZoomView:(id)sender
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
