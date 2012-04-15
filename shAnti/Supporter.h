//
//  Supporter.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Supporter : NSObject

@property (nonatomic,retain) NSNumber* supporteruserid;
@property (nonatomic,retain) NSNumber* userid;
@property (nonatomic,retain) NSString* userName;
@property (nonatomic,retain) NSString* supporterName;
@property (nonatomic,retain) NSString* supporterThumbnailURL;
@property (nonatomic,retain) NSString* userThumbnailURL;

@end
