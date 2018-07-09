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

@property (weak, nonatomic) IBOutlet UILabel *msgLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self showArrowTipsView1];
    [self showArrowTipsView2];
    [self showArrowTipsView3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showArrowTipsView1 {
    
    CGFloat interval = 10;
    CGRect frame = self.msgLabel.frame;
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

- (void)showArrowTipsView2 {
    
    CGPoint point = CGPointMake(150, 100);
    XXArrowTipsViewConfigs *configs = [[XXArrowTipsViewConfigs alloc] init];
    configs.titleText = @"箭头展示，文字方向等自由设置;";
    configs.arrowDirection = XXArrowDirection_Top;
    
    XXArrowTipsView *arrowView = [XXArrowTipsView showInSuperView:self.view point:point configs:configs];
    [arrowView startViewAnimation:5 block:^(XXArrowTipsView *view) {

        NSLog(@"动画结束");
        //[view removeFromSuperview];
    }];
}

- (void)showArrowTipsView3 {
    
    CGPoint point = CGPointMake(300, 200);
    XXArrowTipsViewConfigs *configs = [[XXArrowTipsViewConfigs alloc] init];
    configs.titleText = @"箭头的文字，不过目前有最长的限制";
    configs.arrowDirection = XXArrowDirection_Bottom;
    
    [XXArrowTipsView showInSuperView:self.view point:point configs:configs];
}

@end
