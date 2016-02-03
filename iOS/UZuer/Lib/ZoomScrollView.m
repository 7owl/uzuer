//
//  ZoomScrollView.m
//  NewPhotoScvDemo
//
//  Created by zj_apple on 15-1-23.
//  Copyright (c) 2015年 zj_apple. All rights reserved.
//

#import "ZoomScrollView.h"
#import "UIImageView+WebCache.h"

#define ZOOM_STEP 1.5f

@implementation ZoomScrollView
{
    UIImageView * _imageView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
//        [self loadUIView];
    }
    return self;
}
-(void)setImageZoom:(UIImage *)imageZoom
{
    _imageZoom = imageZoom;
    [self loadUIView];
}
-(void)setImgURL:(NSString *)imgURL
{
    _imgURL = imgURL;
    [self loadUIView];
}
-(void)loadUIView
{
    //scrollView初始化t
    self.delegate = self;
    self.scrollEnabled = YES;
    self.bouncesZoom = YES;
    [self setShowsHorizontalScrollIndicator:YES];
    [self setShowsVerticalScrollIndicator:YES];
    
    //添加手势
    UITapGestureRecognizer * doubleTapRec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRec.numberOfTapsRequired = 2;
    doubleTapRec.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:doubleTapRec];
    
    UITapGestureRecognizer * singleTapRec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewSingleTapped:)];
    singleTapRec.numberOfTapsRequired = 1;
    singleTapRec.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTapRec];
    //区分点击事件重点语句：在双击失败后才会触发单击
    [singleTapRec requireGestureRecognizerToFail:doubleTapRec];
    
    //imageView初始化
    _imageView = [[UIImageView alloc]initWithImage:_imageZoom];
    _imageView.userInteractionEnabled = YES;
    
    
    if (_imageZoom) {
        [self fillImageViewInScrollViewWithImage:_imageZoom];
    }else{
        DLog(@"现成图片不存在，试从网络获取:%@",_imgURL);
        __block id weakSelf = self;
        UIImage * imageDefault = [UIImage imageNamed:@"placeholder_picture"];//[UIImage imageNamed:@"text_headerimg"];
        if(_imgURL){
            UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [activityView setCenter: self.center];
            [activityView startAnimating];
            [self addSubview:activityView];
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_imgURL] placeholderImage:imageDefault completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [activityView stopAnimating];
                [weakSelf fillImageViewInScrollViewWithImage:image];
            }];
        }else{
            //填充默认图
            [self fillImageViewInScrollViewWithImage:imageDefault];
        }
    }
}
-(void)fillImageViewInScrollViewWithImage:(UIImage *)image
{
    CGRect rectImvFrame = self.frame;
    CGSize imgSize = image.size;
    CGFloat scaleMin;
    if (imgSize.width > self.frame.size.width||imgSize.height > self.frame.size.height) {
        CGFloat scaleWidth = rectImvFrame.size.width/imgSize.width;
        CGFloat scaleHeight = rectImvFrame.size.height/imgSize.height;
        scaleMin = MIN(scaleWidth, scaleHeight);//让图像以合适比例完整呈现
    }else{
        scaleMin = 1.0;
    }
    rectImvFrame.origin.x = 0;
    rectImvFrame.size.width = imgSize.width;
    rectImvFrame.size.height = imgSize.height;
    rectImvFrame = CGRectInset(rectImvFrame, 10, 10);
    [_imageView setFrame:rectImvFrame];
    [self addSubview:_imageView];
    /*
     //不需要自己对imageView的大小做处理，直接设置成图片大小即可，后面会根据scale值自动处理的
     rectImvFrame = CGRectMake(0, 0, imgSize.width*scaleMin, imgSize.height*scaleMin);
     */
    
    //设置最大最小缩放比例
    self.maximumZoomScale = scaleMin*2;
    self.minimumZoomScale = scaleMin;
    
    //设置scrollView的zoomScale值之后，会自动调用viewForZoomingInScrollView方法，对图片进行zoomScale的缩放处理，也就是说你不必自己处理imageView的大小，只需要传入合适的zoomScale就可以了，避免产生重复缩放
    self.zoomScale = scaleMin;
}
-(void)scrollViewSingleTapped:(UITapGestureRecognizer *)recognizer
{
    if (_blockImageTap) {
        _blockImageTap();
    }
}
-(void)scrollViewDoubleTapped:(UITapGestureRecognizer *)recognizer
{
    DLog(@"1scv/scale:%.1f",self.zoomScale);
    /**
     *  处理缩放尺寸
     */
    CGFloat newZoomScale;
    if (self.zoomScale == self.maximumZoomScale) {
        newZoomScale = self.minimumZoomScale;
    }else{
        newZoomScale = self.zoomScale*ZOOM_STEP;
        newZoomScale = (newZoomScale > self.maximumZoomScale)?self.maximumZoomScale :newZoomScale;
    }
    [self setZoomScale:newZoomScale];
    [self resetImageViewFrame];
    
    //双击不会触发scrollViewDidEndZooming方法
}
#pragma mark - scrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    [self resetImageViewFrame];
    return _imageView;
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGFloat newZoomScale;
    if (scale > self.maximumZoomScale) {
        newZoomScale = self.maximumZoomScale;
    }else if (scale < self.minimumZoomScale) {
        newZoomScale = self.minimumZoomScale;
    }else{
        newZoomScale = scale;
    }
    [self setZoomScale:newZoomScale];
    
    [self resetImageViewFrame];
}
/**
 *  调整图片的中心位置
 */
-(void)resetImageViewFrame{
    CGRect rectImv = _imageView.frame;
    CGRect rectScv = self.frame;
    if (rectImv.size.width <= rectScv.size.width && rectImv.size.height <= rectScv.size.height) {
        _imageView.center = CGPointMake(rectScv.size.width/2.0, rectScv.size.height/2.0);
       // DLog(@"center:%@",NSStringFromCGPoint(_imageView.center));
    }else{
        CGPoint pointImvCenter;
        pointImvCenter.y = (self.contentSize.height < self.frame.size.height) ? self.frame.size.height/2.0 : self.contentSize.height/2.0;
        pointImvCenter.x = (self.contentSize.width < self.frame.size.width) ? self.frame.size.width/2.0 :self.contentSize.width/2.0;
        _imageView.center = pointImvCenter;
    }
    self.contentSize = _imageView.frame.size;
}
@end
