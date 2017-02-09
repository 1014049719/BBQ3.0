//
//  FirstTagView.m
//  BBQ
//
//  Created by 朱琨 on 15/8/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "FirstTagView.h"
#import <Masonry.h>

@interface FirstTagView () <UIScrollViewDelegate>

@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(strong, nonatomic) UIButton *lastButton;
@property(weak, nonatomic) IBOutlet UIButton *cancelButton;
@property(assign, nonatomic) NSInteger lastButtonIndex;
@property(assign, nonatomic) BOOL viewDidLayout;
@property(nonatomic) CGRect originRect;

@end

static CGFloat const kMargin = 20.0f;
static CGFloat const kHSpace = 15.0f;

@implementation FirstTagView

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    self.scrollView.delegate = self;
    [self setup];
  }
  return self;
}

- (void)setup {
}

//
//
//- (void)setTagsArray:(NSArray *)tagsArray {
//    _tagsArray = tagsArray;
//}

- (void)layoutSubviews {
  [super layoutSubviews];

  if (!self.viewDidLayout) {
    self.viewDidLayout = YES;
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius =
        CGRectGetHeight(self.cancelButton.frame) / 2.0;
    self.cancelButton.layer.borderColor =
        [UIColor colorWithHexString:@"ff6440"].CGColor;
    self.cancelButton.layer.borderWidth = 2;
    self.pageControl.numberOfPages = ceil(self.tagsArray.count / 6.0);
    CGSize contentSize = self.scrollView.contentSize;
    contentSize.width = self.pageControl.numberOfPages * kScreenWidth;
    contentSize.height = CGRectGetHeight(self.scrollView.frame);
    self.scrollView.contentSize = contentSize;

    [self.scrollView.subviews
        makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGFloat tagHeight = (contentSize.height - kMargin) / 2.0;
    CGFloat tagWidth = (kScreenWidth - kHSpace * 4) / 3.0;

    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:@"自定义"];
    [tempArray addObjectsFromArray:self.tagsArray];

    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,
                                            BOOL *stop) {
      UIButton *tag = [UIButton buttonWithType:UIButtonTypeCustom];
      tag.layer.masksToBounds = YES;
      [tag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [tag setTitle:tempArray[idx] forState:UIControlStateNormal];
      tag.titleLabel.font = [UIFont systemFontOfSize:14];
      tag.titleLabel.adjustsFontSizeToFitWidth = YES;
      tag.titleLabel.minimumScaleFactor = 0.5;
      tag.layer.cornerRadius = tagHeight / 2.0;
      tag.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
      [tag addTarget:self
                    action:@selector(didClickTag:)
          forControlEvents:UIControlEventTouchUpInside];
      tag.frame = CGRectMake((kHSpace + tagWidth) * (idx % 3 + 1) - tagWidth +
                                 idx / 6 * kScreenWidth,
                             (idx / 3 % 2) ? tagHeight + kMargin : 0, tagWidth,
                             tagHeight);
      [self.scrollView addSubview:tag];
    }];
  }
}

- (void)dismiss {
  CGRect frame = self.originRect;
  frame.origin.y = CGRectGetMaxY(frame);

  [UIView animateWithDuration:0.3
      animations:^{
        self.frame = frame;
      }
      completion:^(BOOL finished) {
        if (finished) {
          self.isVisible = NO;
          self.hidden = YES;
        }
      }];
}

- (void)show {
  CGRect frame = self.frame;
  frame.origin.y = CGRectGetMinY(frame) - CGRectGetHeight(frame);
  self.hidden = NO;
  if (!self.viewDidLayout) {
    self.originRect = frame;
  }

  [UIView animateWithDuration:0.3
      animations:^{
        self.frame = self.originRect;
      }
      completion:^(BOOL finished) {
        self.isVisible = YES;
      }];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  self.pageControl.currentPage = ceil((*targetContentOffset).x / kScreenWidth);
}

- (IBAction)didClickCancelButton:(id)sender {
  [self dismiss];
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(didClickCancelButton)]) {
    [self.delegate didClickCancelButton];
  }
}

- (void)didClickTag:(UIButton *)button {
  if (self.lastButton != button) {
    self.lastButton.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
    button.backgroundColor = [UIColor colorWithRed:250 / 255.0
                                             green:199 / 255.0
                                              blue:51 / 255.0
                                             alpha:1];
    self.lastButton = button;
  } else {
    button.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
    self.lastButton = nil;
  }

  self.didChooseTag = self.lastButton ? YES : NO;

  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(didClickTag:)]) {
    [self.delegate didClickTag:self.lastButton.titleLabel.text];
  }
}

- (void)dealloc {
}

@end
