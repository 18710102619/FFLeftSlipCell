//
//  FFLeftSlipCell.h
//  FFLeftSlipCell
//
//  Created by 张玲玉 on 16/8/17.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLeftSlipView.h"

#define kMainScreen_Width [[UIScreen mainScreen] bounds].size.width

#define kLeftSlipCell_Height 80
#define kCollectButton_Width 100

#define kAddPanGestureRecognizer @"leftSlipView_addPanGestureRecognizer"
#define kRemovePanGestureRecognizer @"leftSlipView_removePanGestureRecognizer"

@class FFLeftSlipCell;
@protocol FFLeftSlipCellDelegate <NSObject>

- (void)setScrollEnabled:(BOOL)scrollEnabled;
- (void)openLeftSlipCell:(FFLeftSlipCell *)cell;

@end

@interface FFLeftSlipCell : UITableViewCell<UIGestureRecognizerDelegate>

@property(nonatomic, weak)id <FFLeftSlipCellDelegate> delegate;
@property(nonatomic, strong)UIButton *collectButton;
@property(nonatomic, strong)FFLeftSlipView *leftSlipView;
@property(nonatomic, strong)UITapGestureRecognizer *tapGesture;
@property(nonatomic, strong)UIPanGestureRecognizer *panGesture;

@property(nonatomic, assign)CGPoint startPoint;
@property(nonatomic, assign)CGFloat startRight;
@property(nonatomic, assign)CGFloat slideWidth;
@property(nonatomic, assign)double gapRight;
@property(nonatomic, assign)BOOL isOpen;

- (void)panGesture:(UIPanGestureRecognizer *)recognizer;
- (void)tapGesture:(UITapGestureRecognizer *)recognizer;

- (void)openLeftSlipCell:(BOOL)isAnimation;
- (void)closeLeftSlipCell:(BOOL)isAnimation;

@end
