//
//  NDIntroPageView.m
//  NDParallaxIntroView
//
//  Created by Simon Wicha on 17/04/2016.
//  Copyright © 2016 Simon Wicha. All rights reserved.
//

#import "NDIntroView.h"
#import "NDIntroPageView.h"
#import "NDPageA.h"
#import "NDPageB.h"
#import "NDPageC.h"
#import "NDPageD.h"

@interface NDIntroView () <UIScrollViewDelegate,NextClickDelegate,NDPageBDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIScrollView *parallaxBackgroundScrollView;

@property (strong, nonatomic) NSMutableArray<UIView *> *pageViews;
@property (strong, nonatomic) NSArray <NSDictionary*> *onboardContentArray;

@property BOOL showPageControl;
@property int pages;

@end

@implementation NDIntroView

- (id)initWithFrame:(CGRect)frame parallaxImage:(UIImage *)parallaxImage andData:(NSArray *)data withNumPages:(int)pages showPageControl:(BOOL)show {
    self = [super initWithFrame:frame];
    if(self) {
        self.pages = pages;
        self.onboardContentArray = data;
        self.showPageControl = show;
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, self.scrollView.frame.size.width * self.onboardContentArray.count, self.frame.size.height)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, self.scrollView.frame.size.width * pages, self.frame.size.height)];
        
        [imageView setImage:parallaxImage];
        imageView.contentMode = UIViewContentModeLeft;
        [self.parallaxBackgroundScrollView addSubview:imageView];
        
        [self addSubview:self.parallaxBackgroundScrollView];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        [self generateIntroPageViews];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    CGFloat backgroundScrollValue = 0.5f;//self.backgroundImage.size.width/self.onboardContentArray.count/self.frame.size.width;
    [self.parallaxBackgroundScrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x  * backgroundScrollValue, self.scrollView.contentOffset.y) animated:NO];
    NSLog(@"%ld",self.pageControl.currentPage);
    
    
    
}

- (void)generateIntroPageViews {
    
    int page = 0;
    
    NDPageA *pageView0 = [[[NSBundle mainBundle] loadNibNamed:@"NDPageA" owner:nil options:nil] lastObject];
    pageView0.frame = CGRectMake(self.frame.size.width *page, 0, self.frame.size.width, self.frame.size.height);
    pageView0.delegate = self;
    [self.scrollView addSubview:pageView0];
    page++;
    
    NDPageB *pageView1 = [[[NSBundle mainBundle] loadNibNamed:@"NDPageB" owner:nil options:nil] lastObject];
    pageView1.frame = CGRectMake(self.frame.size.width *page, 0, self.frame.size.width, self.frame.size.height);
    //pageView1.buttonNext.hidden = YES;
    pageView1.textfieldCode.hidden = YES;
    pageView1.delegate = self;
    [self.scrollView addSubview:pageView1];
    page++;
    
    NDPageC *pageView2 = [[[NSBundle mainBundle] loadNibNamed:@"NDPageC" owner:nil options:nil] lastObject];
    pageView2.frame = CGRectMake(self.frame.size.width *page, 0, self.frame.size.width, self.frame.size.height);
    pageView2.delegate = self;
    [self.scrollView addSubview:pageView2];
    page++;
    
    NDPageD *pageView3 = [[[NSBundle mainBundle] loadNibNamed:@"NDPageD" owner:nil options:nil] lastObject];
    pageView3.frame = CGRectMake(self.frame.size.width *page, 0, self.frame.size.width, self.frame.size.height);
    pageView3.delegate = self;
    [self.scrollView addSubview:pageView3];
    page++;
    
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
//        _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.onboardContentArray.count, self.scrollView.frame.size.height);
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.pages, self.scrollView.frame.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        
        int x = -10;
        int y = -10;
        int w = 0;
        int h = 0;
        if(self.showPageControl){
            x = 0;
            y = self.frame.size.height-80;
            w = self.frame.size.width;
            h = 10;
        }
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //_pageControl.numberOfPages = self.onboardContentArray.count;
        _pageControl.numberOfPages = self.pages;
    }
    return _pageControl;
}
-(void) updatePages:(int)num_pages{
    self.pages = num_pages;
    _pageControl.numberOfPages = num_pages;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * num_pages, self.scrollView.frame.size.height);
    
}

-(UIScrollView *)parallaxBackgroundScrollView {
    if (!_parallaxBackgroundScrollView) {
        _parallaxBackgroundScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _parallaxBackgroundScrollView.delegate = self;
        _parallaxBackgroundScrollView.pagingEnabled = YES;
        _parallaxBackgroundScrollView.userInteractionEnabled = NO;
        _parallaxBackgroundScrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        _parallaxBackgroundScrollView.showsHorizontalScrollIndicator = NO;
        [_parallaxBackgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return _parallaxBackgroundScrollView;
}

-(UIButton *)lastPageButton {
    if (!_lastPageButton) {
        _lastPageButton = [[UIButton alloc] initWithFrame:CGRectMake(20, self.frame.size.height-60, self.frame.size.width - 40, 40)];
        _lastPageButton.layer.cornerRadius = 5.f;
        _lastPageButton.tintColor = [UIColor whiteColor];
        _lastPageButton.backgroundColor = [UIColor colorWithRed:70.f/255.f green:130.f/255.f blue:180.f/255.f alpha:1.f];
        [_lastPageButton setTitle:@"Let's Go!" forState:UIControlStateNormal];
        [_lastPageButton.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:18.0]];
        [_lastPageButton addTarget:self.delegate action:@selector(launchAppButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastPageButton;
}

-(void)goToNextPage{
    [self changePage:(int)self.pageControl.currentPage+1];
}
-(void)goToPreviousPage{
    [self changePage:(int)self.pageControl.currentPage-1];
}
-(void)onClickValidateInput{
    [self updatePages:4];
    [self goToNextPage];
}

-(void)changePage:(int)num_page{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * num_page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
-(void)updateNumPages:(int)num_pages{
    [self updatePages:num_pages];
}

@end
