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

/// 显示带有文本的箭头指向view（箭头view的最大宽度为当前view的宽度）
/// @param text 文本内容
/// @param point 箭头指向的点
- (void)showArrowTipsViewWithText:(NSString *)text point:(CGPoint)point;

/// 显示荡悠文本的固定宽度的箭头指向view
/// @param text 文本内容
/// @param maxWidth 最大显示宽度
/// @param point 箭头指向的点
- (void)showArrowTipsViewWithText:(NSString *)text maxWidth:(CGFloat)maxWidth point:(CGPoint)point;

/// 根据传入配置显示列表内容的箭头指向view
/// @param listConfig 列表内容的view配置选项
/// @param tipConfig 整个箭头view的配置选项
/// @param point 箭头指向的点
/// @param clickBlock 点击列表选项的回调
- (FDArrowTipsView *)showArrowTipsViewWithListConfig:(FDArrowCustomListViewConfig *)listConfig
                                       withTipConfig:(FDArrowTipsViewConfig *)tipConfig
                                           withPoint:(CGPoint)point
                                          clickBlock:(void(^)(NSInteger index))clickBlock;

/// 根据配置显示箭头指向view
/// @param config 整个箭头view的配置选项
/// @param customView 自定义的view（内部根据自定义view显示，忽略起frame.origin值）
/// @param point 箭头指向的点
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
