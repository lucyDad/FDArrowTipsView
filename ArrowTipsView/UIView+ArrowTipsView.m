//
//  UIView+ArrowTipsView.m
//  FunnyRecord
//
//  Created by hexiang on 2019/12/6.
//  Copyright © 2019 HeXiang. All rights reserved.
//

#import "UIView+ArrowTipsView.h"
#import "YYText.h"

#define ArrowTipsViewZoneInOffset(v, a, b) ( v < a ? a : (v > b ? b : v))

@implementation UIView (ArrowTipsView)

- (void)showArrowTipsViewWithText:(NSString *)text point:(CGPoint)point {

    [self showArrowTipsViewWithText:text maxWidth:self.width point:point];
}

- (void)showArrowTipsViewWithText:(NSString *)text maxWidth:(CGFloat)maxWidth point:(CGPoint)point {

    FDArrowTipsViewConfig *config = [FDArrowTipsViewConfig new];

    CGFloat showMaxWidth = MIN(maxWidth, self.width - config.contentEdgeInsets.left - config.contentEdgeInsets.right);
    YYLabel *label = [self __textLabelForArrowTipsView:text maxWidth:showMaxWidth];
    
    FDArrowTipsView *tipsView = [self showArrowTipsViewWithConfig:config withCustomView:label point:point];
    @weakify(tipsView);
    label.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(tipsView);
        [tipsView dismissTipsView];
    };
}

- (FDArrowTipsView *)showArrowTipsViewWithListConfig:(FDArrowCustomListViewConfig *)listConfig
                                       withTipConfig:(FDArrowTipsViewConfig *)tipConfig
                                           withPoint:(CGPoint)point
                                          clickBlock:(void(^)(NSInteger index))clickBlock {

    FDArrowCustomListView *listView = [[FDArrowCustomListView alloc] initWithFrame:CGRectMake(0, 0, 150, 0) withConfig:listConfig];
    FDArrowTipsView *tipsView = [self showArrowTipsViewWithConfig:tipConfig withCustomView:listView point:point];

    @weakify(tipsView);
    listView.clickBlock = ^(FDArrowCustomListView * _Nonnull morePopView, NSInteger index) {
        @strongify(tipsView);

        if (clickBlock) {
            clickBlock(index);
        }
        [tipsView dismissTipsView];
    };
    
    return tipsView;
}

#pragma mark - 带背景的显示方式

- (void)showArrowTipsBackgroundViewWithText:(NSString *)text point:(CGPoint)point {
    [self showArrowTipsBackgroundViewWithText:text maxWidth:self.width point:point];
}

- (void)showArrowTipsBackgroundViewWithText:(NSString *)text maxWidth:(CGFloat)maxWidth point:(CGPoint)point {

    FDArrowTipsViewConfig *config = [FDArrowTipsViewConfig new];

    YYLabel *label = [self __textLabelForArrowTipsView:text maxWidth:maxWidth];
    
    FDAnimationManagerView *managerView = [self showArrowTipsBackgroundViewWithConfig:config withCustomView:label point:point];
    @weakify(managerView);
    label.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        @strongify(managerView);
        FDArrowTipsView *tipsView = (FDArrowTipsView *)managerView.config.animationContainerView;
        [tipsView dismissTipsView];
    };
}

- (FDAnimationManagerView *)showArrowTipsBackgroundViewWithListConfig:(FDArrowCustomListViewConfig *)listConfig
                                       withTipConfig:(FDArrowTipsViewConfig *)tipConfig
                                           withPoint:(CGPoint)point
                                          clickBlock:(void(^)(NSInteger index))clickBlock {

    FDArrowCustomListView *listView = [[FDArrowCustomListView alloc] initWithFrame:CGRectMake(0, 0, 150, 0) withConfig:listConfig];
    FDAnimationManagerView *managerView = [self showArrowTipsBackgroundViewWithConfig:tipConfig withCustomView:listView point:point];

    @weakify(managerView);
    listView.clickBlock = ^(FDArrowCustomListView * _Nonnull morePopView, NSInteger index) {
        @strongify(managerView);

        if (clickBlock) {
            clickBlock(index);
        }
        FDArrowTipsView *tipsView = (FDArrowTipsView *)managerView.config.animationContainerView;
        [tipsView dismissTipsView];
    };
    
    return managerView;
}

