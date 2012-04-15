//
//  shAntiMeditationViewController.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface shAntiMeditationViewController : UIViewController <AVAudioPlayerDelegate> {
    UIImageView     *m_iv_mediaBar;
    UISlider        *m_sld_volumeControl;
    UISlider        *m_sld_volumeControl2;
    UIButton        *m_btn_play;
    UIButton        *m_btn_pause;
    UIButton        *m_btn_rewind;
    UIButton        *m_btn_favorite;
    UIButton        *m_btn_info;
    UIButton        *m_btn_music;
    UIButton        *m_btn_voice;
    
    int             m_duration;
    
    AVAudioPlayer   *m_audioPlayerMusic;
    AVAudioPlayer   *m_audioPlayerVoice;
    
}

@property (nonatomic, retain) IBOutlet UIImageView      *iv_mediaBar;
@property (nonatomic, retain) IBOutlet UISlider         *sld_volumeControl;
@property (nonatomic, retain) IBOutlet UISlider         *sld_volumeControl2;
@property (nonatomic, retain) IBOutlet UIButton         *btn_play;
@property (nonatomic, retain) IBOutlet UIButton         *btn_pause;
@property (nonatomic, retain) IBOutlet UIButton         *btn_rewind;
@property (nonatomic, retain) IBOutlet UIButton         *btn_favorite;
@property (nonatomic, retain) IBOutlet UIButton         *btn_info;
@property (nonatomic, retain) IBOutlet UIButton         *btn_music;
@property (nonatomic, retain) IBOutlet UIButton         *btn_voice;

@property                              int              duration;

@property (nonatomic, retain) AVAudioPlayer             *audioPlayerMusic;
@property (nonatomic, retain) AVAudioPlayer             *audioPlayerVoice;

-(IBAction) playAudio;
-(IBAction) pauseAudio;
-(IBAction) stopAudio;
-(IBAction) rewindAudio;
-(IBAction) onFavoriteButtonPressed;
-(IBAction) onInfoButtonPressed;
-(IBAction) adjustMusic;
-(IBAction) adjustVoice;
-(IBAction) muteMusic;
-(IBAction) muteVoice;

@end
