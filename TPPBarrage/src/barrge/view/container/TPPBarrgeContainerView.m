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
@property (strong, nonatomic) CAGradientLayer *barrageHeaderLayer;

@property (assign, nonatomic) BOOL didObserved;

@end

@implementation TPPBarrgeContainerView

- (void)dealloc {
    if (self.didObserved) {
        [self.headerView removeObserver:self forKeyPath:@"model"];
    }
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
            make.top.left.mas_equalTo(0);
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(22);
        }];
        
        //
        self.barrageHeaderLayer = makeGradientLayer(@[
            (__bridge id)[TPPBarrageHelper colorWithHexString:@"#75FFFA"].CGColor,
            (__bridge id)[TPPBarrageHelper colorWithHexString:@"#7AFFD1"].CGColor,
        ]);
        [self.headerView.layer insertSublayer:self.barrageHeaderLayer atIndex:0];
        
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
        
        //
        [self.headerView addObserver:self forKeyPath:@"model" options:(NSKeyValueObservingOptionNew) context:nil];
        self.didObserved = YES;
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.headerView &&
        [keyPath isEqualToString:@"model"]) {
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([TPPBarrgeHeaderView width:self.headerView.model]);
        }];
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgLayer.frame = self.bgView.bounds;
    
    self.barrageHeaderLayer.frame = self.headerView.bounds;
    [self.barrageHeaderLayer.mask removeFromSuperlayer];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.barrageHeaderLayer.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.barrageHeaderLayer.bounds;
    maskLayer.path = maskPath.CGPath;
    self.barrageHeaderLayer.mask = maskLayer;
}

@end
