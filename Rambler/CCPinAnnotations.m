//
//  CCPinAnnotations.m
//  Rambler
//
//  Created by Chad D Colby on 5/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCPinAnnotations.h"

@implementation CCPinAnnotations

@synthesize coordinate;

- (id)initWithStart:(CLLocationCoordinate2D)coord
{
    self = [super init];
    
    if (self) {
        coordinate = coord;

    }
    
    return self;
}

- (void)changePinColor:(MKPinAnnotationColor)color
{
    self.pinColor = color;
}

@end
