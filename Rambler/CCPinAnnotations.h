//
//  CCPinAnnotations.h
//  Rambler
//
//  Created by Chad D Colby on 5/9/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CCPinAnnotations : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;

- (id)initWithStart:(CLLocationCoordinate2D)coord;
- (void)changePinColor:(MKPinAnnotationColor)color;

@end
