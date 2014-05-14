//
//  CCFingerView.m
//  Rambler
//
//  Created by Chad D Colby on 5/13/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCFingerView.h"

@implementation CCFingerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.borderWidth = 3.f;
        self.layer.borderColor = [[UIColor colorWithRed:23.f/255 green:20.f/255 blue:70.f/255 alpha:1.f] CGColor];
        
        self.mapView = [[MKMapView alloc] initWithFrame:self.frame];
        
        [self addSubview:self.mapView];
        
        
    }
    return self;
}


//- (void)drawRect:(CGRect)rect
//{
//    NSInteger radiusValue = 100;
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(contextRef, 5.f);
//
//    CGContextSetRGBFillColor(contextRef, 0.f, 0.f, 0.f, 1.f);
//    CGContextSetRGBStrokeColor(contextRef, 23.f/255, 20.f/255, 70.f/255, 1.f);
//    CGContextFillEllipseInRect(contextRef, rect);
//    CGContextStrokeEllipseInRect(contextRef, rect);
//}


@end
