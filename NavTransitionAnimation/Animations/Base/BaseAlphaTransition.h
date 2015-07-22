//
//  BaseAlphaTransition.h
//  NavTransitionAnimation
//
//  Created by lingyj on 7/22/15.
//  Copyright (c) 2015 iiseeuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseAlphaTransition;

typedef void(^BaseAlphaTransitionAnimationBegin)(BaseAlphaTransition *transition);
typedef void(^BaseAlphaTransitionAnimationFinish)(BaseAlphaTransition *transition);
typedef void(^BaseAlphaTransitionAnimation)(UIViewController *fromVC, UIViewController *toVC, UIView *containerView, BaseAlphaTransition *transition);

@protocol BaseAlphaTransitionProtocol <NSObject>

@optional
- (NSTimeInterval)baseAnimationDuration;

- (void)toViewController:(UIViewController *)toVC shouldAddToContainerView:(UIView *)containerView transition:(BaseAlphaTransition *)transition;
- (void)toViewController:(UIViewController *)toVC didAddToContainerView:(UIView *)containerView transition:(BaseAlphaTransition *)transition;

@end

@interface BaseAlphaTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) id <BaseAlphaTransitionProtocol> delegate;

- (void)animationWhenBegin:(BaseAlphaTransitionAnimationBegin)begin animation:(BaseAlphaTransitionAnimation)animation finish:(BaseAlphaTransitionAnimationFinish)finish;

@end
