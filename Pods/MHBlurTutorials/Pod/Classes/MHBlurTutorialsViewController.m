//
//  MHBlurTutorialsViewController.m
//  Pods
//
//  Created by Mathilde Henriot on 09/06/2015.
//
//

#import "MHBlurTutorialsViewController.h"
#import "Masonry.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface MHBlurTutorialsViewController () {
  CAShapeLayer *maskLayer;
  int currentIndex;
}

@property(nonatomic, strong) UIView *holeView;
@property(nonatomic, strong) UILabel *explanationLabel;
@property(nonatomic, strong) NSArray *animationsArray;

@property(strong, nonatomic) NSMutableArray *guideArray;

@end

@implementation MHBlurTutorialsViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.guideArray = [NSMutableArray array];
  //    self.view.backgroundColor = [UIColor redColor];
  self.holeView = [[UIView alloc] initWithFrame:self.view.frame];
  self.explanationLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
  self.explanationLabel.textAlignment = NSTextAlignmentCenter;
  self.explanationLabel.textColor = [UIColor whiteColor];
  self.explanationLabel.numberOfLines = 0;

  [self.holeView addSubview:self.explanationLabel];

  UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(handleSingleTap:)];
  [self.holeView addGestureRecognizer:singleFingerTap];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

- (void)setBackgroundColor:(UIColor *)color {
  self.holeView.backgroundColor = color;
}
- (void)setExplanationLabelFont:(UIFont *)font {
  self.explanationLabel.font = font;
}
- (void)setAnimations:(NSArray *)animations {
  self.animationsArray = animations;
  currentIndex = 0;
  [self startAnimationAtIndex:currentIndex];
}
- (void)displayTutorial {
  [self addHoleSubview];
}

#pragma mark - Private Methods

- (void)addHoleSubview {
  [self.view addSubview:self.holeView];
}

