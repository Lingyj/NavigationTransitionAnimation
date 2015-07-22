//
//  ViewController.m
//  NavTransitionAnimation
//
//  Created by lingyj on 7/22/15.
//  Copyright (c) 2015 iiseeuu. All rights reserved.
//

#import "FirstViewController.h"
#import "MagicMoveTransition.h"
#import "SecondViewController.h"

@interface FirstViewController () <UINavigationControllerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

#pragma mark - navigation delegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    
    if ([toVC isKindOfClass:[SecondViewController class]])
    {
        _originView = nil;
        _finishView = nil;
        
        MagicMoveTransition *transition = [[MagicMoveTransition alloc] initWithOringView:^UIView *(MagicMoveTransition *trans) {
            
            if (!_originView)
            {
                FirstViewController *from = (FirstViewController *)fromVC;
                NSArray *a1 = @[from.imageView1, from.imageView2, from.imageView3];
                int a = arc4random()%3;
                _originView = a1[a];
            }
            
            return _originView;
        } finishView:^UIView *(MagicMoveTransition *trans) {
            
            if (!_finishView)
            {
                SecondViewController *to = (SecondViewController *)toVC;
                NSArray *a2 = @[to.imageView1, to.imageView2, to.imageView3];
                int b = arc4random()%3;
                _finishView = a2[b];
            }
             
            return _finishView;
        }];
        
        return transition;
    }
    else
    {
        return nil;
    }
}


@end
