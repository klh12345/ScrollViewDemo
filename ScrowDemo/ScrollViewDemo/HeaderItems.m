//
//  HeaderItems.m
//  ScrollViewDemo
//
//  Created by 中国孔 on 2019/2/27.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import "HeaderItems.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface HeaderItems ()<UIScrollViewDelegate>
@property (strong , nonatomic) NSString *titles;
@property (strong , nonatomic) UIView *bottomView;
// 当前选中的按钮
@property (strong , nonatomic) UIButton *currentBtn;
// 存放所有的按钮
@property (strong , nonatomic) NSMutableArray *totalBtn;

@end
@implementation HeaderItems

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initScrollView{
    
   
    
}


- (void)setCurrntPage:(NSInteger)currntPage{
    
    // 解决第一次滚动时候相互引用的死循环问题 必须实现
    if (_currntPage == currntPage) {
        return;
    }
    
    _currntPage = currntPage;
    if (self.titleArray.count == 0) {
        return;
    }
    
    UIButton *prebutton = self.totalBtn[currntPage];

    [self selectStatusWithbutton:prebutton];
    
}


- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    BOOL islarge = [self islargeScreen];
    
    [self addSubview:self.scrollView];
    NSInteger contentOffset = 0;
    if (islarge) {
        
        for (int i = 0; i < self.titleArray.count; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:200.0f/255.0f alpha:1.0f] forState:UIControlStateSelected];
            [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
            button.tag = i;
            button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
            [button sizeToFit];
            
            CGFloat btnX = i ? 35+contentOffset : 15;
            button.frame = CGRectMake(btnX, 0, button.frame.size.width, 40);
            
            contentOffset = CGRectGetMaxX(button.frame);
            button.titleLabel.textAlignment = NSTextAlignmentLeft;
            [button addTarget:self action:@selector(selectStatusWithbutton:) forControlEvents:UIControlEventTouchUpInside];
            
            button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            
            [self.scrollView addSubview:button];
            [self.totalBtn addObject:button];
            if (i == 0) {

                button.selected = YES;
                button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                self.bottomView.frame = CGRectMake(button.frame.origin.x, self.scrollView.frame.size.height-2, button.frame.size.width, 2);
                self.currentBtn = button;
                self.bottomView.frame = CGRectMake(button.frame.origin.x, self.scrollView.frame.size.height-2, button.frame.size.width, 2);
                [self.scrollView addSubview:self.bottomView];
            }
            
            
        }
        
       
        
        
        
    }
    
    
    self.scrollView.contentSize = CGSizeMake(contentOffset+35, 40);
    
}






- (void)selectStatusWithbutton:(UIButton *)button{
    
    // 1.根据内容页面滚动方法 处理头部显示逻辑
    self.currentBtn.selected = NO;
    self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
   
    self.currentBtn = button;
    self.currentBtn.selected = YES;
    self.currentBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (button.tag == 0) {
            [self.scrollView scrollRectToVisible:CGRectMake(0, 0, ScreenW, 44) animated:YES];
    
        }
        else{
            
            UIButton *prebutton = self.totalBtn[button.tag-1];
            CGFloat offSet = CGRectGetMaxX(prebutton.frame) - 35;
            
            [self.scrollView scrollRectToVisible:CGRectMake(offSet, 0, ScreenW, 44) animated:YES];
        }
        
         self.bottomView.frame = CGRectMake(button.frame.origin.x, self.scrollView.frame.size.height-2, button.frame.size.width, 2);
        
    }];
    
    
    // 回传当前状态到主页面处理content显示逻辑
    if (self.currentSelect) {
        self.currntPage = button.tag;
        self.currentSelect(button.tag);
    }
    
    
}



- (BOOL)islargeScreen{
    
    CGFloat labelWidth = 0;
    // 要加上第一个空格的距离
    labelWidth += 13;
    for (int i = 0; i < self.titleArray.count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.text = self.titleArray[i];
        
        [label sizeToFit];
        labelWidth += label.frame.size.width;
        labelWidth += 15;
        
    }
    
    if (labelWidth < ScreenW - 15) {
        
        return NO;
    }else{
        
        return YES;
    }
    
}


- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        
    }
    return _scrollView;
}


- (UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor redColor];
        
    }
    return _bottomView;
    
}

- (NSMutableArray *)totalBtn{
    
    if (!_totalBtn) {
        
        _totalBtn = [NSMutableArray array];
    }
    return _totalBtn;
}



@end
