//
//  shAntiMeditationViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shAntiMeditationViewController.h"
#import <MediaPlayer/MPVolumeView.h>

@interface shAntiMeditationViewController ()

@end

@implementation shAntiMeditationViewController
@synthesize iv_mediaBar     = m_iv_mediaBar;

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
    
    // Add volume control slider
    MPVolumeView *volumeSlider = [[MPVolumeView alloc] initWithFrame:self.iv_mediaBar.bounds];
    [self.iv_mediaBar addSubview:volumeSlider];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
