//
//  MenuView.m
//  02-练习
//
//  Created by 武镇涛 on 15/7/19.
//  Copyright (c) 2015年 wuzhentao. All rights reserved.
//

#import "MenuView.h"
#import "MenuViewBtn.h"
#import "FloodView.h"
#import "ZTPage.h"
@interface MenuView () <UIScrollViewDelegate>

@property(nonatomic, weak) UIScrollView *MenuScrollView;
@property(nonatomic, weak) MenuViewBtn *selectedBtn;
@property(nonatomic, weak) UIView *line;
@property(nonatomic, assign) CGFloat sumWidth;
@property(assign, nonatomic) BOOL hasIndicator;

@end

@implementation MenuView

- (instancetype)initWithMneuViewStyle:(MenuViewStyle)style
                            AndTitles:(NSArray *)titles {
  if (self = [super init]) {
    self.backgroundColor = [UIColor whiteColor];

    switch (style) {
    case MenuViewStyleLine:
      self.style = MenuViewStyleLine;
      break;
    case MenuViewStyleFoold:
      self.style = MenuViewStyleFoold;
      break;
    case MenuViewStyleFooldHollow:
      self.style = MenuViewStyleFooldHollow;
      break;
    default:
      self.style = MenuViewStyleDefault;
      break;
    }
    [[NSNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(willLogoutNotification:)
               name:kWillLogoutNotification
             object:nil];
      [[NSNotificationCenter defaultCenter]
       addObserver:self
       selector:@selector(willchangeClass:)
       name:@"willchangeClass"
       object:nil];
    [self loadWithScollviewAndBtnWithTitles:titles];
  }
  return self;
}

- (void)willLogoutNotification:(NSNotification *)notification {
  [self SelectedBtnMoveToCenterWithIndex:0 WithRate:0];
}
- (void)willchangeClass:(NSNotification *)notification {
    MenuViewBtn *btn = self.MenuScrollView.subviews[1];
    [self click:btn];
}
- (void)loadWithScollviewAndBtnWithTitles:(NSArray *)titles {
  UIScrollView *MenuScrollView = [[UIScrollView alloc] init];
  MenuScrollView.showsVerticalScrollIndicator = NO;
  MenuScrollView.showsHorizontalScrollIndicator = NO;
  MenuScrollView.backgroundColor = [UIColor whiteColor];
  MenuScrollView.delegate = self;
  self.MenuScrollView = MenuScrollView;
  [self addSubview:self.MenuScrollView];
  // btn创建

  for (int i = 0; i < titles.count; i++) {
    MenuViewBtn *btn = [[MenuViewBtn alloc] initWithTitles:titles AndIndex:i];
    btn.fontSize = 14;
    btn.normalColor = kNomalColor;
    btn.selectedColor = kSelectedColor;

    [btn addTarget:self
                  action:@selector(click:)
        forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.textColor = kNomalColor;
    [self.MenuScrollView addSubview:btn];
  }
}

- (void)layoutSubviews {
  MenuViewBtn *btn = [[MenuViewBtn alloc] init];
  MenuViewBtn *btn1 = [[MenuViewBtn alloc] init];
  for (int i = 0; i < self.MenuScrollView.subviews.count; i++) {
    btn = self.MenuScrollView.subviews[i];
    if (i >= 1) {
      btn1 = self.MenuScrollView.subviews[i - 1];
    }
    CGFloat sumWidth;
    UIFont *titleFont = btn.titleLabel.font;
    CGSize titleS = [btn.titleLabel.text sizeWithfont:titleFont];
    btn.bbqWidth = titleS.width + 2 * BtnGap;
    btn.bbqX = btn1.bbqX + btn1.bbqWidth + BtnGap;
    btn.bbqY = 0;
    btn.bbqHeight = self.bbqHeight - 2;
    sumWidth += btn.bbqWidth;
    btn.dot.frame =
        CGRectMake(btn.bbqWidth - kDotWidth, 4, kDotWidth, kDotWidth);
    btn.dot.layer.cornerRadius = 3;
    if (btn == [self.MenuScrollView.subviews lastObject]) {
      CGFloat width = self.bounds.size.width;
      CGFloat height = self.bounds.size.height;
      self.MenuScrollView.bbqSize = CGSizeMake(width, height);

      self.MenuScrollView.contentSize =
          CGSizeMake(btn.bbqX + btn.bbqWidth + BtnGap, 0);
      self.MenuScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if (i == 0) {
      btn.selected = YES;
      self.selectedBtn = btn;
    }
    btn = nil;
    btn1 = nil;
    self.sumWidth = sumWidth;
  }
  if (self.MenuScrollView.contentSize.width < self.bbqWidth) {
    CGFloat margin = (self.bbqWidth - self.sumWidth) /
                     (self.MenuScrollView.subviews.count + 1);
    for (int i = 0; i < self.MenuScrollView.subviews.count; i++) {
      btn = self.MenuScrollView.subviews[i];
      if (i >= 1) {
        btn1 = self.MenuScrollView.subviews[i - 1];
      }
      btn.bbqX = btn1.bbqX + btn1.bbqWidth + margin;
    }
  }
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];

  if (self.style == MenuViewStyleDefault) {
    MenuViewBtn *btn = [self.MenuScrollView.subviews firstObject];
    [btn ChangSelectedColorAndScalWithRate:0.1];
  } else {
    if (!self.hasIndicator) {
      [self addProgressView];
      self.hasIndicator = YES;
    }
  }
}

- (void)addProgressView {
  //    FloodView *view = [[FloodView alloc]init];
  UIView *line = [UIView new];

  MenuViewBtn *btn = [self.MenuScrollView.subviews firstObject];
  line.bbqX = btn.bbqX;
  line.bbqWidth = btn.bbqWidth;
  line.backgroundColor = [UIColor colorWithHexString:@"ff6440"];
  self.line = line;

  if (self.style == MenuViewStyleFooldHollow ||
      self.style == MenuViewStyleFoold) {
    //        view.FillColor = kNormalColorFlood.CGColor;
    //        view.bbqHeight = self.bbqHeight/2 + 2;
    //        view.bbqY = (self.bbqHeight - view.bbqHeight)/2;
    //
    //        if (self.style == MenuViewStyleFooldHollow) {
    //            view.isStroke = YES;
    //            view.color = [UIColor redColor];
    //        }
  } else {
    self.line.bbqHeight = 2;
    self.line.bbqY = self.bbqHeight - self.line.bbqHeight;
  }
  [self.MenuScrollView addSubview:line];
}

- (void)click:(MenuViewBtn *)btn {
  if (self.selectedBtn == btn)
    return;
  if ([self.delegate
          respondsToSelector:@selector(MenuViewDelegate:WithIndex:)]) {
    [self.delegate
        MenuViewDelegate:self
               WithIndex:[self.MenuScrollView.subviews indexOfObject:btn]];
  }

  [self SelectedBtnMoveToCenterWithIndex:[self.MenuScrollView.subviews
                                             indexOfObject:btn]
                                WithRate:0];
  //    self.selectedBtn.selected = NO;
  //    btn.selected = YES;
  //    [self MoveCodeWithIndex:(int)btn.tag];
  //
  //    if (self.style == MenuViewStyleDefault) {
  //
  //        [btn selectedItemWithoutAnimation];
  //        [self.selectedBtn deselectedItemWithoutAnimation];
  //    } else {
  //        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.75
  //        initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut
  //        animations:^{
  //            self.line.bbqX = btn.bbqX;
  //            self.line.bbqWidth = btn.bbqWidth;
  //        } completion:nil];
  //    }
  //    self.selectedBtn = btn;
}

- (void)SelectedBtnMoveToCenterWithIndex:(NSInteger)index
                                WithRate:(CGFloat)Pagerate {
  //    //接收通知
  //
  //
  //    int page  = (int)(Pagerate +0.5);
  //    CGFloat rate = Pagerate - index;
  //    int count = (int)self.MenuScrollView.subviews.count;
  //
  //    if (Pagerate < 0) return;
  //    if (index == count-1 || index >= count -1) return;
  //    if ( rate == 0)    return;
  //
  //    self.selectedBtn.selected = NO;
  //    MenuViewBtn *currentbtn = self.MenuScrollView.subviews[index];
  //    MenuViewBtn *nextBtn = self.MenuScrollView.subviews[index + 1];
  //
  //    if (self.style == MenuViewStyleDefault) {
  //
  //        [currentbtn ChangSelectedColorAndScalWithRate:rate];
  //        [nextBtn ChangSelectedColorAndScalWithRate:1-rate];
  //    }else {
  //        CGFloat margin;
  //        if (Pagerate < count-2){
  //            if (self.MenuScrollView.contentSize.width < self.bbqWidth){
  //                margin = (kScreenWidth -
  //                self.sumWidth)/(self.MenuScrollView.subviews.count + 1);
  //                self.line.bbqX =  currentbtn.bbqX + (currentbtn.bbqWidth +
  //                margin + BtnGap)* rate;
  //            }else{
  //                margin = BtnGap;
  //                self.line.bbqX =  currentbtn.bbqX + (currentbtn.bbqWidth +
  //                margin)* rate;
  //            }
  //
  //            self.line.bbqWidth =  currentbtn.bbqWidth + (nextBtn.bbqWidth -
  //            currentbtn.bbqWidth)*rate;
  //            [currentbtn ChangSelectedColorWithRate:rate];
  //            [nextBtn ChangSelectedColorWithRate:1-rate];
  //        }
  //    }
  //    self.selectedBtn = self.MenuScrollView.subviews[page];
  //    self.selectedBtn.selected = YES;
  MenuViewBtn *currentButton = self.MenuScrollView.subviews[index];
  currentButton.selected = YES;
  self.selectedBtn.selected = NO;
  self.selectedBtn = currentButton;
  [self MoveCodeWithIndex:index];
  [UIView animateWithDuration:0.3
                        delay:0
       usingSpringWithDamping:0.75
        initialSpringVelocity:0.5
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     self.line.bbqX = currentButton.bbqX;
                     self.line.bbqWidth = currentButton.bbqWidth;
                   }
                   completion:nil];
}

- (void)move:(NSNotification *)info {
  NSNumber *index = info.userInfo[@"index"];
  int tag = [index intValue];
  [self MoveCodeWithIndex:tag];
}
/**
 *  使选中的按钮位移到scollview的中间
 */
- (void)MoveCodeWithIndex:(NSInteger)index {
  MenuViewBtn *btn = self.MenuScrollView.subviews[index];
  CGRect newframe = [btn convertRect:self.bounds toView:nil];
  CGFloat distance = newframe.origin.x - self.bbqCenterX;
  CGFloat contenoffsetX = self.MenuScrollView.contentOffset.x;
  int count = (int)self.MenuScrollView.subviews.count;
  if (index > count - 1)
    return;

  if (self.MenuScrollView.contentOffset.x + btn.bbqX > self.bbqCenterX) {
    [self.MenuScrollView
        setContentOffset:CGPointMake(contenoffsetX + distance + btn.bbqWidth, 0)
                animated:YES];
  } else {

    [self.MenuScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (scrollView.contentOffset.x <= 0) {
    [scrollView setContentOffset:CGPointMake(0, 0)];
  } else if (scrollView.contentOffset.x + self.bbqWidth >=
             scrollView.contentSize.width) {
    [scrollView
        setContentOffset:CGPointMake(
                             scrollView.contentSize.width - self.bbqWidth, 0)];
  }
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)selectWithIndex:(NSInteger)index AndOtherIndex:(int)tag {
  self.selectedBtn = self.MenuScrollView.subviews[index];
  MenuViewBtn *otherbtn = self.MenuScrollView.subviews[tag];

  self.selectedBtn.selected = YES;
  otherbtn.selected = NO;

  self.line.bbqX = self.selectedBtn.bbqX;
  self.line.bbqWidth = self.selectedBtn.bbqWidth;

  [self MoveCodeWithIndex:(int)self.selectedBtn.tag];
}
@end
