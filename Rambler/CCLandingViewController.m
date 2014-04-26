//
//  CCLandingViewController.m
//  Rambler
//
//  Created by Chad D Colby on 4/24/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCLandingViewController.h"
#import "CRMotionView.h"
#import "CCButtonClass.h"

@interface CCLandingViewController ()

@end

@implementation CCLandingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialViewSetUp];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)initialViewSetUp
{
    CRMotionView *motionView = [[CRMotionView alloc] initWithFrame:self.view.bounds];
    [motionView setImage:[UIImage imageNamed:@"smallBG"]];
    motionView.scrollIndicatorEnabled = NO;
    [self.view addSubview:motionView];
    
    CGRect buttonFrame = CGRectMake(20, 200, 280, 50);
    
    CCButtonClass *mapButton = [[CCButtonClass alloc] initWithFrame:buttonFrame];
    [mapButton setTitle:@"Show Map" forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(showMapPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
    
    CCButtonClass *settingsButton = [[CCButtonClass alloc] initWithFrame:CGRectMake(buttonFrame.origin.x,
                                                                                    buttonFrame.origin.y + 70,
                                                                                    buttonFrame.size.width,
                                                                                    buttonFrame.size.height)];
    [settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(settingsPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingsButton];
}

- (void)showMapPressed:(id)sender
{
    NSLog(@"Show Map");
}

- (void)settingsPressed:(id)sender
{
    NSLog(@"settings pressed");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
