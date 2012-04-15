//
//  ShantiUser.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShantiUser : NSObject

@property (nonatomic,retain) NSNumber   *objectid;
@property (nonatomic,retain) NSString   *firstname;
@property (nonatomic,retain) NSString   *lastname;
@property (nonatomic,retain) NSString   *fullname;
@property (nonatomic,retain) NSDate     *dateCreated;
@property (nonatomic,retain) NSNumber   *numGuidedCompleted;
@property (nonatomic,retain) NSNumber   *numMindfulnessCompleted;
@property (nonatomic,retain) NSString   *imageURL;
@property (nonatomic,retain) NSString   *thumbnailURL;

@end