- (void)startAnimationAtIndex:(int)index {

  CGRect bounds = self.view.frame;
  maskLayer = [CAShapeLayer layer];
  maskLayer.frame = bounds;
  maskLayer.fillColor = [UIColor blackColor].CGColor;

  float kRadius = [self.animationsArray[index][@"holeRadius"] floatValue];
  CGPoint holeCenter =
      [self.animationsArray[index][@"holeCenter"] CGPointValue];
  CGRect originCircleRect = CGRectMake(
      holeCenter.x - kRadius, holeCenter.y - kRadius, 2 * kRadius, 2 * kRadius);
  CGRect finalCircleRect = CGRectMake(holeCenter.x - 2.5 * kRadius / 2,
                                      holeCenter.y - 2.5 * kRadius / 2,
                                      2.5 * kRadius, 2.5 * kRadius);

  for (UIView *view in self.guideArray) {
    if (view.superview) {
      [view removeFromSuperview];
    }
  }

  switch (self.tutorialsType) {
  case BBQTutorialsTypeParent: {
    [self addParentTutorialsAtIndex:index];
  } break;
  case BBQTutorialsTypeTeacherHomePage: {
    [self addTeacherHomePageTutorialsAtIndex:index];
  } break;
  case BBQTutorialsTypeDynamic: {
    [self addDynamicTutorialsAtIndex:index];
  } break;

  default:
    break;
  }

  UIBezierPath *originPath =
      [UIBezierPath bezierPathWithOvalInRect:originCircleRect];
  [originPath appendPath:[UIBezierPath bezierPathWithRect:bounds]];

  UIBezierPath *finalPath =
      [UIBezierPath bezierPathWithOvalInRect:finalCircleRect];
  [finalPath appendPath:[UIBezierPath bezierPathWithRect:bounds]];

  maskLayer.path = originPath.CGPath;
  maskLayer.fillRule = kCAFillRuleEvenOdd;
  [maskLayer setValue:@(1) forKeyPath:@"transform.scale"];

  self.holeView.layer.mask = maskLayer;

  self.explanationLabel.text = self.animationsArray[index][@"text"];

  CGSize size = [self.explanationLabel
      sizeThatFits:CGSizeMake(self.view.frame.size.width - 20, CGFLOAT_MAX)];
  CGRect frame = self.explanationLabel.frame;
  frame.size.height = size.height;
  self.explanationLabel.frame = frame;

  self.explanationLabel.center =
      [self.animationsArray[index][@"textCenter"] CGPointValue];

  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
  animation.fromValue = [maskLayer valueForKeyPath:@"path"];
  animation.toValue = (id)finalPath.CGPath;
  animation.duration = 1;
  animation.timingFunction = [CAMediaTimingFunction
      functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  animation.repeatDuration = HUGE_VALF;
  animation.autoreverses = YES;
  [maskLayer addAnimation:animation forKey:animation.keyPath];
}

- (void)addParentTutorialsAtIndex:(NSInteger)index {
  [self.guideArray removeAllObjects];
  UIImageView *textView = [UIImageView new];
  [self.holeView addSubview:textView];
  [self.guideArray addObject:textView];
  UIImageView *pandaView = [UIImageView new];
  [self.holeView addSubview:pandaView];
  [self.guideArray addObject:pandaView];

  float kRadius = [self.animationsArray[index][@"holeRadius"] floatValue];
  CGPoint holeCenter =
      [self.animationsArray[index][@"holeCenter"] CGPointValue];

  switch (index) {
  case 0: {
    textView.image = [UIImage imageNamed:@"tutorials_text_01"];
    pandaView.image = [UIImage imageNamed:@"tutorials_01"];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.holeView).offset(holeCenter.y + kRadius - 5);
      make.left.equalTo(self.holeView).offset(holeCenter.x + kRadius - 10);
      make.width.equalTo(@(210 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(113 / 420.0);
    }];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(textView).offset(-15 * ScreenWidth / 375.0);
      make.left.equalTo(textView.mas_right).offset(-35 * ScreenWidth / 375.0);
      make.width.equalTo(@(120 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(221 / 240.0);
    }];
  }

  break;
  case 1: {
    textView.image = [UIImage imageNamed:@"tutorials_text_02"];
    pandaView.image = [UIImage imageNamed:@"tutorials_02"];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.holeView.mas_left).offset(holeCenter.x);
      make.bottom.equalTo(self.holeView).offset(-kRadius * 2 - 5);
      make.width.equalTo(@(163 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(211 / 326.0);
    }];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(textView).offset(-35);
      make.left.equalTo(textView.mas_right).offset(25);
      make.width.equalTo(@(100 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(203 / 200.0);
    }];
  } break;
  case 2: {
    textView.image = [UIImage imageNamed:@"tutorials_text_03"];
    pandaView.image = [UIImage imageNamed:@"tutorials_03"];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.holeView).offset(45 * ScreenWidth / 375.0);
      make.bottom.equalTo(self.holeView).offset(-kRadius * 2 - 5);
      make.width.equalTo(@(210.5 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(203 / 421.0);
    }];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(textView).offset(-35 * ScreenWidth / 375.0);
      make.right.equalTo(textView.mas_left).offset(-15);
      make.width.equalTo(@(69.5 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(183 / 139.0);
    }];

  } break;
  case 3: {
    textView.image = [UIImage imageNamed:@"tutorials_text_04"];
    pandaView.image = [UIImage imageNamed:@"tutorials_04"];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.holeView.mas_left).offset(holeCenter.x - 50);
      make.top.equalTo(self.holeView).offset(holeCenter.y + kRadius + 5);
      make.width.equalTo(@(137 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(179 / 274.0);
    }];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(textView).offset(5);
      make.right.equalTo(textView.mas_left).offset(-10);
      make.width.equalTo(@(76.5 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(195 / 153.0);
    }];

    UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(openGallery)];
    [self.holeView addGestureRecognizer:tap];
  } break;
  //        case 4: {
  //            textView.image = [UIImage imageNamed:@"tutorials_05"];
  //            [textView mas_makeConstraints:^(MASConstraintMaker *make) {
  //                make.centerX.equalTo(self.holeView);
  //                make.centerY.equalTo(self.holeView).offset(-100 *
  //                ScreenHeight / 667.0);
  //                make.width.equalTo(@(250 / 375.0 * ScreenWidth));
  //                make.height.equalTo(textView.mas_width).multipliedBy(192 /
  //                500.0);
  //            }];

  //            UIButton *galleryButton = [UIButton
  //            buttonWithType:UIButtonTypeCustom];
  //            [galleryButton addTarget:self action:@selector(openGallery)
  //            forControlEvents:UIControlEventTouchUpInside];
  //            [self.holeView addSubview:galleryButton];
  //            [galleryButton setImage:[UIImage
  //            imageNamed:@"tutorials_gallery"] forState:UIControlStateNormal];
  //            [galleryButton mas_makeConstraints:^(MASConstraintMaker *make) {
  //                make.centerX.equalTo(textView);
  //                make.top.equalTo(textView.mas_bottom).offset(20);
  //                make.width.equalTo(@(200 / 375.0 * ScreenWidth));
  //                make.height.equalTo(galleryButton.mas_width).multipliedBy(98
  //                / 400.0);
  //            }];
  //
  //            UIButton *skipButton = [UIButton
  //            buttonWithType:UIButtonTypeCustom];
  //            [skipButton addTarget:self action:@selector(dismissSelf)
  //            forControlEvents:UIControlEventTouchUpInside];
  //            [self.holeView addSubview:skipButton];
  //            [skipButton setImage:[UIImage imageNamed:@"tutorials_text_05"]
  //            forState:UIControlStateNormal];
  //
  //            [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
  //                make.centerX.equalTo(textView);
  //                make.top.equalTo(galleryButton.mas_bottom).offset(20);
  //                make.width.equalTo(@(43 / 375.0 * ScreenWidth));
  //                make.height.equalTo(skipButton.mas_width).multipliedBy(35 /
  //                86.0);
  //            }];
  //        }
  //            break;
  default:
    break;
  }
}

