//
//  BBQOperationTableViewCell.m
//  BBQ
//
//  Created by anymuse on 15/12/30.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQOperationTableViewCell.h"
#import "BBQTextView.h"
#import "BBQOperationExpand.h"
#import "UIButton+Extension.h"
@interface BBQOperationTableViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *sceneLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet BBQTextView *descView;

@end
@implementation BBQOperationTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bordWillShow) name:UITextViewTextDidBeginEditingNotification object:self];
    // 1. 可重用标示符
    static NSString *ID = @"operationCell";
    // 2. tableView查询可重用Cell
    BBQOperationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3. 如果没有可重用cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBQOperationTableViewCell" owner:nil options:nil] lastObject];
    }
    // 点击cell的时候不要变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.deleteButton.layer.cornerRadius = 15.0;
    cell.descView.maxLength = 50;
    cell.descView.returnLengthBlock=^(NSInteger len){
    if ([cell.delegate respondsToSelector:@selector(operationTableViewCell:getdesc:index:)])  {
            [cell.delegate operationTableViewCell:cell getdesc:cell.descView.text index:cell.expand.index];
        }
      cell.maxLabel.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)len,50];
    };
    cell.descView.beginEditingBlock=^(){
        if ([cell.delegate respondsToSelector:@selector(operationTableViewCell:keyBoardWithIndex:)])  {
            [cell.delegate operationTableViewCell:cell keyBoardWithIndex:cell.expand.index];
        }
    };
    return cell;
}
-(void)setExpand:(BBQOperationExpand *)expand{
    _expand = expand;
    self.sceneLabel.text = [NSString stringWithFormat:@"场景%ld",(long)expand.index+1];
    //按钮图片
    if (expand.img) {
        [self.imageButton setBackgroundImage:expand.img forState:UIControlStateNormal];
    }else if (expand.imgurl){
        NSURL *imgurl = [NSURL URLWithString:expand.imgurl];
        [self.imageButton setBackgroundImageWithURL:imgurl
                               forState:UIControlStateNormal
                            placeholder:[UIImage imageNamed:@"operationadd"]
                                options:YYWebImageOptionAllowBackgroundTask
                             completion:nil];
    }
    self.descView.text = expand.memo;
    self.maxLabel.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)expand.memo.length,50];
}
- (IBAction)deleteButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(operationTableViewCellDidDelete:index:)])  {
        [_delegate operationTableViewCellDidDelete:self index:self.expand.index];
    }
}
- (IBAction)imageButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(operationTableViewCellImageButtonClick:index:)])  {
        [_delegate operationTableViewCellImageButtonClick:self index:self.expand.index];
    }
}
-(void)bordWillShow{
    
}
@end
