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
    
    AVAudioPlayer   *m_audioPlayer;
    AVAudioPlayer   *m_audioPlayer2;
    
}

@property (nonatomic, retain) IBOutlet UIImageView      *iv_mediaBar;
@property (nonatomic, retain) IBOutlet UISlider         *sld_volumeControl;
@property (nonatomic, retain) IBOutlet UISlider         *sld_volumeControl2;
@property (nonatomic, retain) IBOutlet UIButton         *btn_play;
@property (nonatomic, retain) IBOutlet UIButton         *btn_pause;
@property (nonatomic, retain) IBOutlet UIButton         *btn_rewind;
@property (nonatomic, retain) IBOutlet UIButton         *btn_favorite;
@property (nonatomic, retain) IBOutlet UIButton         *btn_info;

@property (nonatomic, retain) AVAudioPlayer             *audioPlayer;
@property (nonatomic, retain) AVAudioPlayer             *audioPlayer2;

-(IBAction) playAudio;
-(IBAction) pauseAudio;
-(IBAction) stopAudio;
-(IBAction) rewindAudio;
-(IBAction) onFavoriteButtonPressed;
-(IBAction) onInfoButtonPressed;
-(IBAction) adjustVolume;
-(IBAction) adjustVolume2;

@end
