//
//  CCDrawableView.m
//  Rambler
//
//  Created by Chad D Colby on 5/8/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawableView.h"

@interface CCDrawableView ()

@property (strong, nonatomic) UIView *pointerIndicator;


@end

@implementation CCDrawableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.completedLines = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        self.multipleTouchEnabled = YES;
        
        self.pointerIndicator = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        self.pointerIndicator.backgroundColor = [UIColor whiteColor];
        self.pointerIndicator.alpha = 0.5;
        self.pointerIndicator.clipsToBounds = YES;
        self.pointerIndicator.layer.cornerRadius = 10.f;
        self.pointerIndicator.hidden = YES;
        [self addSubview:self.pointerIndicator];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.f);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [[UIColor colorWithRed:23.f/255 green:20.f/255 blue:70.f/255 alpha:1.f] set];
    for (CCLine *onScreenLine in self.completedLines) {
        CGContextMoveToPoint(context, onScreenLine.startPoint.x, onScreenLine.startPoint.y);
        CGContextAddLineToPoint(context, onScreenLine.endPoint.x, onScreenLine.endPoint.y);
        CGContextStrokePath(context);
    }
    
    [[UIColor redColor] set];
    for (NSValue *value in self.linesInProgress) {
        CCLine *lineInProgress = [self.linesInProgress objectForKey:value];
        CGContextMoveToPoint(context, lineInProgress.startPoint.x, lineInProgress.startPoint.y);
        CGContextAddLineToPoint(context, lineInProgress.endPoint.x, lineInProgress.endPoint.y);
        CGContextStrokePath(context);
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *drawingFinger in touches) {
        if ([drawingFinger tapCount] > 1)  {
            [self clearAllLines];
            return;
        }
        
        if (self.completedLines.count >= 1) {
            [self.completedLines removeAllObjects];
        }
        
        NSValue *key = [NSValue valueWithNonretainedObject:drawingFinger];
        CGPoint lock = [drawingFinger locationInView:self];
        CCLine *currentLine = [[CCLine alloc] init];
        currentLine.startPoint = lock;
        currentLine.endPoint = lock;
        self.pointerIndicator.hidden = NO;
        self.pointerIndicator.center = lock;
        
        [self.linesInProgress setObject:currentLine forKey:key];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *movingTouch in touches) {
        NSValue *anotherKey = [NSValue valueWithNonretainedObject:movingTouch];
        CCLine *anotherNewLine = [self.linesInProgress objectForKey:anotherKey];
        CGPoint lock = [movingTouch locationInView:self];
        anotherNewLine.endPoint = lock;
        self.pointerIndicator.center = lock;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self theEndOfDrawing:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self theEndOfDrawing:touches];
}

- (void)clearAllLines
{
    [self.linesInProgress removeAllObjects];
    [self.completedLines removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)theEndOfDrawing:(NSSet *)touches
{
    for (UITouch *currentTouch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:currentTouch];
        CCLine *completedLine = [self.linesInProgress objectForKey:key];
        
        if (completedLine) {
            [self.completedLines addObject:completedLine];
            [self.linesInProgress removeObjectForKey:key];
            [self.delegate mapPointsFromDrawnLine:completedLine];
        }
    }
    self.pointerIndicator.hidden = YES;
    [self setNeedsDisplay];
    
}

@end
