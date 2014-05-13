//
//  CCEndPointPinView.m
//  Rambler
//
//  Created by Chad D Colby on 5/11/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCEndPointPinView.h"

@implementation CCEndPointPinView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.f;
        
        self.canBeMoved = YES;
        
        self.moveViewButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 28, 28)];
        [self.moveViewButton addTarget:self action:@selector(moveViewPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.moveViewButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Pin"]];

        [self addSubview:self.moveViewButton];
    }
    return self;
    
}

- (void)moveViewPressed:(id)sender
{
    [self.delegate buttonPressedForRelocateView:self.center];
    self.canBeMoved = NO;
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
