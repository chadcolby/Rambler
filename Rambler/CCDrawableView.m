//
//  CCDrawableView.m
//  Rambler
//
//  Created by Chad D Colby on 5/8/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCDrawableView.h"
#import "CCEndPointPinView.h"

@interface CCDrawableView ()  <RelocateEndPointDelegate>

@property (strong, nonatomic) CCEndPointPinView *pointerIndicator;
@property (strong, nonatomic) UIView *tempView;
@property (nonatomic) BOOL tempViewIsActive;

@end

@implementation CCDrawableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.completedLines = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        self.multipleTouchEnabled = NO;
        
        self.pointerIndicator = [[CCEndPointPinView alloc] initWithFrame:CGRectMake(25, 25, 28, 28)];
        self.pointerIndicator.delegate = self;
        [self addSubview:self.pointerIndicator];
        self.tempViewIsActive = NO;
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
        self.pointerIndicator.hidden = YES;
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
        self.pointerIndicator.hidden = NO;
        self.pointerIndicator.center = CGPointMake(lock.x + 11, lock.y - 9);
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
    self.pointerIndicator.hidden = NO;
    [self setNeedsDisplay];
    
}


#pragma mark - Relocate end point delegate methods

- (void)buttonPressedForRelocateView:(CGPoint)pointForCenter
{
    self.tempView = [[UIView alloc] initWithFrame:CGRectMake(20, (self.bounds.size.height/2) - 100, 280, 200)];
    self.tempView.backgroundColor = [UIColor lightGrayColor];
    self.tempView.alpha = 0.75;
    [self addSubview:self.tempView];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tempView.bounds.size.width-30, self.tempView.bounds.size.height-200, 30, 30)];
    closeButton.backgroundColor = [UIColor whiteColor];
    [closeButton addTarget:self action:@selector(closeZoomView:) forControlEvents:UIControlEventTouchUpInside];
    [self.tempView addSubview:closeButton];
    
    self.tempViewIsActive = YES;
}

- (void)closeZoomView:(id)sender
{
    [self.tempView removeFromSuperview];
    [self clearAllLines];
}

@end
