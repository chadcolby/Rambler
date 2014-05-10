//
//  CCDrawableView.h
//  Rambler
//
//  Created by Chad D Colby on 5/8/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLine.h"

@protocol RouteLineDelegate <NSObject>

- (void)mapPointsFromDrawnLine:(CCLine *)drawnLine;

@end

@interface CCDrawableView : UIView

@property (unsafe_unretained) id <RouteLineDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *completedLines;
@property (strong, nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) BOOL allowsDrawing;

- (void)theEndOfDrawing:(NSSet *)touches;
- (void)clearAllLines;

@end
