//
//  FDArrowTipsView.h
//  FunnyRecord
//
//  Created by hexiang on 2019/12/3.
//  Copyright © 2019 HeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN CGFloat const gArrowTipsViewMarginOffset;

typedef NS_ENUM(NSInteger, FDArrowDirection) {
    FDArrowDirection_Top,
    FDArrowDirection_Bottom,
    FDArrowDirection_Left,
    FDArrowDirection_Right,
};

@interface FDArrowTipsViewConfig : NSObject

@property (nonatomic, assign) CGFloat  contentCornerRadius; ///> 整个内容view的圆角, 默认10
@property (nonatomic, assign) UIEdgeInsets  contentEdgeInsets;  ///> 内容view的间距（默认[10,10,10,10]）

// 默认从左到右渐变 (想要纯色的话，渐变颜色设置相同即可)
@property (nonatomic, strong) UIColor *gradientBeginColor;
@property (nonatomic, strong) UIColor *gradientEndColor;
@property (nonatomic, assign) CGPoint  gradientBeginPoint;  ///> 渐变开始点，默认[0, 0]
@property (nonatomic, assign) CGPoint  gradientEndPoint;    ///> 渐变结束点，默认[0, 1]
@property (nonatomic, assign) FDArrowDirection  originDirection;    ///> 初始的箭头指向，默认top
@property (nonatomic, assign) CGSize  arrowSize;    ///> 渐变结束点，默认[10, 10]

@property (nonatomic, assign) BOOL  autoAdjustPos;  ///> 是否自动调整显示位置（默认YES）
@property (nonatomic, assign) BOOL  autoTimeOutClose;  ///> 是否超时自动关闭（默认YES）
@property (nonatomic, assign) BOOL  isStartTimer;   ///> 是否启动定时器（默认NO）
@property (nonatomic, assign) CGFloat  animationTime;   ///> 动画的时长（默认0.5s）

@property (nonatomic, assign) CGFloat  fixedOffset; ///> 默认0.0, 设置了此值的话,如果point在正常范围内，则箭头偏移为固定值

@end

typedef NS_ENUM(NSUInteger, FDArrowTipsViewActionType) {
    FDArrowTipsViewActionTypeClick,
    FDArrowTipsViewActionTypeTimeOut,
    FDArrowTipsViewActionTypeAnimationEnd,
    FDArrowTipsViewActionTypeSizeChange,
    FDArrowTipsViewActionTypeWillRemove,
};

@class FDArrowTipsView;
typedef void(^arrowTipsViewActionBlock)(FDArrowTipsView *arrowTipsView, FDArrowTipsViewActionType actionType);

@interface FDArrowTipsView : UIView

- (instancetype)initWithFrame:(CGRect)frame andConfig:(FDArrowTipsViewConfig *)config andCustomView:(UIView *)customView;

@property (nonatomic, strong, readonly) FDArrowTipsViewConfig *viewConfig;
@property (nonatomic, assign) CGFloat  arrowCenterXOffset;
@property (nonatomic, assign) CGFloat  arrowCenterYOffset;
@property (nonatomic, assign) FDArrowDirection  direction;

@property (nonatomic, strong) arrowTipsViewActionBlock actionBlock;

- (void)startShowTimerWithTime:(NSTimeInterval)time;

- (void)startViewAnimation;

- (void)dismissTipsView;

@end

NS_ASSUME_NONNULL_END
