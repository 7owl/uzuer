//
//  PageZoomViewController.m
//  NewPhotoScvDemo
//
//  Created by zj_apple on 15-1-23.
//  Copyright (c) 2015年 zj_apple. All rights reserved.
//

#import "PageZoomViewController.h"
#import "ZoomScrollView.h"

@interface PageZoomViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
}
@end

@implementation PageZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.title = @"组合";
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self loadUIView];
}

-(void)loadUIView{
    
    NSInteger pageCount = MAX(_arrImage.count, _arrImgUrlStr.count);
    /**
     scrollView
     */
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [_scrollView setFrame:self.view.frame];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(pageCount*_scrollView.frame.size.width, _scrollView.frame.size.height)];
    for (int i=0; i<pageCount; i++) {
        CGRect rectSCV = _scrollView.frame;
        rectSCV.origin.x = i*_scrollView.frame.size.width;
        
        //superView
        ZoomScrollView * sepScv = [[ZoomScrollView alloc]initWithFrame:rectSCV];
        //给scrollView赋值
        if (i >= _arrImage.count) {
            [sepScv setImageZoom:nil];
        }else{
            [sepScv setImageZoom:_arrImage[i]];
        }
        [sepScv setImgURL:_arrImgUrlStr[i]];
        __weak id wself = self;
        [sepScv setBlockImageTap:^{
           //点击图片
            [wself imageSingleTapActionWithIndex:i];
        }];
        [_scrollView addSubview:sepScv];
    }
    [self.view addSubview:_scrollView];
    
    /**
     pageControl
     */
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    _pageControl.center = CGPointMake(_scrollView.frame.size.width/2.0, _scrollView.frame.size.height-60);
    _pageControl.currentPage = _intStartIndex;
    _pageControl.numberOfPages = pageCount;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_pageControl];
    
    [_scrollView scrollRectToVisible:CGRectMake(_intStartIndex * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray * subArray = [scrollView subviews];
//    for (id subView in subArray) {
//        if ([subView isKindOfClass:[UIScrollView class]]) {
//            UIScrollView * scv = (UIScrollView *)subView;
//            [scv setScrollEnabled:NO];
//        }
//    }
    CGFloat pageWidth = _scrollView.frame.size.width;
    //floorf向下取整：(NSInteger)floorf()
    NSInteger page = (NSInteger)floorf((_scrollView.contentOffset.x-pageWidth/2)/pageWidth+1);
    _pageControl.currentPage = page;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSArray * subArray = [scrollView subviews];
    
    for (id subView in subArray) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            UIScrollView * scv = (UIScrollView *)subView;
            [scv setScrollEnabled:YES];
        }
    }
}
-(void)imageSingleTapActionWithIndex:(NSInteger)index
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)dealloc
{
#warning 这里不加一个移除操作，推出VC的时候就会崩溃？但是我不知道为什么呀
    [_scrollView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
