//
//  CCButtonClass.m
//  Rambler
//
//  Created by Chad D Colby on 4/26/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCButtonClass.h"

@implementation CCButtonClass

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:23/255 green:20/255 blue:70/255 alpha:1.f] forState:UIControlStateHighlighted];
        self.alpha = 1.f;
        self.layer.borderWidth = 2.f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:36.f];
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
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
