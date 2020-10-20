//
//  TPPBarrgeHeaderView.m
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "TPPBarrgeHeaderView.h"

@interface TPPBarrgeHeaderView ()

@property (strong, nonatomic, readwrite) UIView *avatarsContainerView;
@property (strong, nonatomic, readwrite) UILabel *onlineLab;

@end

@implementation TPPBarrgeHeaderView

- (void)dealloc {
    TPPBarrageLog(@"%@ dealloc~", NSStringFromClass(self.class));
}

- (instancetype)init {
    return [[self.class alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.avatarsContainerView];
        [self.avatarsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0);
        }];
        
        [self addSubview:self.onlineLab];
        [self.onlineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.avatarsContainerView.mas_right).offset(self.class.onlineLabLeft);
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupViews];
}

- (void)setModel:(TPPBarrageHeaderModel *)model {
    _model = model;
    
    [self setupViews];
}

#pragma mark -

- (void)setupViews {
    [self.avatarsContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.model.avatars enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 2) {
            *stop = YES;
            return;
        }
        
        //
        UIImageView *view = UIImageView.new;
        [self.avatarsContainerView insertSubview:view atIndex:0];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.class.top);
            make.left.mas_equalTo(idx == 0 ? self.class.left0 : self.class.left1);
            make.width.mas_equalTo(idx == 0 ? self.class.w0 : self.class.w1);
            make.height.mas_equalTo(view.mas_width).multipliedBy(1);
        }];
        view.backgroundColor = UIColor.lightGrayColor;
        
        view.layer.cornerRadius = (idx == 0 ? self.class.w0 : self.class.w1) / 2;
        view.clipsToBounds = YES;
        view.layer.borderWidth = 1;
        view.layer.borderColor = UIColor.whiteColor.CGColor;
    }];
    
    [((UIImageView *)self.avatarsContainerView.subviews.firstObject) sd_setImageWithURL:[NSURL URLWithString:self.model.avatars.lastObject]];
    
    [((UIImageView *)self.avatarsContainerView.subviews.lastObject) sd_setImageWithURL:[NSURL URLWithString:self.model.avatars.firstObject]];

    [self.avatarsContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.avatarsW);
    }];
    
    //
    if (self.model.onlineTotalAttText) {
        self.onlineLab.attributedText = self.model.onlineTotalAttText;
    } else {
        self.onlineLab.text = @(self.model.onlineTotalCount).stringValue;
    }
}

- (UIView *)avatarsContainerView {
    if (!_avatarsContainerView) {
        UIView *view = UIView.new;
        _avatarsContainerView = view;
    }
    
    return _avatarsContainerView;
}

- (UILabel *)onlineLab {
    if (!_onlineLab) {
        UILabel *lab = UILabel.new;
        _onlineLab = lab;
    }
    
    return _onlineLab;
}

- (CGFloat)avatarsW {
    if (self.model.avatars.count) {
        if (self.model.avatars.count == 1) {
            return self.class.left0 + self.class.w0;
        }
        
        return self.class.left1 + self.class.w1;
    }
    
    return 0;
}

+ (CGFloat)top {
    return 1.5;
}

+ (CGFloat)w0 {
    return 10.25;
}

+ (CGFloat)w1 {
    return self.designHeight - self.top * 2;
}

+ (CGFloat)left0 {
    return 4;
}

+ (CGFloat)left1 {
    return 7;
}

+ (CGFloat)designHeight {
    return 22;
}

+ (CGFloat)onlineLabLeft {
    return 6;
}

+ (CGFloat)onlineLabRight {
    return 6;
}

+ (CGFloat)avatarsW:(TPPBarrageHeaderModel *)model {
    if (model.avatars.count) {
        if (model.avatars.count == 1) {
            return self.class.left0 + self.class.w0;
        }
        
        return self.class.left1 + self.class.w1;
    }
    
    return 0;
}

+ (CGFloat)width:(TPPBarrageHeaderModel *)model {
    return [self avatarsW:model] + self.onlineLabLeft + model.onlineTotalAttText.tppBarrage_TextWidth + self.onlineLabRight;
}

@end
