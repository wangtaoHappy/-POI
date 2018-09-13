//
//  ViewController.m
//  高德地图搜索POI
//
//  Created by 王涛 on 2016/11/15.
//  Copyright © 2016年 王涛. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MapKit/MapKit.h>
#import "FormView.h"
@interface ViewController ()<UIWebViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI        *search;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//   APIkey: d82222fe9fa8d75dbb32fba6ddfc988d
//    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
//       
//        NSString *urlString = @"iosamap://poi?sourceApplication=applicationName&name=星巴克&lat1=30.65&lon1=104.05&lat2=30.8&lon2=104.1&dev=0";
//        NSString *urlStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//    }  else {
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    web.delegate = self;
//    NSString *string = @"http://m.amap.com/?k=星巴克&user_loc=30.65,104.05&adcode=510107";
//    NSString *urlStr = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//    [self.view addSubview:web];
//    }
    
    
   // [self getAroundData];
    [self openSelfMap];
    self.view.backgroundColor = [UIColor grayColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    [super touchesBegan:touches withEvent:event];
//    [FormView showFormView];
}

/**
 得到附近的目标数据
 */
- (void)getAroundData {
    [AMapServices sharedServices].apiKey =@"f2d78d9b7949a574410c42b038aa3727";
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:30.65 longitude:104.05];
    request.keywords            = @"星巴克";
    /* 按照距离排序. */
    request.sortrule            = 0;
    //范围
    request.radius              = 10000;
    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
}

/**
 调用系统苹果地图
 */
- (void)openSelfMap {
  
    //创建一个位置信息对象，第一个参数为经纬度，第二个为纬度检索范围，单位为米，第三个为经度检索范围，单位为米
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(30.65, 104.05), 10000, 10000);
    //初始化一个检索请求对象
    MKLocalSearchRequest *req = [[MKLocalSearchRequest alloc]init];
    //设置检索参数
    req.region = region;
    //兴趣点关键字
    req.naturalLanguageQuery = @"kk";
    //初始化检索
    MKLocalSearch *ser = [[MKLocalSearch alloc]initWithRequest:req];
    //开始检索，结果返回在block中
    [ser startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        //兴趣点节点数组
        NSArray *array = [NSArray arrayWithArray:response.mapItems];
        [MKMapItem openMapsWithItems:array launchOptions:nil];
    }];
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    for (int index = 0; index < response.pois.count; index ++) {
         NSLog(@"--%@,--%@",response.pois[index].name,response.pois[index].address);
    }
   
   
}

@end
