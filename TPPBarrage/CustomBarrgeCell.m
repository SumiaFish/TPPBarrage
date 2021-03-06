//
//  CustomBarrgeCell.m
//  TPPBarrage
//
//  Created by Mac on 10/10/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "CustomBarrgeCell.h"

@interface CustomBarrgeCell ()

@property (weak, nonatomic) TPPBarrageModel *model;
@property (weak, nonatomic) UIFont *font;

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *lab;

@end

@implementation CustomBarrgeCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self addSubview:self.lab];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(16);
        }];
        
        //
        [self addSubview:self.avatarView];
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lab.mas_right).offset(self.class.avatarLeft);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(self.class.avatarW);
        }];
        self.clipsToBounds = YES;
        
        //
        UIView *labBGView = UIView.new;
        [self insertSubview:labBGView atIndex:0];
        [labBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat val = 1;
            make.top.mas_equalTo(self.lab).offset(-val);
            make.left.mas_equalTo(self.lab).offset(-24);
            make.bottom.mas_equalTo(self.lab).offset(val);
            make.right.mas_equalTo(self.lab).offset(self.class.textRight);
        }];
        labBGView.backgroundColor = UIColor.whiteColor;
        labBGView.layer.cornerRadius = 9;
        labBGView.clipsToBounds = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.avatarView.layer.cornerRadius = self.avatarView.bounds.size.height/2;
}

- (void)setModel:(TPPBarrageModel *)model font:(UIFont *)font {
    _model = model;
    self.lab.font = font;
    
    self.avatarView.image = [UIImage imageNamed:@"icon_my_press"];
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.lab.attributedText = model.attText;
}

- (UIFont *)font {
    return self.lab.font;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        UIImageView *view = UIImageView.new;
        _avatarView = view;
    }
    return _avatarView;
}

- (UILabel *)lab {
    if (!_lab) {
        UILabel *lab = UILabel.new;
        lab.textColor = UIColor.darkGrayColor;
        _lab = lab;
    }
    return _lab;
}

+ (CGFloat)avatarLeft {
    return 4;
}

+ (CGFloat)avatarW {
    return 42;
}

+ (CGFloat)textLeft {
    return 4;
}

+ (CGFloat)textRight {
    return 4;
}

+ (CGFloat)widthWithTextWidth:(CGFloat)textWidth {
    return self.avatarLeft + self.avatarW + self.textLeft + textWidth + self.textRight;
}

@end
