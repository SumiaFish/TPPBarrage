//
//  ViewController.m
//  TPPBarrage
//
//  Created by Kevin on 9/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"

#import "TPPBarrageView.h"

#import "CustomBarrgeCell.h"

#import "TPPBarrgeContainerView.h"

@interface ViewController ()

@property (strong, nonatomic) TPPBarrgeContainerView *barrageContainerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.barrageContainerView];
    [self.barrageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.height.mas_equalTo(75);
    }];
   
    //
    self.barrageContainerView.headerView.model = [self loadHeaderData];
    self.barrageContainerView.barrageView.data = [self loadBarrages];
//    [self.barrageContainerView.barrageView registCell:CustomBarrgeCell.class];
    [self.barrageContainerView.barrageView play];
}

- (NSArray<TPPBarrageModel *> *)loadBarrages {
    NSMutableArray<TPPBarrageModel *> *data = NSMutableArray.array;
    
    UIFont *font = [UIFont systemFontOfSize:11];
    for (NSInteger i = 0; i < 1000; i++) {
        TPPBarrageModel *model = [[TPPBarrageModel alloc] init];
        model.attText = ({
            NSString *t1 = [self.class random:[self.class getRandomNumber:1 to:50]];
            NSArray<UIColor *> *colors = @[
                UIColor.redColor,
                UIColor.orangeColor,
                UIColor.purpleColor,
                UIColor.blueColor,
                UIColor.brownColor,
            ];
            UIColor *color = colors[i % colors.count];
            NSMutableAttributedString *res = [[NSMutableAttributedString alloc] initWithString:t1];
            [res addAttributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: font} range:NSMakeRange(0, t1.length)];
            res;
        });
        model.avatar = @"https://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=%E5%9B%BE%E7%89%87&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=3922290090,3177876335&os=814333916,154083731&simid=39490595,826993982&pn=8&rn=1&di=95040&ln=1566&fr=&fmq=1601371306192_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=0&objurl=http%3A%2F%2Fa3.att.hudong.com%2F55%2F22%2F20300000929429130630222900050.jpg&rpstart=0&rpnum=0&adpicid=0&force=undefined";
        
        [data addObject:model];
    }
    
    return data;
}

- (TPPBarrageHeaderModel *)loadHeaderData {
    TPPBarrageHeaderModel *model = [[TPPBarrageHeaderModel alloc] init];
    model.avatars = @[@"1", @"2", @"3", @"4", @"5"];
    model.onlineTotalCount = 10000;
    model.onlineTotalAttText = ({
        NSString *t1 = @(model.onlineTotalCount).stringValue;
        NSString *t2 = @"人在热聊...";
        NSMutableAttributedString *res = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", t1, t2]];
        [res addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11 weight:(UIFontWeightMedium)], NSForegroundColorAttributeName: [TPPBarrageHelper colorWithHexString:@"#3A3945"]} range:NSMakeRange(0, res.string.length)];
        res;
    });
    
    return model;
}

- (IBAction)buttonAction:(id)sender {
    [self.barrageContainerView removeFromSuperview];
    self.barrageContainerView = nil;
}

- (TPPBarrgeContainerView *)barrageContainerView {
    if (!_barrageContainerView) {
        TPPBarrgeContainerView *view = [[TPPBarrgeContainerView alloc] initWithRows:2];
        
        view.barrageView.onClickItemBlock = ^(TPPBarrageView * _Nonnull view, TPPBarrageModel * _Nonnull model) {
            TPPBarrageLog(@"click item: %@", model.attText.string);
        };
        
        _barrageContainerView = view;
    }
    
    return _barrageContainerView;
}

// 随机数 [from,to]
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
   return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

// 随机生成字符串(由大小写字母、数字组成)
+ (NSString *)random: (NSInteger)len {
    
    char ch[len];
    for (int index=0; index<len; index++) {
        
        int num = arc4random_uniform(75)+48;
        if (num>57 && num<65) { num = num%57+48; }
        else if (num>90 && num<97) { num = num%90+65; }
        ch[index] = num;
    }
    
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}

// 随机生成字符串(由大小写字母组成)
+ (NSString *)randomNoNumber: (NSInteger)len {
    
    char ch[len];
    for (int index=0; index<len; index++) {
        
        int num = arc4random_uniform(58)+65;
        if (num>90 && num<97) { num = num%90+65; }
        ch[index] = num;
    }
    
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}

@end
