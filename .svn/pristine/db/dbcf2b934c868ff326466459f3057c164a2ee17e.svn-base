//
//  BBQLevelViewController.m
//  BBQ
//
//  Created by anymuse on 15/12/21.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQLevelViewController.h"
#import "BBQGradeResult.h"
#import "BBQTaskRule.h"
#import "BBQNewTaskViewController.h"
@interface BBQLevelViewController ()
@property(nonatomic,strong)NSArray *rulearr;
@property (weak, nonatomic) IBOutlet UILabel *itenLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *ruleView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightCosntraint;
@property (weak, nonatomic) IBOutlet UILabel *currentGradeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *growthLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextGradeLabel;
@property (weak, nonatomic) IBOutlet UIView *nextView;
@property (weak, nonatomic) IBOutlet UIView *XZView;
@property (weak, nonatomic) IBOutlet UIView *darenView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorBar;


@end

@implementation BBQLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTaskRules];
    self.nextView.userInteractionEnabled = YES;
    [self.nextView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNewTask)]];
}
-(void)showNewTask{
    BBQNewTaskViewController *taskView = [[BBQNewTaskViewController alloc] init];
    taskView.title = @"新手任务";
    taskView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:taskView animated:YES];
    
}

-(void)setGradeResult:(BBQGradeResult *)gradeResult{
    _gradeResult = gradeResult;
    self.rulearr = gradeResult.rulearr;
    
}
-(void)setupTaskRules{
    int i =1;
    NSInteger levelInter = [self.gradeResult.level integerValue];
    NSInteger growthvalue = [self.gradeResult.growthvalue integerValue];
    NSInteger nextvalue = [self.gradeResult.nextvalue integerValue];
    CGFloat growthPer = growthvalue *1.0/ (growthvalue + nextvalue) ;
    self.currentGradeLabel.text =[NSString stringWithFormat:@"LV%@", @(levelInter)] ;
    self.growthLabel.text = [NSString stringWithFormat:@"当前%@成长值", @(growthvalue)];
    self.nextGradeLabel.text = [NSString stringWithFormat:@"还需%@成长值升级到LV%@", @(nextvalue),@(levelInter+1)];
    for (BBQTaskGoods *good in self.gradeResult.goodsarr) {
        if (good.goodsid.integerValue == 10) {
            self.XZView.hidden = NO;
            self.stateLabel.text = @"已完成";
            self.stateLabel.textColor = [UIColor blackColor];
            break;
        }
    }
    self.progressView.progress = growthPer;
    CGFloat labelW = self.itenLabel.frame.size.width;
    CGFloat labelH = self.itenLabel.frame.size.height;
    for (BBQTaskRule *rule in self.rulearr) {
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.descView addSubview:nameLabel];
        nameLabel.backgroundColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.numberOfLines = 0;
        nameLabel.frame = CGRectMake(1, i*labelH+i, labelW, labelH);
        nameLabel.text = rule.rulename;
       UILabel *growthLabel = [[UILabel alloc] init];
        [self.descView addSubview:growthLabel];
        growthLabel.font = [UIFont systemFontOfSize:14];
        growthLabel.backgroundColor = [UIColor whiteColor];
        growthLabel.textAlignment = NSTextAlignmentCenter;
        growthLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame)+1, i*labelH+i, labelW*3/4.0, labelH);
        growthLabel.text = rule.growthdescr;
        UILabel *descLabel = [[UILabel alloc] init];
        [self.descView addSubview:descLabel];
        descLabel.font = [UIFont systemFontOfSize:14];
        descLabel.backgroundColor = [UIColor whiteColor];
        descLabel.numberOfLines = 0;
        descLabel.frame = CGRectMake(CGRectGetMaxX(growthLabel.frame)+1, i*labelH+i, labelW * 5/4.0-4, labelH);
        descLabel.text = rule.descr;
        i++;
    }
    self.contentViewHeightCosntraint.constant = CGRectGetMaxY(self.descView.frame) + self.ruleView.frame.origin.y +2*labelH;
}
@end
