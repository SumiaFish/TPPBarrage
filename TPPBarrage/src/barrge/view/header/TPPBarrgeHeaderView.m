//
//  TPPBarrgeHeaderView.m
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "TPPBarrgeHeaderView.h"

@interface TPPBarrgeHeaderView ()

@property (strong, nonatomic) UIImageView *bgView;
@property (strong, nonatomic) UIImageView *imgView1;
@property (strong, nonatomic) UIImageView *imgView2;

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
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        //
        [self addSubview:self.imgView1];
        [self.imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(9);
            make.right.mas_equalTo(-9);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(12);
        }];
        
        //
        [self addSubview:self.imgView2];
        [self.imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(4);
            make.left.mas_equalTo(18);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(8);
        }];

        //
        UILabel *lab = UILabel.new;
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-8.5);
        }];
        lab.text = @"热聊中...";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = UIColor.whiteColor;
        lab.font = [UIFont systemFontOfSize:11 weight:(UIFontWeightBold)];
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
    [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:self.model.avatars.firstObject] placeholderImage:[UIImage imageNamed:@"对话1"]];
    [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:self.model.avatars.lastObject] placeholderImage:[UIImage imageNamed:@"对话2"]];
}

- (UIImageView *)bgView {
    if (!_bgView) {
        UIImageView *view = UIImageView.new;
        view.image = [UIImage imageNamed:@"组 465"];
        _bgView = view;
    }
    
    return _bgView;
}

- (UIImageView *)imgView1 {
    if (!_imgView1) {
        UIImageView *view = UIImageView.new;
        view.image = [UIImage imageNamed:@"对话1"];
        _imgView1 = view;
    }
    
    return _imgView1;
}

- (UIImageView *)imgView2 {
    if (!_imgView2) {
        UIImageView *view = UIImageView.new;
        view.image = [UIImage imageNamed:@"对话2"];
        _imgView2 = view;
    }
    
    return _imgView2;
}

@end
