



//
//  SecondViewController.m
//  NavTransitionAnimation
//
//  Created by lingyj on 7/22/15.
//  Copyright (c) 2015 iiseeuu. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "MagicMoveTransition.h"

@interface SecondViewController () <UINavigationControllerDelegate>

@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[FirstViewController class]])
    {
        MagicMoveTransition *transition = [[MagicMoveTransition alloc] initWithOringView:^UIView *(MagicMoveTransition *trans) {
            return [(FirstViewController *)toVC finishView];
        } finishView:^UIView *(MagicMoveTransition *trans) {
            return [(FirstViewController *)toVC originView];
        }];
        
        return transition;
    }
    else
    {
        return nil;
    }
}

@end
