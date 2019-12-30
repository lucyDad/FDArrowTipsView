# 效果
![](./demo.png)

# 介绍
FDArrowTipsView是带有箭头指向的提示view，箭头指向有上下左右四个方向，分别可以自定义指定，同时中间内容展示部分的view也可自定义。该工程提供了便捷的文本内容的箭头view和带列表选项内容的箭头view，同时也提供了方便点击空白处取消当前箭头view的带有背景的方法，用户可根据具体的使用场景设置不同的配置选项进行使用。

# 使用方法

UIView+ArrowTipsView.h为方便view直接添加箭头view的分类，包含的方法有：

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

同时以上函数均提供带背景的类似方法

## 配置选项

目前开放的可配置选项:

1. @property (nonatomic, assign) CGFloat  contentCornerRadius; ///> 整个内容view的圆角, 默认10
2. @property (nonatomic, assign) UIEdgeInsets  contentEdgeInsets;  ///> 内容view的间距（默认[10,10,10,10]）
3. @property (nonatomic, strong) UIColor *gradientBeginColor; // 默认从左到右渐变 (想要纯色的话，渐变颜色设置相同即可)
4. @property (nonatomic, strong) UIColor *gradientEndColor;
5. @property (nonatomic, assign) CGPoint  gradientBeginPoint;  ///> 渐变开始点，默认[0, 0]
6. @property (nonatomic, assign) CGPoint  gradientEndPoint;    ///> 渐变结束点，默认[0, 1]
7. @property (nonatomic, assign) FDArrowDirection  originDirection;    ///> 初始的箭头指向，默认top
8. @property (nonatomic, assign) CGSize  arrowSize;    ///> 渐变结束点，默认[10, 10]
9. @property (nonatomic, assign) BOOL  autoAdjustPos;  ///> 是否自动调整显示位置（默认NO）
10. @property (nonatomic, assign) BOOL  autoTimeOutClose;  ///> 是否超时自动关闭（默认YES）
11. @property (nonatomic, assign) BOOL  isStartTimer;   ///> 是否启动定时器（默认NO）
12. @property (nonatomic, assign) NSInteger  timeOutTime;   ///> 定时器超时的时长（默认3s）
13. @property (nonatomic, assign) CGFloat  animationTime;   ///> 动画的时长（默认0.5s）
14. @property (nonatomic, assign) CGFloat  fixedOffset; ///> 默认0.0, 设置了此值的话,如果point在正常范围内，则箭头偏移为固定值


