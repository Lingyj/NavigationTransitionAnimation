//
//  BaseAlphaTransition.m
//  NavTransitionAnimation
//
//  Created by lingyj on 7/22/15.
//  Copyright (c) 2015 iiseeuu. All rights reserved.
//

#import "BaseAlphaTransition.h"

@interface BaseAlphaTransition ()
{
    BaseAlphaTransitionAnimationBegin _beginBlock;
    BaseAlphaTransitionAnimationFinish _finishBlock;
    BaseAlphaTransitionAnimation _animationBlock;
}

@end

@implementation BaseAlphaTransition

- (void)animationWhenBegin:(BaseAlphaTransitionAnimationBegin)begin animation:(BaseAlphaTransitionAnimation)animation finish:(BaseAlphaTransitionAnimationFinish)finish
{
    _beginBlock = begin;
    _finishBlock = finish;
    _animationBlock = animation;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    NSTimeInterval duration = 0.6;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseAnimationDuration)])
    {
        NSTimeInterval dura = [self.delegate baseAnimationDuration];
        duration = dura > 0 ? dura : duration;
    }
    
    return duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_beginBlock) _beginBlock(self);

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    containerView.backgroundColor = [UIColor redColor];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;

    if (self.delegate && [self.delegate respondsToSelector:@selector(toViewController:shouldAddToContainerView:transition:)])
    {
        [self.delegate toViewController:toVC shouldAddToContainerView:containerView transition:self];
    }
    
    [containerView addSubview:toVC.view];

    if (self.delegate && [self.delegate respondsToSelector:@selector(toViewController:didAddToContainerView:transition:)])
    {
        [self.delegate toViewController:toVC didAddToContainerView:containerView transition:self];
    }

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         toVC.view.alpha = 1.0;
                         if (_animationBlock) _animationBlock(fromVC, toVC, containerView, self);
                     }
                     completion:^(BOOL finished) {
                         if (_finishBlock) _finishBlock(self);
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

@end
