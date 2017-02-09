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
@property (assign, nonatomic) CGFloat avatarViewWidth;
@property (strong, readwrite, nonatomic) BBQBabyModel *baby;

//广告
@property (strong, nonatomic) UITapImageView *advewtisementImageView;
@property (strong, nonatomic) UITapImageView *closeImageView;

@end

@implementation BBQBabyHeaderView

- (instancetype)initWithBaby:(id)baby {
    if (self = [super init]) {
        
        self.userInteractionEnabled=YES;
        
        _baby = baby;
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScaleFrom_iPhone6_Desgin(225));
        [self setupView];
        
        //请求广告
        [self RequestAdvertisement];
    }
    return self;
}

-(void)RequestAdvertisement{

    NSDictionary *ParamDic=@{@"advPosition":@"1"};
    
    [BBQHTTPRequest queryWithType:BBQHTTPRequestTypeAdvertisementCZS param:ParamDic successHandler:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject, bool apiSuccess) {
        
        NSLog(@"宝宝广告数据：%@",responseObject);
        NSArray *arr=responseObject[@"data"][@"adarr"];
        if (arr.count>0) {
            self.advUrlStr=arr[0][@"advUrl"];
            self.advPicUrlStr=arr[0][@"advPic"];
            self.closeImageUrl=arr[0][@"closeImageUrl"];
            
            //添加广告
            [self addAdvertisementView];
        }

    } errorHandler:^(NSDictionary *responseObject) {
        NSLog(@"宝宝广告错误 %@",responseObject);
        
    } failureHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"宝宝广告失败 %@",error);
    }];
    

}

-(void)addAdvertisementView{
    
    //广告
    _advewtisementImageView=[UITapImageView new];
    [_advewtisementImageView setImageWithURL:[NSURL URLWithString:self.advPicUrlStr] options:YYWebImageOptionSetImageWithFadeAnimation];
    [self addSubview:_advewtisementImageView];
    @weakify(self)
    [_advewtisementImageView addTapBlock:^(id obj) {
        @strongify(self)
        self.advertisementImageViewClick();
    }];
    [_advewtisementImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(23);
        if (kScreenHeight>=667) {
            make.size.mas_equalTo(CGSizeMake(86, 86));
            make.bottom.equalTo(_avatarView.mas_top).offset(-25);
        }else{
        
            make.size.mas_equalTo(CGSizeMake(76, 76));
            make.bottom.equalTo(_avatarView.mas_top).offset(-4);
        }
        NSLog(@"屏幕高度%f",kScreenHeight);
    }];
    
    //关闭图片
    _closeImageView=[UITapImageView new];
    [_closeImageView setImageWithURL:[NSURL URLWithString:self.closeImageUrl] options:YYWebImageOptionSetImageWithFadeAnimation];
    [self addSubview:_closeImageView];
    [_closeImageView addTapBlock:^(id obj) {
        @strongify(self)
        [self.advewtisementImageView removeFromSuperview];
        [self.closeImageView removeFromSuperview];
    }];
    [_closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(_advewtisementImageView);
        make.left.mas_equalTo(_advewtisementImageView.mas_right).offset(-10);
        make.width.mas_equalTo(@15);
        make.centerY.equalTo(_advewtisementImageView);
    }];
}

- (void)setupView {
    UIView *gradientView = [UIView new];
    gradientView.backgroundColor = [UIColor clearColor];
    [self addSubview:gradientView];
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(60);
    }];
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor, (__bridge id)[UIColor colorWithWhite:0.2 alpha:0.5].CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.width = self.width;
    layer.height = 60;
    [gradientView.layer addSublayer:layer];
    
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
    [self setImageWithURL:[NSURL URLWithString:_baby.coverurl] placeholder:[UIImage
                                                                            imageNamed:@"coverImage.jpg"] options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    [_avatarView setImageWithURL:[NSURL URLWithString:_baby.avartar] placeholder:Placeholder_avatar];
    _nameLabel.text = _baby.realname;
    [_nameLabel sizeToFit];
    _ageLabel.text = [NSString ageWithYear:_baby.birthyear month:_baby.birthmonth day:_baby.birthday];
    [_ageLabel sizeToFit];
    if (_baby.curClass.classname) {
        _classLabel.text = [NSString stringWithFormat:@"%@ %@",_baby.curSchool.schoolname,_baby.curClass.classname];
    }
    [_classLabel sizeToFit];
}

#pragma mark - Getter & Setter
- (void)setBaby:(id)baby {
    _baby = baby;
    [self updateView];
}

@end
