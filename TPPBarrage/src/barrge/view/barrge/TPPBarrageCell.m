//
//  TPPBarrageCell.m
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "TPPBarrageCell.h"

@interface TPPBarrageContentView ()

@property (weak, nonatomic) TPPBarrageModel *model;
@property (weak, nonatomic) UIFont *font;

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *lab;

@end

@interface TPPBarrageCell ()

@property (strong, nonatomic) TPPBarrageContentView *barrageContentView;

@end

@implementation TPPBarrageContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self addSubview:self.avatarView];
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.class.avatarLeft);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(self.class.avatarW);
        }];
        self.clipsToBounds = YES;
        self.avatarView.backgroundColor = UIColor.lightGrayColor;
        
        //
        [self addSubview:self.lab];
        [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarView.mas_right).offset(self.class.textLeft);
            make.centerY.mas_equalTo(0);
//            make.height.mas_equalTo(16);
        }];
        
        //
        UIView *labBGView = UIView.new;
        [self insertSubview:labBGView atIndex:0];
        [labBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarView);
            make.right.mas_equalTo(self.lab).offset(self.class.textRight);
            make.top.mas_equalTo(self.avatarView);
            make.bottom.mas_equalTo(self.avatarView);
        }];
        labBGView.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.08];
        labBGView.layer.cornerRadius = self.class.avatarW / 2;
        labBGView.clipsToBounds = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.avatarView.layer.cornerRadius = self.avatarView.bounds.size.height/2;
}

- (void)setModel:(TPPBarrageModel *)model {
    _model = model;
    
//    self.avatarView.image = [UIImage imageNamed:@"icon_my_press"];
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
    return 11;
}

+ (CGFloat)avatarW {
    return 20;
}

+ (CGFloat)textLeft {
    return 4;
}

+ (CGFloat)textRight {
    return 11;
}

+ (CGFloat)widthWithTextWidth:(CGFloat)textWidth {
    return self.avatarLeft + self.avatarW + self.textLeft + textWidth + self.textRight;
}

@end

@implementation TPPBarrageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //
        [self.contentView addSubview:self.barrageContentView];
        [self.barrageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        self.barrageContentView.clipsToBounds = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.barrageContentView.layer.cornerRadius = self.contentView.bounds.size.height / 2;
}

- (void)setModel:(TPPBarrageModel *)model {
    self.barrageContentView.model = model;
}

- (TPPBarrageModel *)model {
    return self.barrageContentView.model;
}

- (UIFont *)font {
    return self.barrageContentView.font;
}

- (TPPBarrageContentView *)barrageContentView {
    if (!_barrageContentView) {
        TPPBarrageContentView *view = [[TPPBarrageContentView alloc] initWithFrame:CGRectZero];
        
        _barrageContentView = view;
    }
    return _barrageContentView;
}

+ (CGFloat)widthWithTextWidth:(CGFloat)textWidth {
    return [TPPBarrageContentView widthWithTextWidth:textWidth];
}

@end
