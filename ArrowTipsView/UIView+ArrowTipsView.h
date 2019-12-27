//
//  UIView+ArrowTipsView.h
//  FunnyRecord
//
//  Created by hexiang on 2019/12/6.
//  Copyright © 2019 HeXiang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FDArrowTipsView.h"
#import "FDArrowCustomListView.h"
#import "FDAnimationManagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ArrowTipsView)

- (void)showArrowTipsViewWithText:(NSString *)text point:(CGPoint)point;

- (void)showArrowTipsViewWithText:(NSString *)text maxWidth:(CGFloat)maxWidth point:(CGPoint)point;

- (FDArrowTipsView *)showArrowTipsViewWithListConfig:(FDArrowCustomListViewConfig *)listConfig
                                       withTipConfig:(FDArrowTipsViewConfig *)tipConfig
                                           withPoint:(CGPoint)point
                                          clickBlock:(void(^)(NSInteger index))clickBlock;

- (FDArrowTipsView *)showArrowTipsViewWithConfig:(FDArrowTipsViewConfig *)config
                                  withCustomView:(UIView *)customView
                                           point:(CGPoint)point;

#pragma mark - 带背景的显示方式

- (void)showArrowTipsBackgroundViewWithText:(NSString *)text point:(CGPoint)point;

- (void)showArrowTipsBackgroundViewWithText:(NSString *)text maxWidth:(CGFloat)maxWidth point:(CGPoint)point;

- (FDAnimationManagerView *)showArrowTipsBackgroundViewWithListConfig:(FDArrowCustomListViewConfig *)listConfig
                                                        withTipConfig:(FDArrowTipsViewConfig *)tipConfig
                                                            withPoint:(CGPoint)point
                                                           clickBlock:(void(^)(NSInteger index))clickBlock;

- (FDAnimationManagerView *)showArrowTipsBackgroundViewWithConfig:(FDArrowTipsViewConfig *)config
                                                   withCustomView:(UIView *)customView
                                                            point:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
