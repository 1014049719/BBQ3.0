//
//  BBQBabyHeaderView.m
//  BBQ
//
//  Created by 朱琨 on 15/11/17.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQBabyHeaderView.h"
#import "UITapImageView.h"
#import <Masonry.h>
#import "NSString+Common.h"

@interface BBQBabyHeaderView ()

@property (strong, nonatomic) UITapImageView *avatarView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UILabel *classLabel;
@property (strong, nonatomic) UIButton *infoButton;
@property (assign, nonatomic) CGFloat avatarViewWidth;
@property (strong, readwrite, nonatomic) BBQBabyModel *baby;

@end

@implementation BBQBabyHeaderView

- (instancetype)initWithBaby:(id)baby {
    if (self = [super init]) {
        _baby = baby;
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScaleFrom_iPhone6_Desgin(225));
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UIImageView *blackTranslucentView = [UIImageView new];
    blackTranslucentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [self addSubview:blackTranslucentView];
    [blackTranslucentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(30);
    }];
    
    _infoButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"有动态没有上传啊啊啊" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickInfoButton) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(100, 20));
            make.right.equalTo(self);
            make.bottom.equalTo(self).offset(40 - CGRectGetHeight(self.frame));
        }];
        button;
    });
    
    _nameLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = UIColorHex(ffffff);
        [self addSubview:label];
        label;
    });
    
    _ageLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = UIColorHex(ffffff);
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        label;
    });
    
    _classLabel = ({
        UILabel *label = [UILabel new];
        label.textColor = UIColorHex(ffffff);
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        label;
    });
    
    _avatarViewWidth = 70;
    _avatarView = ({
        UITapImageView *imageView = [UITapImageView new];
        [self addSubview:imageView];
        [imageView doBorderWidth:1.0 color:nil cornerRadius:_avatarViewWidth/2];
        @weakify(self)
        [imageView addTapBlock:^(id obj) {
            @strongify(self)
            if (self.avatarViewClicked) {
                self.avatarViewClicked();
            }
        }];
        imageView;
    });
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(_avatarViewWidth, _avatarViewWidth));
        make.left.equalTo(self).offset(kScaleFrom_iPhone6_Desgin(15));
        make.bottom.equalTo(_nameLabel.mas_top).offset(-15);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarView.mas_left).offset(kScaleFrom_iPhone6_Desgin(15));
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.bottom.equalTo(_nameLabel);
    }];
    
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ageLabel.mas_right).offset(10);
        make.bottom.equalTo(_ageLabel);
    }];

    [self updateView];
}

#pragma mark - 更新View
- (void)updateView {
    //TODO:更新View
    UIImage *image = [UIImage imageNamed:@"coverimage"];
    self.image = [UIImage imageNamed:@"g2"];
//    [self setImageWithURL:[NSURL URLWithString:_baby.coverurl] placeholder:[UIImage
//                                                                            imageNamed:@"coverimage"] options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    [_avatarView setImageWithURL:[NSURL URLWithString:_baby.avartar] placeholder:Placeholder_avatar];
    _nameLabel.text = _baby.realname;
    [_nameLabel sizeToFit];
    _ageLabel.text = [NSString ageWithYear:_baby.birthyear month:_baby.birthmonth day:_baby.birthday];
    [_ageLabel sizeToFit];
    _classLabel.text = _baby.curClass.classname;
    [_classLabel sizeToFit];
}



- (void)didClickInfoButton {
    if (self.infoButtonClicked) {
        self.infoButtonClicked();
    }
}

#pragma mark - Getter & Setter
- (void)setBaby:(id)baby {
    _baby = baby;
    [self updateView];
}

@end
