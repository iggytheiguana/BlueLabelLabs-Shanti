//
//  Meditation.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meditation : NSObject

@property (nonatomic,retain) NSNumber   *objectid;
@property (nonatomic,retain) NSNumber   *creatorid;
@property (nonatomic,retain) NSString   *type;
@property (nonatomic,retain) NSString   *description;
@property (nonatomic,retain) NSDate     *dateCreated;
@property (nonatomic,retain) NSDate     *dateScheduled;
@property (nonatomic,retain) NSDate     *dateCompleted;
@property (nonatomic,retain) NSNumber   *duration;
@property (nonatomic,retain) NSNumber   *percentCompleted;
@property (nonatomic,retain) NSNumber   *isFavorite; //BOOL
@property (nonatomic,retain) NSNumber   *isScheduled; //BOOL
@property (nonatomic,retain) NSNumber   *isInProgress; //BOOL
@property (nonatomic,retain) NSNumber   *isCompleted; //BOOL
@property (nonatomic,retain) NSNumber   *numLikes;
@property (nonatomic,retain) NSNumber   *numPeople;
@property (nonatomic,retain) NSString   *musicURL;
@property (nonatomic,retain) NSString   *voiceURL;


@end
