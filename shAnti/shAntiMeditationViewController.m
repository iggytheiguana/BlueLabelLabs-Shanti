//
//  shAntiMeditationViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shAntiMeditationViewController.h"
#import "MeditationState.h"
#import "MeditationInstance.h"
#import "DateTimeHelper.h"


@interface shAntiMeditationViewController ()

@end

@implementation shAntiMeditationViewController
@synthesize iv_mediaBar             = m_iv_mediaBar;
@synthesize sld_volumeControl       = m_sld_volumeControl;
@synthesize sld_volumeControl2      = m_sld_volumeControl2;
@synthesize btn_play                = m_btn_play;
@synthesize btn_pause               = m_btn_pause;
@synthesize btn_rewind              = m_btn_rewind;
@synthesize btn_favorite            = m_btn_favorite;
@synthesize btn_info                = m_btn_info;
@synthesize btn_music               = m_btn_music;
@synthesize btn_voice               = m_btn_voice;
@synthesize lbl_timeRemaining       = m_lbl_timeRemaining;
@synthesize meditationInstanceID    = m_meditationInstanceID;
@synthesize duration                = m_duration;
@synthesize playbackTimer           = m_playbackTimer;
@synthesize pauseStartDate          = m_pauseStartDate;
@synthesize previousFiringDate      = m_previousFiringDate;
@synthesize audioPlayerMusic        = m_audioPlayerMusic;
@synthesize audioPlayerVoice        = m_audioPlayerVoice;


#pragma mark - Initialization
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
    self.lbl_timeRemaining = nil;
    
    self.audioPlayerMusic = nil;
    self.audioPlayerVoice = nil;
    
    [self.playbackTimer invalidate];
    self.playbackTimer = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Setup a timer to track playtime and limit it to the duration specified by the meditation object
    self.playbackTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(managePlayBackDuration)
                                                            userInfo:nil
                                                             repeats:YES];
    
    [self playAudio];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Determine if the meditaiton has completed fully
    NSTimeInterval timeLeft = self.duration - self.audioPlayerMusic.currentTime;
    if (timeLeft > 0.5) {
        [self meditationDidFinishWithState:[NSNumber numberWithInt:kINPROGRESS]];
    }
    
    [self stopAudio];
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
    
    // Start/Resume the playback timer
    float pauseTime = -1*[self.pauseStartDate timeIntervalSinceNow];
    [self.playbackTimer setFireDate:[self.previousFiringDate initWithTimeInterval:pauseTime sinceDate:self.previousFiringDate]];
}

-(void)pauseAudio
{
    // Hide the pause button, and show the play button
    [self.btn_pause setHidden:YES];
    [self.btn_play setHidden:NO];
    
    [self.audioPlayerMusic pause];
    [self.audioPlayerVoice pause];
    
    // Pause the playback timer
    self.pauseStartDate = [[NSDate dateWithTimeIntervalSinceNow:0] retain];
    self.previousFiringDate = [self.playbackTimer fireDate];
    [self.playbackTimer setFireDate:[NSDate distantFuture]];
}

-(void)stopAudio
{
    [self.audioPlayerMusic stop];
    [self.audioPlayerVoice stop];
    
    // Stop the playback timer
    self.pauseStartDate = [[NSDate dateWithTimeIntervalSinceNow:0] retain];
    self.previousFiringDate = [self.playbackTimer fireDate];
    [self.playbackTimer setFireDate:[NSDate distantFuture]];
    
    // Hide the pause button, and show the play button
    [self.btn_pause setHidden:YES];
    [self.btn_play setHidden:NO];
    
    // reset the timer labels to their defaults
    int minutesLeft = floor(self.duration/60);
    int secondsLeft = trunc(self.duration - minutesLeft * 60);
    int minutesDuration = floor(self.duration/60);
    int secondsDuration = trunc(self.duration - minutesDuration * 60);
    self.lbl_timeRemaining.text = [NSString stringWithFormat:@"%d:%02d / %d:%02d", minutesLeft, secondsLeft, minutesDuration, secondsDuration];
    
    // Get players ready for playing again
    [self.audioPlayerMusic setCurrentTime:0];
    [self.audioPlayerVoice setCurrentTime:0];
    [self.audioPlayerMusic prepareToPlay];
    [self.audioPlayerVoice prepareToPlay];
    self.audioPlayerMusic.volume = 0.43;
    self.sld_volumeControl.value = 0.43;
    self.audioPlayerVoice.volume = 0.43;
    self.sld_volumeControl2.value = 0.43;
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
    [self.btn_favorite setSelected:!self.btn_favorite.selected];
    
}

-(void)onInfoButtonPressed
{
}


#pragma mark - AVAudioPlayer Playback Duration Managment
- (void)meditationDidFinishWithState:(NSNumber *)state {
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = (MeditationInstance *)[resourceContext resourceWithType:MEDITATIONINSTANCE withID:self.meditationInstanceID];
    
    if ([state intValue] == kCOMPLETED) {
        // Meditation fisished its full specified duration
        // Update properties of meditation instance
        meditationInstance.state = state;
        meditationInstance.percentcompleted = [NSNumber numberWithDouble:1.00];
        meditationInstance.datecompleted = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    }
    else {
        // Meditation was stopped before full specified duration met
        // Update properties of meditation instance
        meditationInstance.state = state;
        
        NSTimeInterval timeLeft = self.duration - self.audioPlayerMusic.currentTime;
        double percentComplete = timeLeft / self.duration;
        meditationInstance.percentcompleted = [NSNumber numberWithDouble:percentComplete];
        
        meditationInstance.datecompleted = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    }
    
    [resourceContext save:NO onFinishCallback:nil trackProgressWith:nil];
}

- (void)managePlayBackDuration {
    NSTimeInterval timeLeft = self.duration - self.audioPlayerMusic.currentTime;
    
    int minutesLeft = floor(timeLeft/60);
    int secondsLeft = trunc(timeLeft - minutesLeft * 60);
    
    int minutesDuration = floor(self.duration/60);
    int secondsDuration = trunc(self.duration - minutesDuration * 60);
    
    // update your UI with time remaining
    self.lbl_timeRemaining.text = [NSString stringWithFormat:@"%d:%02d / %d:%02d", minutesLeft, secondsLeft, minutesDuration, secondsDuration];
    
    if (timeLeft < 0.5) {
        // Stop the meditation when the specified duration has been met
        [self stopAudio];
        [self meditationDidFinishWithState:[NSNumber numberWithInt:kCOMPLETED]];
    }
    else if (timeLeft < 7.5) {
        // Fade out the volume as we reach the specified duration
        self.audioPlayerVoice.volume = self.audioPlayerVoice.volume/2.0;
        self.audioPlayerMusic.volume = self.audioPlayerMusic.volume/2.0;
    }
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
