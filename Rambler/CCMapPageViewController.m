//
//  CCMapPageViewController.m
//  Rambler
//
//  Created by Chad D Colby on 5/5/14.
//  Copyright (c) 2014 Byte Meets World. All rights reserved.
//

#import "CCMapPageViewController.h"

@interface CCMapPageViewController ()


@end

@implementation CCMapPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];


    
    [self.selectorControl setTitle:@"Search" forSegmentAtIndex:0];
    [self.selectorControl setTitle:@"Draw" forSegmentAtIndex:1];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
