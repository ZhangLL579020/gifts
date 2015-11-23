//
//  MMDViewController.m
//  ZLL礼物说
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 zhangliang.com. All rights reserved.
//

#import "SlideSwitchViewController.h"
#import "ListViewController.h"
#import "DataManager.h"
#import "DataMessage.h"
@interface SlideSwitchViewController () <SUNSlideSwitchViewDelegate>

//列表
@property (nonatomic, strong) ListViewController *vc1;
@property (nonatomic, strong) ListViewController *vc2;
@property (nonatomic, strong) ListViewController *vc3;
@property (nonatomic, strong) ListViewController *vc4;
@property (nonatomic, strong) ListViewController *vc5;
@property (nonatomic, strong) ListViewController *vc6;
@property (nonatomic, strong) ListViewController *vc7;


//自定义滑动类(主要使用里面的代理方法)
@property (nonatomic, strong) SUNSlideSwitchView *slideSwitchView;

@end

@implementation SlideSwitchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self settingSlideSwitchView];


    
}

#pragma mark -- settingSlideSwitchView

- (void)settingSlideSwitchView{
    
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.frame];
    //设置代理
    _slideSwitchView.slideSwitchViewDelegate = self;
    
    [self.view addSubview:self.slideSwitchView];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //设置滑块文字的属性
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    //设置滑动标题
    self.vc1 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc1.title = @"精品";
    
    self.vc2 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc2.title = @"礼物";
    
    self.vc3 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc3.title = @"海淘";
    
    self.vc4 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc4.title = @"美食";
    
    self.vc5 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc5.title = @"数码";
    
    self.vc6 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc6.title = @"运动";
    
    self.vc7 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
    self.vc7.title = @"涨姿势";
    
    //设置活动左边的按钮
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightSideButton setImage:[[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [rightSideButton setImage:[UIImage imageNamed:@"1"]  forState:UIControlStateHighlighted];
    rightSideButton.frame = CGRectMake(0, 0, 30.0f, 44.0f);
    rightSideButton.userInteractionEnabled = NO;
    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    [self.slideSwitchView buildUI];
}

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 7;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else if (number == 4) {
        return self.vc5;
    } else if (number == 5) {
        return self.vc6;
    } else if (number == 6){
        return self.vc7;
    }else{
        return nil;
    }
}



- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    ListViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;

        //下拉刷新
        [self requestData:vc urlStr:kURL_1];
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_1];
        }];
        
        //上拉刷加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_A];
        }];
    } else if (number == 1) {
        vc = self.vc2;

        [self requestData:vc urlStr:kURL_4];
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_4];
        }];
        //上拉刷加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_B];
        }];


    } else if (number == 2) {
        vc = self.vc3;

        [self requestData:vc urlStr:kURL_5];
        
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_5];
        }];
        //上拉刷加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_C];
        }];


    } else if (number == 3) {
        vc = self.vc4;

        [self requestData:vc urlStr:kURL_6];
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_6];
        }];
        //上拉刷加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_D];
        }];


     
    } else if (number == 4) {
        vc = self.vc5;

        [self requestData:vc urlStr:kURL_7];
        //上拉刷加载
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_7];
        }];
        
        //上拉刷加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_E];
        }];
        
       
    } else if (number == 5) {
        vc = self.vc6;

        [self requestData:vc urlStr:kURL_8];
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_8];
        }];
        //上拉加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_F];
        }];
        
    }else{
        vc = self.vc7;
    
        [self requestData:vc urlStr:kURL_9];
        vc.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestData:vc urlStr:kURL_9];
        }];
        //上拉加载
        vc.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self requestDataBottom:vc urlStr:kURL_G];
        }];
    }
    
}

- (void) requestData:(ListViewController *)listVC urlStr:(NSString *)url{
    
    [[DataManager sharedManage]sharedData:url block:^(id block) {
        if (listVC.array.count) {
            
            [listVC.array removeAllObjects];
            
        }
        NSDictionary *dic =[(NSMutableDictionary *)block objectForKey:@"data"];
        NSArray *array = dic[@"items"];
        for (NSDictionary *dic in array) {
            DataMessage *model = [[DataMessage alloc] initWithDictionary:dic];
            
            [listVC.array addObject:model];
        }
        [listVC.tableView reloadData];
        
        [listVC.tableView.mj_header endRefreshing];
    }];
    
   
}

- (void) requestDataBottom:(ListViewController *)listVC urlStr:(NSString *)url{
    
    if (listVC.array.count) {
        
       NSString * num = [NSString stringWithFormat:@"%ld",listVC.array.count];
        
        NSString *urlStr = [url stringByAppendingString:num];
        
        [[DataManager sharedManage]sharedData:urlStr block:^(id block) {
            

            NSDictionary *dic =[(NSMutableDictionary *)block objectForKey:@"data"];
            NSArray *array = dic[@"items"];
            for (NSDictionary *dic in array) {
                DataMessage *model = [[DataMessage alloc] initWithDictionary:dic];
                
                [listVC.array addObject:model];
            }
            [listVC.tableView reloadData];
            
            [listVC.tableView.mj_footer endRefreshing];
        }];
        
    }
    
}


@end
