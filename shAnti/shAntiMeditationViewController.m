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
@synthesize btn_music       = m_btn_music;
@synthesize btn_voice       = m_btn_voice;
@synthesize audioPlayerMusic     = m_audioPlayerMusic;
@synthesize audioPlayerVoice    = m_audioPlayerVoice;

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
    self.audioPlayerMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } else {
        self.audioPlayerMusic.delegate = self;
        [self.audioPlayerMusic prepareToPlay];
        
        // Hide the play button because we wil autoplay
        [self.btn_play setHidden:YES];
    }
    
    
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"medVoice"
                                         ofType:@"mp3"]];
    
    NSError *error2;
    self.audioPlayerVoice = [[AVAudioPlayer alloc]initWithContentsOfURL:url2 error:&error2];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", [error2 localizedDescription]);
    } else {
        self.audioPlayerVoice.delegate = self;
        [self.audioPlayerVoice prepareToPlay];
        
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
    self.btn_play = nil;
    self.btn_pause = nil;
    self.btn_rewind = nil;
    self.btn_favorite = nil;
    self.btn_info = nil;
    self.btn_music = nil;
    self.btn_voice = nil;
    
    self.audioPlayerMusic = nil;
    self.audioPlayerVoice = nil;
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
    
    [self.audioPlayerMusic play];
    [self.audioPlayerVoice play];
}

-(void)pauseAudio
{
    // Hide the pause button, and show the play button
    [self.btn_pause setHidden:YES];
    [self.btn_play setHidden:NO];
    
    [self.audioPlayerMusic pause];
    [self.audioPlayerVoice pause];
}

-(void)stopAudio
{
    // Hide the pause button, and show the play button
    [self.btn_pause setHidden:YES];
    [self.btn_play setHidden:NO];
    
    [self.audioPlayerMusic stop];
    [self.audioPlayerVoice stop];
}


-(void)rewindAudio
{
    // Hide the play button, and show the pause button
    [self.btn_play setHidden:YES];
    [self.btn_pause setHidden:NO];
    
    [self.audioPlayerMusic setCurrentTime:0.0];
    [self.audioPlayerVoice setCurrentTime:0.0];
}

-(void)adjustMusic
{
    if (self.audioPlayerMusic != nil)
    {
        self.audioPlayerMusic.volume = self.sld_volumeControl.value;
    }
}

-(void)adjustVoice
{
    if (self.audioPlayerVoice != nil)
    {
        self.audioPlayerVoice.volume = self.sld_volumeControl2.value;
    }
}

-(IBAction) muteMusic {
    if (self.sld_volumeControl.value == 0.00) {
        // Unmute
        [self.btn_music setSelected:YES];
        self.audioPlayerMusic.volume = 0.43;
        self.sld_volumeControl.value = 0.43;
    }
    else {
        // Mute
        [self.btn_music setSelected:NO];
        self.audioPlayerMusic.volume = 0.00;
        self.sld_volumeControl.value = 0.00;
    }
}

-(IBAction) muteVoice {
    if (self.sld_volumeControl2.value == 0.00) {
        // Unmute
        [self.btn_voice setSelected:YES];
        self.audioPlayerVoice.volume = 0.43;
        self.sld_volumeControl2.value = 0.43;
    }
    else {
        // Mute
        [self.btn_voice setSelected:NO];
        self.audioPlayerVoice.volume = 0.00;
        self.sld_volumeControl2.value = 0.00;
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
