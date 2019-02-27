//
//  HeaderItems.h
//  ScrollViewDemo
//
//  Created by 中国孔 on 2019/2/27.
//  Copyright © 2019 孔令辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^currentSelect) (NSInteger currentSelected);

@interface HeaderItems : UIView

@property (strong , nonatomic) UIScrollView *scrollView;
@property (strong , nonatomic) NSArray *titleArray;

@property (assign , nonatomic) NSInteger currntPage;//当前滚动页

@property (strong , nonatomic) void(^currentSelect) (NSInteger currentSelected);


@end

NS_ASSUME_NONNULL_END
