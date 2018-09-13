//
//  FormView.m
//  yixun
//
//  Created by 王涛 on 2016/11/16.
//  Copyright © 2016年 again. All rights reserved.
//

#import "FormView.h"

@interface FormView ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView        *webView;
@end

@implementation FormView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadH5Page];
    }
    return self;
}

+ (void)showFormView {

    FormView *view = [self formView];
    [view show];
}

+(instancetype)formView {

    FormView *view = nil;
    if (!view) {
        view = [[FormView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return view;
}

- (void)loadH5Page {
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:self.bounds];
    backGroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    _urlString = @"http://10.0.110.253/web/form/button/h5?widget_id=56f7a1f14660760005b4674&resource_id=56f7a1f14660760005b46741";
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 64, CGRectGetWidth(self.bounds) - 40, CGRectGetHeight(backGroundView.bounds) - 100 - 64)];
    _webView.layer.cornerRadius = 10;
    _webView.clipsToBounds = YES;
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(CGRectGetWidth(self.bounds)/2 - 25, CGRectGetMaxY(_webView.frame), 50, 50);
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [backGroundView addSubview:_webView];
    [backGroundView addSubview:closeButton];
    [self addSubview:backGroundView];
}

- (void)show {

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)closeButtonTap{

    [self removeView];
}

- (void)removeView {

    [self removeFromSuperview];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {


}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {


}

@end
