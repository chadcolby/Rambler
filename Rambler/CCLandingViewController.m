//
//  CCLandingViewController.m
//  Rambler
//
//  Created by Chad D Colby on 4/24/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCLandingViewController.h"
#import "CRMotionView.h"

@interface CCLandingViewController ()

@end

@implementation CCLandingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CRMotionView *motionView = [[CRMotionView alloc] initWithFrame:self.view.bounds];
    [motionView setImage:[UIImage imageNamed:@"smallBG"]];
    motionView.scrollIndicatorEnabled = NO;
    [self.view addSubview:motionView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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