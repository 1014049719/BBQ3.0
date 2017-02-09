//
//  BBQMoviePlayerViewController.m
//  BBQ
//
//  Created by wenjing on 15/11/16.
//  Copyright © 2015年 bbq. All rights reserved.
//

#import "BBQMoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface BBQMoviePlayerViewController ()
{
    MPMoviePlayerController *mp; //播放控制器
    UIActivityIndicatorView *loadingAni;    //加载动画
    UILabel *label;                            //加载提醒
}


@end

@implementation BBQMoviePlayerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loadingAni = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 150, 37, 37)];
    loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:loadingAni];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(130, 190, 80, 40)];
    label.text = @"加载中...";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    
    [[self view] setBackgroundColor:[UIColor blackColor]];
    
    [loadingAni startAnimating];
    [self.view addSubview:label];
}


- (void) moviePlayerLoadStateChanged:(NSNotification*)notification
{
    [loadingAni stopAnimating];
    [label removeFromSuperview];
    if ([mp loadState] != MPMovieLoadStateUnknown)
    {
        [[NSNotificationCenter     defaultCenter] removeObserver:self
                                                            name:MPMoviePlayerLoadStateDidChangeNotification
                                                          object:nil];
        
        //设置mp的View的尺寸
        mp.view.frame = self.view.bounds;
        
        //设置视频播放的适配
        mp.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        //把movieContr的View 添加到当前视频控制器的View
        [self.view addSubview:mp.view];
        
        // Play the movie
        [mp play];
    }
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    //还原状态栏为默认状态
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    // Remove observer
    [[NSNotificationCenter     defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) readyPlayer
{
    mp =  [[MPMoviePlayerController alloc] initWithContentURL:_movieURL];
    
    if ([mp respondsToSelector:@selector(loadState)])
    {
        // Set movie player layout
        [mp setControlStyle:MPMovieControlStyleFullscreen];        //MPMovieControlStyleFullscreen        //MPMovieControlStyleEmbedded
        //满屏
        [mp setFullscreen:YES];
        // 有助于减少延迟
        [mp prepareToPlay];
        
        // Register that the load state changed (movie is ready)
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerLoadStateChanged:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:nil];
    }
    else
    {
        // Play the movie For 3.1.x devices
        [mp play];
    }
    
    // Register to receive a notification when the movie has finished playing.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

@end
