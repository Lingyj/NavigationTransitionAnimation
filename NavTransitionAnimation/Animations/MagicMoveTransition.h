//
//  MagicMoveTransition.h
//  NavTransitionAnimation
//
//  Created by lingyj on 7/22/15.
//  Copyright (c) 2015 iiseeuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAlphaTransition.h"

@class MagicMoveTransition;
typedef UIView *(^MoveViewBlock)(MagicMoveTransition *trans);

@interface MagicMoveTransition : BaseAlphaTransition

- (instancetype)initWithOringView:(MoveViewBlock)originView finishView:(MoveViewBlock)finishView;

@end
