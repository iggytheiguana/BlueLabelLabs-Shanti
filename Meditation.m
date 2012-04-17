//
//  Meditation.m
//  shAnti
//
//  Created by Jasjeet Gill on 4/15/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import "Meditation.h"
#import "MeditationType.h"
#import "DateTimeHelper.h"

@implementation Meditation
@dynamic numlikes;
@dynamic numpeople;
@dynamic voiceurl;
@dynamic musicurl;
@dynamic displayname;
@dynamic duration;
@dynamic type; //this is an integer value pointing to a enumerated constant MeditationType (GROUP, MINDFULNESS, etc...)


#pragma mark - Static Initializers
//creates a Meditation object
+ (Meditation*)createMeditationOfType:(NSNumber *)type
                         withDuration:(NSNumber *)duration
                      withDisplayname:(NSString *)displayname
                         withMusicURL:(NSString *)musicURL
                         withVoiceURL:(NSString *)voiceURL
{
    ResourceContext* resourceContext = [ResourceContext instance];
    Meditation* retVal = (Meditation*) [Resource createInstanceOfType:MEDITATION withResourceContext:resourceContext];
    
    retVal.type = type;
    retVal.duration = duration;
    retVal.displayname = displayname;
    retVal.musicurl = musicURL;
    retVal.voiceurl = voiceURL;
    retVal.numpeople = [NSNumber numberWithInt:(arc4random() % 10)]; // this should be set to 0 once connected to cloud
    retVal.numlikes = [NSNumber numberWithInt:(arc4random() % 10)]; // this should be set to 0 once connected to cloud
    
    return  retVal;
}

//Loads the default meditations for table views
+ (NSArray*)loadDefaultMeditationsOfType:(NSNumber *)type
{
    NSMutableArray *retVal = [[[NSMutableArray alloc]init]autorelease];
    
    // Add audio file to player
    // TODO: Load file based on tableview selection
    NSString *musicURL = [[NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"med5"
                                         ofType:@"mp3"]] absoluteString];
    
    NSString *voiceURL = [[NSURL fileURLWithPath:[[NSBundle mainBundle]
                                          pathForResource:@"medVoice"
                                          ofType:@"mp3"]] absoluteString];
    
    NSArray *durationsArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:(2*60)], [NSNumber numberWithInt:(5*60)], [NSNumber numberWithInt:(10*60)], nil];
    NSArray *displaynamesArray = [NSArray arrayWithObjects:@"2 min", @"5 min", @"10 min", nil];
    
    if ([type intValue] == DEEPBREATHING || [type intValue] == BODYSCAN || [type intValue] == WALKING) {
        for (int i = 0; i < 3; i++) {
            Meditation *meditation = [Meditation createMeditationOfType:type withDuration:[durationsArray objectAtIndex:i] withDisplayname:[displaynamesArray objectAtIndex:i] withMusicURL:musicURL withVoiceURL:voiceURL];
            [retVal addObject:meditation];
        }
    }
    else if ([type intValue] == GROUP) {
        NSDate *currentDate = [NSDate date];
        
        for (int i = 1; i <= 3; i++) {
            NSTimeInterval interval = 60 * 60 * i;
            NSDate *nextDate = [currentDate dateByAddingTimeInterval:interval];
            int nextHour = [DateTimeHelper getHourComponentFromDate:nextDate];
            NSString* nextHourPeriod = [DateTimeHelper getPeriodComponentFromDate:nextDate];
            
            Meditation *meditation = [Meditation createMeditationOfType:type withDuration:[NSNumber numberWithInt:(30*60)] withDisplayname:[NSString stringWithFormat:@"30 min @ %d:00%@", nextHour, nextHourPeriod] withMusicURL:musicURL withVoiceURL:voiceURL];
                                      
            [retVal addObject:meditation];
        }
    }
    
    return  retVal;
}


@end