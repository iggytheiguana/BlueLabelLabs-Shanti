//
//  MeditationInstance.h
//  shAnti
//
//  Created by Jasjeet Gill on 4/15/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import "Resource.h"

@interface MeditationInstance : Resource

@property (nonatomic,retain) NSNumber* datecompleted;
@property (nonatomic,retain) NSNumber* datescheduled;
@property (nonatomic,retain) NSNumber* meditationtypeid;
@property (nonatomic,retain) NSNumber* percentcompleted;
@property (nonatomic,retain) NSNumber* state;
@property (nonatomic,retain) NSNumber* userid;
@end
