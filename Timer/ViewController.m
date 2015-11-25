//
//  ViewController.m
//  Timer
//
//  Created by engineering on 10/31/15.
//  Copyright (c) 2015 Dan Park. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDelegate> {
    NSTimeInterval interval;
    NSDate *timestampDate;
    NSDateFormatter *formatter;
    NSString *stringURL;
    
    NSURLSession *session;
}
@end

@implementation ViewController

void ErrorLog(int lineNumber, NSString *functionName, NSError *error) {
    if (error != noErr) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"Error[%@:%ld] ", error.domain, (long)error.code];
        if (error.localizedDescription != nil)
            [message appendFormat:@"%@", error.localizedDescription];
        
        if (error.localizedFailureReason != nil)
            [message appendFormat:@", %@", error.localizedFailureReason];
        
        if (error.userInfo[NSUnderlyingErrorKey] != nil)
            [message appendFormat:@", %@", error.userInfo[NSUnderlyingErrorKey]];
        
        if (error.localizedRecoverySuggestion != nil)
            [message appendFormat:@", %@", error.localizedRecoverySuggestion];

        [message appendFormat:@" - func(%@):line:%d\n", functionName, lineNumber];
//        NSLog(@"%@", message);
        NSLog(@"func(%@):line:%d: error:%ld", functionName, lineNumber, (long)error.code);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSession{
    if (! formatter) {
        formatter = [NSDateFormatter new];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    
    if (! session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *queue = [NSOperationQueue mainQueue];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    }
    
    interval = 1;
    timestampDate = [NSDate date];
    [self downloadTask:nil];
}

- (void)loginTask:(NSTimer*)atimer {
    NSString *request = [NSString stringWithFormat:@"login_submit?username=%@&password=%@&auth_service=local",@"superuser",@"mpact123"];
    NSString *encoded = [request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    stringURL = @"http://10.10.10.234:8888";
    NSString *feedURL = [[NSString alloc] initWithFormat:@"%@/%@/%@", stringURL, @"stats/dsr", encoded];

    NSURL *url = [NSURL URLWithString:feedURL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithRequest:req completionHandler:
    ^(NSURL *location, NSURLResponse *response, NSError *error) {
        [self logTimed];
        if (error) {
            ErrorLog(__LINE__, NSStringFromSelector(_cmd), error);
            
            interval *= 2;
            NSLog(@"double interval:%@", @(interval));
            
            NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(timed:) userInfo:nil repeats:NO];
            //    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        }
    }];
    
    timestampDate = [NSDate date];
    [downloadTask resume];
}

- (void)downloadTask:(NSTimer*)atimer {
//    stringURL = @"http://172.20.31.86/888";
//    stringURL = @"http://10.10.10.92/4321";
    stringURL = @"http://10.10.10.234:8888";
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithRequest:req completionHandler:
    ^(NSURL *location, NSURLResponse *response, NSError *error)
    {
        [self logTimed];
        if (error) {
            ErrorLog(__LINE__, NSStringFromSelector(_cmd), error);
            
            interval *= 2;
            NSLog(@"double interval:%@", @(interval));
            
            NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(timed:) userInfo:nil repeats:NO];
            //    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        }
    }];
    
    timestampDate = [NSDate date];
    [downloadTask resume];
}

- (void)logTimed{
    NSDate *date = [NSDate date];
    NSTimeInterval seconds = [date timeIntervalSinceDate:timestampDate];
    NSLog(@"seconds:%.1f", seconds);
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"error:%@", error);
}

@end
