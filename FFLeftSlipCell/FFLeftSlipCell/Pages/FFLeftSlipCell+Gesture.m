//
//  FFLeftSlipCell+Gesture.m
//  FFLeftSlipCell
//
//  Created by 张玲玉 on 16/8/17.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFLeftSlipCell+Gesture.h"
#import "UIView+Extension.h"

/// 弹力值
static const CGFloat kBounceValue = 20.0f;
/// 动效时间
static const CGFloat kDurationTime = 0.3f;

@implementation FFLeftSlipCell (Gesture)

- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    [self closeLeftSlipCell:YES];
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer
{
    self.collectButton.hidden=NO;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.startPoint = [recognizer translationInView:self.leftSlipView];
            self.startRight = self.gapRight;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if ([self.delegate respondsToSelector:@selector(setScrollEnabled:)]) {
                [self.delegate setScrollEnabled:NO];
            }
            CGPoint point = [recognizer translationInView:self.leftSlipView];
            if (self.startRight == 0) {
                CGFloat disRight = -(point.x - self.startPoint.x);
                if (disRight>0) {
                    CGFloat minX = MIN(disRight, self.slideWidth);
                    if (minX == self.slideWidth) {
                        [self openLeftSlipCell:YES];
                    } else {
                        self.gapRight = minX;
                        self.leftSlipView.x=-self.gapRight;
                    }
                }
            }
            else {
                CGFloat disRight = point.x - self.startPoint.x;
                if (disRight>0) {
                    CGFloat disLeft = self.startRight - disRight;
                    CGFloat maxX = MAX(disLeft, 0);
                    if (maxX == 0) {
                        [self closeLeftSlipCell:YES];
                    } else {
                        self.gapRight = maxX;
                        self.leftSlipView.x=-self.gapRight;
                    }
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if ([self.delegate respondsToSelector:@selector(setScrollEnabled:)]) {
                [self.delegate setScrollEnabled:YES];
            }
            if (self.startRight == 0) {
                CGFloat w = CGRectGetWidth(self.collectButton.frame) * 1/3.0;
                if (self.gapRight > w) {
                    [self openLeftSlipCell:YES];
                } else {
                    [self closeLeftSlipCell:YES];
                }
            } else {
                CGFloat w = CGRectGetWidth(self.collectButton.frame) * 2/3.0;
                if (self.gapRight > w) {
                    [self openLeftSlipCell:YES];
                } else {
                    [self closeLeftSlipCell:YES];
                }
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            if ([self.delegate respondsToSelector:@selector(setScrollEnabled:)]) {
                [self.delegate setScrollEnabled:YES];
            }
            if (self.startRight == 0) {
                [self closeLeftSlipCell:YES];
            } else {
                [self openLeftSlipCell:YES];
            }
            break;
        }
        default:
        {
            if ([self.delegate respondsToSelector:@selector(setScrollEnabled:)]) {
                [self.delegate setScrollEnabled:YES];
            }
            break;
        }
    }
}

- (void)openLeftSlipCell:(BOOL)isAnimation
{
    if (self.gapRight == self.slideWidth && self.startRight == self.slideWidth) {
        return;
    }
    self.isOpen=YES;
    if ([self.delegate respondsToSelector:@selector(openLeftSlipCell:)]) {
        [self.delegate openLeftSlipCell:self];
    }
    
    CGFloat duration=kDurationTime;
    if (isAnimation==NO) {
        duration=0;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.gapRight = self.slideWidth + kBounceValue;
        self.leftSlipView.x=-self.gapRight;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.gapRight = self.slideWidth;
            self.leftSlipView.x=-self.gapRight;
            
        } completion:^(BOOL finished) {
            self.startRight = self.slideWidth;
            [self.leftSlipView addGestureRecognizer:self.tapGesture];
        }];
    }];
}

- (void)closeLeftSlipCell:(BOOL)isAnimation
{
    if (self.gapRight == 0 && self.startRight == 0) {
        return;
    }
    self.isOpen=NO;
    
    CGFloat duration=kDurationTime;
    if (isAnimation==NO) {
        duration=0;
    }
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.gapRight = -kBounceValue;
        self.leftSlipView.x=-self.gapRight;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.gapRight = 0;
            self.leftSlipView.x=-self.gapRight;
            
        } completion:^(BOOL finished) {
            self.startRight = 0;
            [self.leftSlipView removeGestureRecognizer:self.tapGesture];
        }];
    }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
