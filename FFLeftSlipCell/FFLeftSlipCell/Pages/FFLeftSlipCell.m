//
//  FFLeftSlipCell.m
//  FFLeftSlipCell
//
//  Created by 张玲玉 on 16/8/17.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFLeftSlipCell.h"

@interface FFLeftSlipCell ()

@end

@implementation FFLeftSlipCell

/// 当前已经被分配的cell如果被重用
- (void)prepareForReuse
{
    [super prepareForReuse];
    [self closeLeftSlipCell:NO];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor magentaColor];
        self.slideWidth=kCollectButton_Width;
        
        _collectButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _collectButton.backgroundColor=[UIColor yellowColor];
        _collectButton.frame=CGRectMake(kMainScreen_Width-kCollectButton_Width, 0, kCollectButton_Width, kLeftSlipCell_Height);
        [self addSubview:_collectButton];
        
        _leftSlipView=[[FFLeftSlipView alloc]init];
        _leftSlipView.backgroundColor=[UIColor whiteColor];
        _leftSlipView.frame=CGRectMake(0, 0, kMainScreen_Width, kLeftSlipCell_Height);
        [_leftSlipView addGestureRecognizer:self.panGesture];
        [self addSubview:_leftSlipView];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addPanGestureRecognizer) name:kAddPanGestureRecognizer object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removePanGestureRecognizer) name:kRemovePanGestureRecognizer object:nil];
    }
    return self;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (_tapGesture==nil) {
        _tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        _tapGesture.numberOfTapsRequired=1;
        _tapGesture.numberOfTouchesRequired=1;
    }
    return _tapGesture;
}

- (UIPanGestureRecognizer *)panGesture
{
    if (_panGesture==nil) {
        _panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (void)addPanGestureRecognizer
{
    [self.leftSlipView addGestureRecognizer:self.panGesture];
}

- (void)removePanGestureRecognizer
{
    [self.leftSlipView removeGestureRecognizer:self.panGesture];
}

@end
