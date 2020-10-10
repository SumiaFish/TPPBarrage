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

@interface ViewController ()

@property (copy, nonatomic) NSArray<TPPBarrageModel *> *data;

@property (strong, nonatomic) TPPBarrageView *barrageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self.view addSubview:self.barrageView];
    self.barrageView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 300);

    //
    [self loadData];
    self.barrageView.data = self.data;
    self.barrageView.speed = 50;
    self.barrageView.isRepeat = YES;
    [self.barrageView play];
}

- (void)loadData {
    NSMutableArray<TPPBarrageModel *> *data = NSMutableArray.array;
    
    UIFont *font = self.barrageFont;
    for (NSInteger i = 0; i < 1000; i++) {
        TPPBarrageModel *model = [[TPPBarrageModel alloc] init];
        model.text = [self.class random:[self.class getRandomNumber:1 to:50]];
        model.avatar = @"https://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=%E5%9B%BE%E7%89%87&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=3922290090,3177876335&os=814333916,154083731&simid=39490595,826993982&pn=8&rn=1&di=95040&ln=1566&fr=&fmq=1601371306192_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=0&objurl=http%3A%2F%2Fa3.att.hudong.com%2F55%2F22%2F20300000929429130630222900050.jpg&rpstart=0&rpnum=0&adpicid=0&force=undefined";
        model.font = font;
        
        [data addObject:model];
    }
    
    self.data = data;
}

- (IBAction)buttonAction:(id)sender {
    [self.barrageView removeFromSuperview];
    self.barrageView = nil;
}

- (TPPBarrageView *)barrageView {
    if (!_barrageView) {
        TPPBarrageView *view = [[TPPBarrageView alloc] initWithFont:self.barrageFont rows:3];
        view.backgroundColor = UIColor.lightGrayColor;
        
//        __weak typeof(self) weakself = self;
        view.onClickItemBlock = ^(TPPBarrageView * _Nonnull view, TPPBarrageModel * _Nonnull model) {
            TPPBarrageViewLog(@"click item: %@", model.text);
        };
        
        [view registCell:CustomBarrgeCell.class];
//        [view registCell:TPPBarrageCell.class];
        
        _barrageView = view;
    }
    
    return _barrageView;
}

- (UIFont *)barrageFont {
    return [UIFont systemFontOfSize:14];
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
