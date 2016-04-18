//
//  ViewController.m
//  RingProgressView
//
//  Created by 9188iMac on 16/4/15.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "ViewController.h"
#import "CCRingView.h"
#import "CCGradientView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet CCRingView *ringView;
@property (weak, nonatomic) IBOutlet CCGradientView *gradientView;
@property (nonatomic, strong) NSTimer *timer;

- (IBAction)start:(id)sender;
- (IBAction)clear:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gradientView.startAngle = -(M_PI / 2);
    self.gradientView.endAngle = M_PI * 6 / 4;
    self.gradientView.lineWidth = 20;
    self.gradientView.progress = 0.0;
    self.gradientView.colorArr = @[[UIColor redColor], [UIColor grayColor], [UIColor whiteColor]];
/*  
    // 环形图
    self.ringView.ratioArr = @[@(0.2), @(0.3), @(0.4), @(0.1)];
    self.ringView.colorArr = @[[UIColor redColor], [UIColor yellowColor], [UIColor grayColor], [UIColor magentaColor]];
    self.ringView.startAngle = -M_PI_2;
    self.ringView.endAngle = M_PI * 2 * 3 / 4;
    self.ringView.radius = 100;
    self.ringView.ringWidth = 20;
    self.ringView.duration = 4;
 */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
//    [self.ringView startAnimation];
    [self.gradientView start];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setUpProgress) userInfo:nil repeats:YES];
}

- (IBAction)clear:(id)sender {
    [self.ringView clearAnimation];
}

#pragma mark - 设置进度
- (void)setUpProgress{
    self.gradientView.progress += 0.1;
    if (self.gradientView.progress >= 1.0) {
        self.gradientView.progress = 1.0;
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
