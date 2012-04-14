//
//  shAntiMeditationViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shAntiMeditationViewController.h"

@interface shAntiMeditationViewController ()

@end

@implementation shAntiMeditationViewController
@synthesize iv_mediaBar     = m_iv_mediaBar;
@synthesize sld_volumeControl = m_sld_volumeControl;
@synthesize sld_volumeControl2 = m_sld_volumeControl2;
@synthesize btn_play        = m_btn_play;
@synthesize btn_pause       = m_btn_pause;
@synthesize btn_rewind      = m_btn_rewind;
@synthesize btn_favorite    = m_btn_favorite;
@synthesize btn_info        = m_btn_info;
@synthesize audioPlayer     = m_audioPlayer;
@synthesize audioPlayer2    = m_audioPlayer2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Add audio file to player
    // TODO: Load file based on tableview selection
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"med5"
                                         ofType:@"mp3"]];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } else {
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        
        // Hide the play button because we wil autoplay
        [self.btn_play setHidden:YES];
    }
    
    
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"medVoice"
                                         ofType:@"mp3"]];
    
    NSError *error2;
    self.audioPlayer2 = [[AVAudioPlayer alloc]initWithContentsOfURL:url2 error:&error2];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", [error2 localizedDescription]);
    } else {
        self.audioPlayer2.delegate = self;
        [self.audioPlayer2 prepareToPlay];
        
        // Hide the play button because we wil autoplay
        [self.btn_play setHidden:YES];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.iv_mediaBar = nil;
    self.sld_volumeControl = nil;
    self.sld_volumeControl2 = nil;
    self.audioPlayer = nil;
    self.audioPlayer2 = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self playAudio];
}

- (void)viewDidDisppear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self pauseAudio];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Audio Action Methods
-(void)playAudio
{
    // Hide the play button, and show the pause button
    [self.btn_play setHidden:YES];
    [self.btn_pause setHidden:NO];
    
    [self.audioPlayer play];
    [self.audioPlayer2 play];
}

-(void)pauseAudio
{
    // Hide the pause button, and show the play button
    [self.btn_pause setHidden:YES];
    [self.btn_play setHidden:NO];
    
    [self.audioPlayer pause];
    [self.audioPlayer2 pause];
}

-(void)stopAudio
{
    // Hide the pause button, and show the play button
    [self.btn_pause setHidden:YES];
    [self.btn_play setHidden:NO];
    
    [self.audioPlayer stop];
    [self.audioPlayer2 stop];
}


-(void)rewindAudio
{
    // Hide the play button, and show the pause button
    [self.btn_play setHidden:YES];
    [self.btn_pause setHidden:NO];
    
    [self.audioPlayer setCurrentTime:0.0];
    [self.audioPlayer2 setCurrentTime:0.0];
}

-(void)adjustVolume
{
    if (self.audioPlayer != nil)
    {
        self.audioPlayer.volume = self.sld_volumeControl.value;
    }
}

-(void)adjustVolume2
{
    if (self.audioPlayer2 != nil)
    {
        self.audioPlayer2.volume = self.sld_volumeControl2.value;
    }
}

-(void)onFavoriteButtonPressed
{
}

-(void)onInfoButtonPressed
{
}
     
     
#pragma mark - AVAudioPlayer Delegate Methods
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
}

@end
