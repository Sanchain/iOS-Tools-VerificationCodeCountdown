//
//  ZFTimerManager.m
//  游来游去
//
//  Created by ZengSanchain on 2016/11/22.
//  Copyright © 2016年 ziFei. All rights reserved.
//

#import "ZFTimerManager.h"

@interface ZFTimerManager ()
@property (strong, nonatomic) NSTimer *countdownTimer; /**< 倒计时定时器 */
@property (strong, nonatomic) NSTimer *timeoutTimer; /**< 验证码超时定时器 */
@property (copy, nonatomic) UIButton *deltaBtn; /**< 点击获取验证码的按钮 */
@property (assign, nonatomic) NSInteger cdDeltaTimeinterval; /**< 倒计时设置的固定时长 */
@property (assign, nonatomic) NSInteger timeoutDeltaTimeinterval; /**< 验证码设置的固定时长 */

@end

@implementation ZFTimerManager

+ (instancetype)defaultManager {
    
    static ZFTimerManager *timerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[ZFTimerManager alloc] init];
    });
    return timerManager;
}


- (void)touchCountdownTimerWithTimeInterval:(NSTimeInterval)timeInterval btn:(UIButton *)btn {
    
    if ([self.countdownTimer isValid]) {
        [self.countdownTimer invalidate];
    }
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(countdownAction) userInfo:nil repeats:YES];
    _deltaBtn = btn;
    _cdDeltaTimeinterval = self.countdownInterval;
}

- (void)touchTimeoutTimerWithTimeInterval:(NSTimeInterval)timeInterval btn:(UIButton *)btn {
    
    if ([self.timeoutTimer isValid]) {
        [self.timeoutTimer invalidate];
    }
    self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeoutAction) userInfo:nil repeats:YES];
    _deltaBtn = btn;
    _timeoutDeltaTimeinterval = 0;
    
}


- (void)dismissTimeoutTimer {
    
    if ([self.timeoutTimer isValid]) {
        [self.timeoutTimer invalidate];
    }
}

- (void)dismissConutdownTimer {
    
    if ([self.countdownTimer isValid]) {
        [self.countdownTimer invalidate];
    }
}

- (void)dismissTimer {

    if ([self.timeoutTimer isValid]) {
        [self.timeoutTimer invalidate];
    }
    if ([self.countdownTimer isValid]) {
        [self.countdownTimer invalidate];
    }
}


#pragma mark - Private

- (void)countdownAction {
    
    if (self.countdownInterval == 0) {
        [self dismissConutdownTimer];
        _deltaBtn.userInteractionEnabled = YES;
        [_deltaBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
//        _endCountdown = YES;
        self.countdownInterval = _cdDeltaTimeinterval;
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *str = [NSString stringWithFormat:@"%02ld秒后重新获取", (long)_countdownInterval--];
            _deltaBtn.userInteractionEnabled = NO;
            [_deltaBtn setTitle:str forState:UIControlStateNormal];
        });
    }
}

- (void)timeoutAction {
    
    self.timeoutDeltaTimeinterval++;
    NSLog(@"验证码失效计时 ： %ld", self.timeoutDeltaTimeinterval);
    if (self.timeoutDeltaTimeinterval > self.timeoutInterval) {
        self.timeoutDeltaTimeinterval = 0;
        self.timeoutResult = YES;
        [self dismissTimeoutTimer];
//        [SVProgressHUD showInfoWithStatus:@"验证码已超时，请重新获取"];
    }
}

@end
