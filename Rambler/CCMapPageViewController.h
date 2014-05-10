//
//  CCMapPageViewController.h
//  Rambler
//
//  Created by Chad D Colby on 5/5/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCMapPageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectorControl;

- (IBAction)routeButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *routeButton;

@end
