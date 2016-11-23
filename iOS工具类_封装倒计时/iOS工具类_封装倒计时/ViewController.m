//
//  ViewController.m
//  iOS工具类_封装倒计时
//
//  Created by ZengSanchain on 2016/11/22.
//  Copyright © 2016年 ziFei. All rights reserved.
//

#import "ViewController.h"
#import "ZFTimerManager.h"


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

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[ZFTimerManager defaultManager] dismissTimer];
}



- (IBAction)btnAction:(UIButton *)sender {
    
    /**
     *  获取验证码后调用以下方法
     */
    
    // 1.触发倒计时定时器
    [[ZFTimerManager defaultManager] dismissTimer];
    [ZFTimerManager defaultManager].countdownInterval = 60.0f;
    [[ZFTimerManager defaultManager] touchCountdownTimerWithTimeInterval:1.0 btn:sender];
    
    // 2.触发验证码超时定时器
    [ZFTimerManager defaultManager].timeoutInterval = 2 * 60.0f;
    [[ZFTimerManager defaultManager] touchTimeoutTimerWithTimeInterval:1.0 btn:sender];
    
}
@end