- (FDAnimationManagerView *)showArrowTipsBackgroundViewWithConfig:(FDArrowTipsViewConfig *)config
                                  withCustomView:(UIView *)customView
                                           point:(CGPoint)point {
    
    FDArrowTipsView *tipsView = [[FDArrowTipsView alloc] initWithFrame:CGRectZero andConfig:config andCustomView:customView];
    [self __updatePositionWithTipsView:tipsView point:point];
    
    FDAnimationManagerViewConfig *animationConfig = [FDAnimationManagerViewConfig new];
    animationConfig.backgroundColor = [UIColor clearColor];
    animationConfig.isNeedAnimation = NO;
    animationConfig.animationContainerView = tipsView;
    animationConfig.managerType = FDAnimationManagerShowTypeMiddle;
    animationConfig.centerPoint = CGPointMake(CGRectGetMinX(tipsView.frame) + tipsView.width / 2.0f, CGRectGetMinY(tipsView.frame) + tipsView.height / 2.0f);
    FDAnimationManagerView *managerView = [[FDAnimationManagerView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) andConfig:animationConfig];
    [managerView showAnimationManagerView:nil];
    
    @weakify(tipsView);
    managerView.clickBackgroundBlock = ^(FDAnimationManagerView *animationView) {
        @strongify(tipsView);
        [tipsView dismissTipsView];
    };
    
    if (config.isStartTimer) {
        [tipsView startShowTimerWithTime:config.timeOutTime];
    }
    
    [tipsView startViewAnimation];
    
    @weakify(self, managerView);
    tipsView.actionBlock = ^(FDArrowTipsView * _Nonnull arrowTipsView, FDArrowTipsViewActionType actionType) {
        @strongify(self, managerView);
        LOGGO_INFO(@"actionType = %zd", actionType);
        switch (actionType) {
            case FDArrowTipsViewActionTypeSizeChange:
            {
                [self __updateAdjustTipsViewPosition:arrowTipsView point:point];
                break;
            }
            case FDArrowTipsViewActionTypeClick:
            {
                [arrowTipsView dismissTipsView];
                break;
            }
            case FDArrowTipsViewActionTypeWillRemove:
            {
                [managerView dismissAnimationManagerView:nil];
                break;
            }
            default:
                break;
        }
    };
    [self addSubview:managerView];
    return managerView;
}

- (FDArrowTipsView *)showArrowTipsViewWithConfig:(FDArrowTipsViewConfig *)config
                                  withCustomView:(UIView *)customView
                                           point:(CGPoint)point {
    FDArrowTipsView *view = [[FDArrowTipsView alloc] initWithFrame:CGRectZero andConfig:config andCustomView:customView];

    [self __updatePositionWithTipsView:view point:point];
    
    if (config.isStartTimer) {
        [view startShowTimerWithTime:config.timeOutTime];
    }
    
    [view startViewAnimation];
    
    @weakify(self);
    view.actionBlock = ^(FDArrowTipsView * _Nonnull arrowTipsView, FDArrowTipsViewActionType actionType) {
        @strongify(self);
        LOGGO_INFO(@"actionType = %zd", actionType);
        switch (actionType) {
            case FDArrowTipsViewActionTypeSizeChange:
            {
                [self __updateAdjustTipsViewPosition:arrowTipsView point:point];
                break;
            }
            case FDArrowTipsViewActionTypeClick:
            {
                [arrowTipsView dismissTipsView];
                break;
            }
            default:
                break;
        }
    };
    [self addSubview:view];
    return view;
}

- (void)__updatePositionWithTipsView:(FDArrowTipsView *)view point:(CGPoint)point {
    if (view.viewConfig.autoAdjustPos) {
        LOGGO_INFO(@">>>自动调整开始");
        if ([self __isNeedChangeDirection:view point:point]) {
            
        }
    }
    
    BOOL isSpecialHandle = [self __updateAdjustTipsViewPosition:view point:point];
    if ( !isSpecialHandle && 0.0 != view.viewConfig.fixedOffset) {
        [self __updateTipsViewPositionWithFixedOffset:view point:point];
    }
}

