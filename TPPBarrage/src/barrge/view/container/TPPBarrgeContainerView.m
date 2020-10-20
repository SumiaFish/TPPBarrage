//
//  TPPBarrgeContainerView.m
//  TPPBarrage
//
//  Created by Mac on 10/19/20.
//  Copyright © 2020 Kevin. All rights reserved.
//

#import "TPPBarrgeContainerView.h"

@interface TPPBarrgeContainerView ()

@property (strong, nonatomic) TPPBarrgeHeaderView *headerView;
@property (strong, nonatomic) TPPBarrageView *barrageView;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) CAGradientLayer *bgLayer;

@end

@implementation TPPBarrgeContainerView

- (void)dealloc {
    TPPBarrageLog(@"%@ dealloc~", NSStringFromClass(self.class));
}

- (instancetype)initWithRows:(NSInteger)rows; {
    if (self = [super initWithFrame:CGRectZero]) {
        CAGradientLayer * (^ makeGradientLayer) (NSArray *colors) = ^ (NSArray *colors) {
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = colors;
            gradientLayer.locations = @[@0, @0.75, @1.0];
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 0);
            gradientLayer.frame = CGRectZero;
            return gradientLayer;
        };
        
        //
        self.bgView = UIView.new;
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        self.backgroundColor = UIColor.clearColor;
        self.bgView.backgroundColor = UIColor.lightGrayColor;
        self.bgView.layer.cornerRadius = 10;
        self.bgView.clipsToBounds = YES;
        
        //
        self.bgLayer = makeGradientLayer(@[
            (__bridge id)[TPPBarrageHelper colorWithHexString:@"#6A6E85"].CGColor,
            (__bridge id)[TPPBarrageHelper colorWithHexString:@"#494B59"].CGColor,
        ]);
        [self.bgView.layer insertSublayer:self.bgLayer atIndex:0];
        
        //
        self.headerView = [[TPPBarrgeHeaderView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(77);
        }];
        
        //
        self.barrageView = [[TPPBarrageView alloc] initWithRows:rows];
        [self insertSubview:self.barrageView belowSubview:self.headerView];
        [self.barrageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(6);
            make.bottom.mas_equalTo(-6);
            make.left.right.mas_equalTo(0);
        }];
        self.barrageView.speed = 50;
        self.barrageView.isRepeat = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgLayer.frame = self.bgView.bounds;
}

@end
