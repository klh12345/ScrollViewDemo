//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by 中国孔 on 2019/2/27.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "ViewController.h"
#import "HeaderItems.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
@interface ViewController ()<UIScrollViewDelegate>
@property (strong , nonatomic) UIScrollView *scrollView;
@property (strong , nonatomic) HeaderItems *items;
@property (assign , nonatomic) BOOL isContentScroll;

@property (strong , nonatomic) NSArray *imageArray;
@end
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ScrollView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArray = @[@"dt_di_slices",@"gt_di_slices",@"pt_di_slices"];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.scrollView];
    
    _scrollView.contentSize = CGSizeMake(ScreenW * self.items.titleArray.count, ScreenH -statusBarHeight - 44-44);
    
    [self loadimageView];
    
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
    self.isContentScroll = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.x;
    
//    NSLog(@"%f",offset);
    
    [self fixHeaderbuttonpresser:offset];
    
}



- (void)fixHeaderbuttonpresser:(CGFloat)offset{
    
    if (!self.isContentScroll) {
        
        for (int i = 0; i < self.items.titleArray.count; i ++) {
            
            CGFloat f = offset/ScreenW;

            [self.items setCurrntPage:f];
            
        }
        
    }
    
  
}



// 在ScrolView 上添加图片
- (void)loadimageView{
    
    for (int i = 0; i < self.items.titleArray.count; i ++) {
        int f = arc4random()%self.imageArray.count;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW*i, 0, ScreenW,self.scrollView.frame.size.height)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArray[f]]];
        [self.scrollView addSubview:image];
        
    }
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,statusBarHeight+44+44, ScreenW, ScreenH-statusBarHeight-44-44)];
        _scrollView.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    
    return _scrollView;
}


- (HeaderItems *)items{
    
    if (!_items) {
        
        _items = [[HeaderItems alloc] initWithFrame:CGRectMake(0,statusBarHeight+44, ScreenW, 44)];
         _items.titleArray = @[@"推荐GG",@"关注GG",@"热点GG",@"体育GG",@"新闻GG",@"文学GG",@"诗词GG",@"娱乐GG"];
        _items.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
       
        __weak typeof(self) weakself=self;
        self.items.currentSelect = ^(NSInteger currentSelected) {
         
            weakself.isContentScroll = YES;
            [weakself.scrollView scrollRectToVisible:CGRectMake(ScreenW * currentSelected, 0, ScreenW, ScreenH-statusBarHeight-44-44) animated:YES];
    
        };
        
        
        
        
        
        
        [self.view addSubview:self.items];
//        self.isContentScroll = YES;
    }
    
    return _items;
}


@end