- (BOOL)__updateAdjustTipsViewPosition:(FDArrowTipsView *)tipsView point:(CGPoint)point {
    BOOL isSpecialHandle = NO;
    LOGGO_INFO(@">>>更新tipsView坐标，direction = %zd", tipsView.direction);
    switch (tipsView.direction) {
        case FDArrowDirection_Top:
        case FDArrowDirection_Bottom:
        {
            // 水平方向自动调整
            CGSize viewSize = tipsView.size;
            CGFloat allLength = viewSize.width;
            CGFloat defaultCenter = allLength / 2.0f;
            // 根据point在水平三个区域调整箭头位置
            CGFloat offset = point.x;
            if (offset < allLength / 2.0f) {
                tipsView.left = 0;
                defaultCenter = offset;
                isSpecialHandle = YES;
            } else if (offset > self.width - allLength / 2.0f) {
                tipsView.left = self.width - allLength;
                defaultCenter = tipsView.left + offset;
                isSpecialHandle = YES;
            } else {
                tipsView.left = offset - allLength / 2.0f;
            }
            tipsView.arrowCenterXOffset = defaultCenter;
            
            // 根据point在垂直三个区域处理箭头指向
            if (point.y < viewSize.height) {
                tipsView.top = point.y;
            } else if (point.y > self.height - viewSize.height) {
                tipsView.top = point.y - viewSize.height;
            } else {
                tipsView.top = point.y;
            }
            break;
        }
        case FDArrowDirection_Left:
        case FDArrowDirection_Right:
        {
            // 垂直方向自动调整
            CGSize viewSize = tipsView.size;
            CGFloat defaultCenter = viewSize.height / 2.0f;
            // 根据point在水平三个区域调整箭头位置
            if (point.y < viewSize.height / 2.0f) {
                tipsView.top = 0;
                defaultCenter = point.y;
                isSpecialHandle = YES;
            } else if (point.y > self.height - viewSize.height / 2.0f) {
                tipsView.top = self.height - viewSize.height;
                defaultCenter =  point.y - tipsView.top;
                isSpecialHandle = YES;
            } else {
                tipsView.top = point.y - viewSize.height / 2.0f;
            }
            tipsView.arrowCenterYOffset = defaultCenter;
            
            // 根据point在垂直三个区域处理箭头指向
            if (point.x < viewSize.width) {
                tipsView.left = point.x;
            } else if (point.x > self.width - viewSize.width) {
                tipsView.left = point.x - viewSize.width;
            } else {
                tipsView.left = point.x;
            }
            break;
        }
        default:
            break;
    }
    return isSpecialHandle;
}

- (void)__updateTipsViewPositionWithFixedOffset:(FDArrowTipsView *)tipsView point:(CGPoint)point {
    LOGGO_INFO(@">>>根据固定偏移更新坐标，direction = %zd", tipsView.direction);
    CGFloat offset = tipsView.viewConfig.fixedOffset;
    CGFloat width = tipsView.viewConfig.contentCornerRadius + gArrowTipsViewMarginOffset;
    switch (tipsView.direction) {
        case FDArrowDirection_Top:
        {
            width += tipsView.viewConfig.arrowSize.width / 2.0f;
            CGFloat arrowCenterXOffset = ArrowTipsViewZoneInOffset(offset, width, tipsView.width - width);
            tipsView.top = point.y;
            tipsView.left = point.x - arrowCenterXOffset;
            tipsView.arrowCenterXOffset = arrowCenterXOffset;
            break;
        }
        case FDArrowDirection_Bottom:
        {
            CGFloat arrowCenterXOffset = ArrowTipsViewZoneInOffset(offset, width, tipsView.width - width);
            tipsView.top = point.y - tipsView.height;
            tipsView.left = point.x - arrowCenterXOffset;
            tipsView.arrowCenterXOffset = arrowCenterXOffset;
            break;
        }
        case FDArrowDirection_Left:
        {
            width += tipsView.viewConfig.arrowSize.height / 2.0f;
            CGFloat arrowCenterYOffset = ArrowTipsViewZoneInOffset(offset, width, tipsView.height - width);
            tipsView.left = point.x;
            tipsView.top = point.y - arrowCenterYOffset;
            tipsView.arrowCenterYOffset = arrowCenterYOffset;
            break;
        }
        case FDArrowDirection_Right:
        {
            width += tipsView.viewConfig.arrowSize.height / 2.0f;
            CGFloat arrowCenterYOffset = ArrowTipsViewZoneInOffset(offset, width, tipsView.height - width);
            tipsView.left = point.x - tipsView.width;
            tipsView.top = point.y - arrowCenterYOffset;
            tipsView.arrowCenterYOffset = arrowCenterYOffset;
            break;
        }
        default:
            break;
    }
}