- (void)addTeacherHomePageTutorialsAtIndex:(NSInteger)index {
  [self.guideArray removeAllObjects];
  UIImageView *textView = [UIImageView new];
  [self.holeView addSubview:textView];
  [self.guideArray addObject:textView];
  UIImageView *pandaView = [UIImageView new];
  [self.holeView addSubview:pandaView];
  [self.guideArray addObject:pandaView];

  float kRadius = [self.animationsArray[index][@"holeRadius"] floatValue];
  CGPoint holeCenter =
      [self.animationsArray[index][@"holeCenter"] CGPointValue];

  switch (index) {
  case 0: {
    textView.image = [UIImage imageNamed:@"tutorial_teacher_homepage_01"];
    pandaView.image = [UIImage imageNamed:@"tutorials_03"];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.holeView.mas_leading).offset(holeCenter.x - 10);
      make.top.equalTo(self.holeView).offset(holeCenter.y + kRadius + 15);
      make.width.equalTo(@(69.5 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(183 / 139.0);
    }];

    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.holeView).offset(holeCenter.y + kRadius + 5);
      make.left.equalTo(pandaView.mas_right).offset(15);
      make.width.equalTo(@(217.5 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(192 / 435.0);
    }];
  } break;
  case 1: {
    textView.image = [UIImage imageNamed:@"tutorial_teacher_homepage_02"];
    pandaView.image = [UIImage imageNamed:@"tutorial_teacher_panda_02"];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(self.holeView.mas_leading)
          .offset(holeCenter.x - 10);
      make.top.equalTo(self.holeView).offset(holeCenter.y + kRadius + 5);
      make.width.equalTo(@(235 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(200 / 470.0);
    }];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(textView).offset(10);
      make.leading.equalTo(textView.mas_trailing).offset(10);
      make.width.equalTo(@(77.5 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(204 / 155.0);
    }];
  } break;
  default:
    break;
  }
}

- (void)addDynamicTutorialsAtIndex:(NSInteger)index {
  [self.guideArray removeAllObjects];
  UIImageView *textView = [UIImageView new];
  [self.holeView addSubview:textView];
  [self.guideArray addObject:textView];
  UIImageView *pandaView = [UIImageView new];
  [self.holeView addSubview:pandaView];
  [self.guideArray addObject:pandaView];

  float kRadius = [self.animationsArray[index][@"holeRadius"] floatValue];
  CGPoint holeCenter =
      [self.animationsArray[index][@"holeCenter"] CGPointValue];

  switch (index) {
  case 0: {
    textView.image = [UIImage imageNamed:@"tutorial_dynamic_01"];
    pandaView.image = [UIImage imageNamed:@"tutorials_03"];

    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.holeView).offset(holeCenter.y + kRadius + 5);
      make.trailing.equalTo(self.holeView.mas_leading).offset(holeCenter.x - 5);
      make.width.equalTo(@(210 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(198 / 420.0);
    }];

    [pandaView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.trailing.equalTo(textView.mas_leading).offset(-10);
      make.bottom.equalTo(textView).offset(10);
      make.width.equalTo(@(69.5 / 375.0 * ScreenWidth));
      make.height.equalTo(pandaView.mas_width).multipliedBy(183 / 139.0);
    }];
  } break;
  case 1: {
    textView.image = [UIImage imageNamed:@"tutorials_05"];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.holeView);
      make.centerY.equalTo(self.holeView).offset(-100 * ScreenHeight / 667.0);
      make.width.equalTo(@(250 / 375.0 * ScreenWidth));
      make.height.equalTo(textView.mas_width).multipliedBy(192 / 500.0);
    }];

    UIButton *galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [galleryButton addTarget:self
                      action:@selector(openGallery)
            forControlEvents:UIControlEventTouchUpInside];
    [self.holeView addSubview:galleryButton];
    [galleryButton setImage:[UIImage imageNamed:@"tutorials_gallery"]
                   forState:UIControlStateNormal];
    [galleryButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(textView);
      make.top.equalTo(textView.mas_bottom).offset(20);
      make.width.equalTo(@(200 / 375.0 * ScreenWidth));
      make.height.equalTo(galleryButton.mas_width).multipliedBy(98 / 400.0);
    }];

    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton addTarget:self
                   action:@selector(dismissSelf)
         forControlEvents:UIControlEventTouchUpInside];
    [self.holeView addSubview:skipButton];
    [skipButton setImage:[UIImage imageNamed:@"tutorials_text_05"]
                forState:UIControlStateNormal];

    [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(textView);
      make.top.equalTo(galleryButton.mas_bottom).offset(20);
      make.width.equalTo(@(43 / 375.0 * ScreenWidth));
      make.height.equalTo(skipButton.mas_width).multipliedBy(35 / 86.0);
    }];
  } break;
  default:
    break;
  }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  [maskLayer removeAllAnimations];

  if (currentIndex < [self.animationsArray count] - 1) {
    currentIndex++;
    [self startAnimationAtIndex:currentIndex];
  } else {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

- (void)openGallery {
  [self dismissViewControllerAnimated:NO completion:self.block];
}

- (void)dismissSelf {
  [self dismissViewControllerAnimated:NO completion:nil];
}

@end
