//
//  ViewController.m
//  xxdemo
//
//  Created by hexiang on 2018/7/6.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "XXArrowTipsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showArrowAction:(UIButton *)sender {
    
    CGFloat interval = 10;
    CGRect frame = sender.frame;
    CGPoint point = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height + interval);
    XXArrowTipsViewConfigs *configs = [[XXArrowTipsViewConfigs alloc] init];
    configs.titleText = @"箭头展示，文字方向等自由设置";
    configs.arrowDirection = XXArrowDirection_Top;
    configs.gradientColors = @[[UIColor redColor], [UIColor greenColor]];
    XXArrowTipsView *arrowView = [XXArrowTipsView showInSuperView:self.view point:point configs:configs];
    arrowView.pressBlock = ^(XXArrowTipsView *view) {
        [view removeFromSuperview];
    };
}

- (IBAction)showArrowAnimationAction:(UIButton *)sender {
    
    CGFloat interval = 10;
    CGRect frame = sender.frame;
    CGPoint point = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height + interval);
    XXArrowTipsViewConfigs *configs = [[XXArrowTipsViewConfigs alloc] init];
    configs.titleText = @"箭头展示，文字方向等自由设置;箭头展示，文字方向等自由设置;箭头展示，文字方向等自由设置;箭头展示，文字方向等自由设置";
    configs.arrowDirection = XXArrowDirection_Bottom;
    
    XXArrowTipsView *arrowView = [XXArrowTipsView showInSuperView:self.view point:point configs:configs];
    [arrowView startViewAnimation:^(XXArrowTipsView *view) {

        NSLog(@"动画结束");
        //[view removeFromSuperview];
    }];
}

- (IBAction)showArrowLevelAction:(UIButton *)sender {
    
    CGFloat interval = 10;
    CGRect frame = [sender.superview convertRect:sender.frame toView:self.view];
    CGPoint point = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height + interval);
    XXArrowTipsViewConfigs *configs = [[XXArrowTipsViewConfigs alloc] init];
    configs.titleText = @"箭头展示，文字方向等自由设置";
    configs.arrowDirection = XXArrowDirection_Bottom;
    
    [XXArrowTipsView showInSuperView:self.view point:point configs:configs];
}

@end