/// 是否位于四个死角的位置（点位于死角事，没办法对其自动纠正箭头指向，需要排除掉）
/// @param tipsView 箭头view
/// @param point 当前点的位置
- (BOOL)__isDeadAngleInSuperView:(FDArrowTipsView *)tipsView point:(CGPoint)point {
    CGFloat border = 1;
    CGFloat width = tipsView.viewConfig.contentCornerRadius + gArrowTipsViewMarginOffset + 2 * border;
    CGRect leftTopCorner = CGRectMake(-border, -border, width, width);
    CGRect leftBottomCorner = CGRectMake(-border, self.height - width + border, width, width);
    CGRect rightTopCorner = CGRectMake(self.width - width - border, -border, width, width);
    CGRect rightBottomCorner = CGRectMake(self.width - width - border, self.height - width + border, width, width);
    if (CGRectContainsPoint(leftTopCorner, point) ||
        CGRectContainsPoint(rightTopCorner, point) ) {
        LOGGO_INFO(@">>>点位于死角, 默认方向 上");
        tipsView.direction = FDArrowDirection_Top;
        return YES;
    } else if (CGRectContainsPoint(leftBottomCorner, point) || CGRectContainsPoint(rightBottomCorner, point) ) {
        LOGGO_INFO(@">>>点位于死角, 默认方向 下");
        tipsView.direction = FDArrowDirection_Bottom;
        return YES;
    }
    return NO;
}

- (BOOL)__isNeedChangeDirection:(FDArrowTipsView *)tipsView point:(CGPoint)point {
    
    if ([self __isDeadAngleInSuperView:tipsView point:point]) {
        return NO;
    }
    BOOL result = NO;
    CGFloat width = tipsView.viewConfig.contentCornerRadius + gArrowTipsViewMarginOffset;
    CGRect leftSpecialZone = CGRectMake(0, 0, width, self.height);
    CGRect rightSpecialZone = CGRectMake(self.width - width, 0, width, self.height);
    CGRect topSpecialZone = CGRectMake(0, 0, self.width, width);
    CGRect bottomSpecialZone = CGRectMake(0, self.height - width, self.width, width);
    
    switch (tipsView.direction) {
        case FDArrowDirection_Top:
        {
            if (CGRectContainsPoint(leftSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Left;
                LOGGO_INFO(@">>>需要变更方向 上--->左");
            } else if ( CGRectContainsPoint(rightSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Right;
                LOGGO_INFO(@">>>需要变更方向 上--->右");
            } else if ( CGRectContainsPoint(bottomSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Bottom;
                LOGGO_INFO(@">>>需要变更方向 上--->下");
            }
            break;
        }
        case FDArrowDirection_Bottom:
        {
            if (CGRectContainsPoint(leftSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Left;
                LOGGO_INFO(@">>>需要变更方向 下--->左");
            } else if ( CGRectContainsPoint(rightSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Right;
                LOGGO_INFO(@">>>需要变更方向 下--->右");
            } else if ( CGRectContainsPoint(topSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Bottom;
                LOGGO_INFO(@">>>需要变更方向 下--->上");
            }
            break;
        }
        case FDArrowDirection_Left:
        {
            if (CGRectContainsPoint(topSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Top;
                LOGGO_INFO(@">>>需要变更方向 左--->上");
            } else if ( CGRectContainsPoint(bottomSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Bottom;
                LOGGO_INFO(@">>>需要变更方向 左--->下");
            } else if ( CGRectContainsPoint(rightSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Right;
                LOGGO_INFO(@">>>需要变更方向 左--->右");
            }
            break;
        }
        case FDArrowDirection_Right:
        {
            if (CGRectContainsPoint(topSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Top;
                LOGGO_INFO(@">>>需要变更方向 右--->上");
            } else if ( CGRectContainsPoint(bottomSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Bottom;
                LOGGO_INFO(@">>>需要变更方向 右--->下");
            } else if ( CGRectContainsPoint(leftSpecialZone, point) ) {
                result = YES;
                tipsView.direction = FDArrowDirection_Left;
                LOGGO_INFO(@">>>需要变更方向 右--->左");
            }
            break;
        }
        default:
            break;
    }
    return result;
}

- (YYLabel *)__textLabelForArrowTipsView:(NSString *)text maxWidth:(CGFloat)maxWidth {
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text];
    attText.yy_font = FONT_REGULAR_WITH_SIZE(15);
    attText.yy_color = [UIColor whiteColor];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [attText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) insets:UIEdgeInsetsZero];
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attText];
    
    YYLabel *label = [[YYLabel alloc] init];
    label.displaysAsynchronously = YES;
    label.fadeOnAsynchronouslyDisplay = NO;
    label.fadeOnHighlight = NO;
    
    label.textLayout = layout;
    label.size = layout.textBoundingSize;
    return label;
}

@end
