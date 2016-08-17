//
//  FFTableViewController.m
//  FFLeftSlipCell
//
//  Created by 张玲玉 on 16/8/17.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFTableViewController.h"
#import "FFLeftSlipCell.h"
#import "FFSecondViewController.h"

@interface FFTableViewController ()<FFLeftSlipCellDelegate>

@property(nonatomic,strong)FFLeftSlipCell *lastLeftSlipCell;

@end

@implementation FFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
}

#pragma - mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer=@"leftSlipCell";
    FFLeftSlipCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[FFLeftSlipCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.delegate=self;
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld cell",(long)indexPath.row];
    return cell;
}

#pragma - mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kLeftSlipCell_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFLeftSlipCell *cell = (FFLeftSlipCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.isOpen==YES) {
        [cell closeLeftSlipCell:YES];
    }
    else {
        FFSecondViewController *vc=[[FFSecondViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kRemovePanGestureRecognizer object:nil];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kAddPanGestureRecognizer object:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kAddPanGestureRecognizer object:nil];
}

#pragma mark - FFLeftSlipCellDelegate

- (void)setScrollEnabled:(BOOL)isEnabled
{
    self.tableView.scrollEnabled=isEnabled;
}

- (void)openLeftSlipCell:(FFLeftSlipCell *)cell
{
    if (self.lastLeftSlipCell.isOpen==YES && cell!=self.lastLeftSlipCell) {
        [self.lastLeftSlipCell closeLeftSlipCell:YES];
    }
    self.lastLeftSlipCell=cell;
}

@end
