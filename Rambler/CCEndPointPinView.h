//
//  CCEndPointPinView.h
//  Rambler
//
//  Created by Chad D Colby on 5/11/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol RelocateEndPointDelegate <NSObject>

- (void)buttonPressedForRelocateView:(CGPoint)pointForCenter;

@end

@interface CCEndPointPinView : UIView

@property (unsafe_unretained) id <RelocateEndPointDelegate> delegate;

@property (nonatomic) CGPoint anchoredPoint;
@property (strong, nonatomic) UIButton *moveViewButton;
@property (nonatomic) BOOL canBeMoved;

@end
