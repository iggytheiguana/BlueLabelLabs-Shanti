//
//  Meditation.h
//  shAnti
//
//  Created by Jasjeet Gill on 4/15/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import "Resource.h"

@interface Meditation : Resource

@property (nonatomic,retain) NSNumber* duration;
@property (nonatomic,retain) NSNumber* numlikes;
@property (nonatomic,retain) NSNumber* numpeople;
@property (nonatomic,retain) NSString* voiceurl;
@property (nonatomic,retain) NSString* musicurl;
@property (nonatomic,retain) NSString* displayname;
@property (nonatomic,retain) NSNumber* type;
@end
