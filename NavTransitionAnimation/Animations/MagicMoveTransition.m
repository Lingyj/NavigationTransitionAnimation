//
//  MagicMoveTransition.m
//  NavTransitionAnimation
//
//  Created by lingyj on 7/22/15.
//  Copyright (c) 2015 iiseeuu. All rights reserved.
//

#import "MagicMoveTransition.h"

@interface MagicMoveTransition () <BaseAlphaTransitionProtocol>
{
    MoveViewBlock _originViewBlock;
    MoveViewBlock _finishViewBlock;
}

@property (strong, nonatomic) UIView *beginView;
@property (strong, nonatomic) UIView *finishView;
@property (strong, nonatomic) UIView *snapShotView;

@end

@implementation MagicMoveTransition

- (instancetype)initWithOringView:(MoveViewBlock)originView finishView:(MoveViewBlock)finishView
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        _originViewBlock = originView;
        _finishViewBlock = finishView;
        
        __weak typeof(self) weakSelf = self;
        [self animationWhenBegin:nil
                       animation:^(UIViewController *fromVC, UIViewController *toVC, UIView *containerView, BaseAlphaTransition *transition) {
                           weakSelf.snapShotView.frame = [containerView convertRect:weakSelf.finishView.frame fromView:toVC.view];
                       }
                          finish:^(BaseAlphaTransition *transition) {
                              weakSelf.finishView.hidden = NO;
                              weakSelf.beginView.hidden = NO;
                              [weakSelf.snapShotView removeFromSuperview];
                          }];
        
    }
    
    return self;
}

- (UIView *)beginView
{
    return _originViewBlock(self);
}

- (UIView *)finishView
{
    return _finishViewBlock(self);
}

- (void)toViewController:(UIViewController *)toVC shouldAddToContainerView:(UIView *)containerView transition:(BaseAlphaTransition *)transition
{
    _snapShotView = [self.beginView snapshotViewAfterScreenUpdates:NO];
    _snapShotView.frame = [containerView convertRect:self.beginView.frame fromView:self.beginView.superview];
    self.finishView.hidden = YES;
    self.beginView.hidden = YES;
}

- (void)toViewController:(UIViewController *)toVC didAddToContainerView:(UIView *)containerView transition:(BaseAlphaTransition *)transition
{
    [containerView addSubview:self.snapShotView];
}

@end
