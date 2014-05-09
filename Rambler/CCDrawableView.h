//
//  CCDrawableView.h
//  Rambler
//
//  Created by Chad D Colby on 5/8/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDrawableView : UIView

@property (strong, nonatomic) NSMutableArray *completedLines;
@property (strong, nonatomic) NSMutableDictionary *linesInProgress;
@property (nonatomic) BOOL allowsDrawing;

- (void)theEndOfDrawing:(NSSet *)touches;

@end
