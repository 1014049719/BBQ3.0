//
//  BBQNewTaskTableViewCell.m
//  BBQ
//
//  Created by anymuse on 15/12/23.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNewTaskTableViewCell.h"
#import "BBQTaskModel.h"
#import "BBQTaskGoods.h"
@interface BBQNewTaskTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation BBQNewTaskTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 1. 可重用标示符
    static NSString *ID = @"taskCell";
    // 2. tableView查询可重用Cell
    BBQNewTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBQNewTaskTableViewCell" owner:nil options:nil] lastObject];
    }
    // 点击cell的时候不要变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backView.layer.masksToBounds = YES;
    cell.backView.layer.cornerRadius = 5.0;
    cell.finishButton.layer.cornerRadius = 15.0;
    return cell;
}
-(void)setTaskno:(NSInteger)taskno{
    _taskno = taskno;
    if (TheCurUser.taskArr.count >taskno) {
        BBQTaskModel *taskModel = TheCurUser.taskArr[taskno];
        NSString *goodsStr = [NSString string];
        for (BBQTaskGoods *goods in taskModel.goodsarr) {
            goodsStr = [goodsStr stringByAppendingString:[NSString stringWithFormat:@"%@%@ ",goods.num,goods.goodsname]];
        }
        self.goodsLabel.text = goodsStr;
        if (taskModel.state) {
            self.stateLabel.text = @"已完成";
            self.stateLabel.textColor = [UIColor blackColor];
            self.finishButton.hidden = YES;
        }else{
            self.stateLabel.text = @"未完成";
            self.stateLabel.textColor = [UIColor redColor];
            self.finishButton.hidden = NO;
        }
        switch (taskno) {
            case 1:
                self.backImage.image = [UIImage imageNamed:@"rwbg1"];
                self.taskLabel.text = @"任务一: 上传照片";
                break;
            case 2:
                self.backImage.image = [UIImage imageNamed:@"rwbg2"];
                self.taskLabel.text = @"任务二: 上传视频";
                break;
            case 3:
                self.backImage.image = [UIImage imageNamed:@"rwbg3"];
                self.taskLabel.text = @"任务三: 邀请亲友";
                break;
                
            default:
                break;
        }
    }
}
- (IBAction)finishButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(newTaskTableViewCell:taskno:)])
        [_delegate newTaskTableViewCell:self taskno:self.taskno];
}
@end
