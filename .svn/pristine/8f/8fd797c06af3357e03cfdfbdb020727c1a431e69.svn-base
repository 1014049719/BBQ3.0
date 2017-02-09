//
//  BBQNewGuideViewController.m
//  BBQ
//
//  Created by anymuse on 15/12/15.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQNewGuideViewController.h"
#import "BBQTaskModel.h"
#import "BBQTaskGoods.h"

@interface BBQNewGuideViewController()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *taskButton;
@property (weak, nonatomic) IBOutlet UIView *goodsVieW;
@property (weak, nonatomic) IBOutlet UIView *xzView;
@property (weak, nonatomic) IBOutlet UIView *expView;
@property (weak, nonatomic) IBOutlet UIView *ledouView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *expvalue;
@property (weak, nonatomic) IBOutlet UIButton *ledouvalue;

@end

@implementation BBQNewGuideViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self setupView];
    

}
-(void)setupView{
    if (self.taskModel.taskno == 0 &&self.taskModel.state ==0) {
        [self.backgroundImage setImage:[UIImage imageNamed:@"guidentrance"]];
        self.backgroundImage.userInteractionEnabled = YES;
        [self.backgroundImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startButtonClick)]];
        self.contentView.hidden = YES;
        self.xzView.hidden = YES;
        self.nextButton.hidden =YES;
    }else{
        [self.backgroundImage setImage:[UIImage imageNamed:@"nextGuide"]];
        self.contentView.hidden = NO;
        self.descLabel.text = self.taskModel.descr;
        self.nextButton.layer.cornerRadius = 15;
        self.nextButton.hidden =NO;
        self.xzView.hidden = YES;
        self.ledouView.hidden = YES;
        self.expView.hidden = YES;
        [self.nextButton setTitle:@"继续下一个任务" forState:UIControlStateNormal];
        for (BBQTaskGoods *goods in self.taskModel.goodsarr) {
            if ([goods.goodsname isEqualToString:@"成长值"]) {
                self.expView.hidden = NO;
                [self.expvalue setTitle:goods.num forState:UIControlStateNormal];
            }else if ([goods.goodsname isEqualToString:@"乐豆"]){
                self.ledouView.hidden = NO;
                [self.ledouvalue setTitle:goods.num forState:UIControlStateNormal];
            }
        }
    }
}
- (IBAction)cancelButtonClick {
    if (self.block != nil) {
        self.block(NO);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)startButtonClick {
    if (!self.xzView.hidden) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        BBQTaskModel *totalModel = [TheCurUser.taskArr firstObject];
        if (totalModel.state) {
            self.xzView.hidden = NO;
            self.descLabel.text = totalModel.descr;
            for (BBQTaskGoods *goods in totalModel.goodsarr) {
                if ([goods.goodsname isEqualToString:@"成长值"]) {
                    [self.expvalue setTitle:goods.num forState:UIControlStateNormal];
                }else if ([goods.goodsname isEqualToString:@"乐豆"]){
                    [self.ledouvalue setTitle:goods.num forState:UIControlStateNormal];
                }
            }
            [self.nextButton setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            if (self.block != nil) {
                self.block(YES);
            }
          [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
}
@end
