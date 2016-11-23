//
//  ZFTimerManager.h
//  游来游去
//
//  Created by ZengSanchain on 2016/11/22.
//  Copyright © 2016年 ziFei. All rights reserved.
//  定时器管理：触发倒计时定时器、验证码超时定时器、返回超时结果、返回倒计时结束结果


/**
 *
 *  使用方法：
    1.触发倒计时定时器
     [[ZFTimerManager defaultManager] dismissTimer];
     [ZFTimerManager defaultManager].countdownInterval = 60.0f;
     [[ZFTimerManager defaultManager] touchCountdownTimerWithTimeInterval:1.0 btn:btn];
 
    2.触发验证码超时定时器
     [ZFTimerManager defaultManager].timeoutInterval = 2 * 60.0f;
     [[ZFTimerManager defaultManager] touchTimeoutTimerWithTimeInterval:1.0 btn:btn];
 
    3.离开当前页面时,销毁两个定时器
     [[ZFTimerManager defaultManager] dismissTimer];
 */




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZFTimerManager : NSObject

//@property (assign, nonatomic) BOOL endCountdown; /**< 倒计时结束的结果 */
@property (assign, nonatomic) BOOL timeoutResult; /**< 验证码超时的结果 */
@property (assign, nonatomic) NSInteger countdownInterval; /**< 倒计时的时长：如倒计时60秒 */
@property (assign, nonatomic) NSInteger timeoutInterval; /**< 验证码超时的时长：如120秒 */
+ (instancetype)defaultManager;


/**
 *  触发倒计时定时器
 */
- (void)touchCountdownTimerWithTimeInterval:(NSTimeInterval)timeInterval btn:(UIButton *)btn;


/**
 *  触发超时定时器
 */
- (void)touchTimeoutTimerWithTimeInterval:(NSTimeInterval)timeInterval btn:(UIButton *)btn;


/**
 *  销毁倒讲时定时器
 */
- (void)dismissConutdownTimer;


/**
 *  销毁超时定时器
 */
- (void)dismissTimeoutTimer;

/**
 *  销毁两种定时器
 */
- (void)dismissTimer;

@end
