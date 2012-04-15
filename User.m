//
//  User.m
//  Platform
//
//  Created by Bobby Gill on 10/7/11.
//  Copyright 2011 Blue Label Solutions LLC. All rights reserved.
//

#import "User.h"
#import <CoreData/CoreData.h>
#import "ResourceContext.h"
#import "DateTimeHelper.h"
#import "Feed.h"
#import "Attributes.h"
@implementation User

@dynamic displayname;

@dynamic thumbnailurl;
@dynamic imageurl;
@dynamic numberoffollowers;
@dynamic numberfollowing;
@dynamic firstname;
@dynamic lastname;
@dynamic username;
@dynamic numguidedcomplete;
@dynamic nummindfulnesscomplete;


- (id) initFromJSONDictionary:(NSDictionary *)jsonDictionary {
    ResourceContext* resourceContext = [ResourceContext instance];
    NSManagedObjectContext* appContext = resourceContext.managedObjectContext;
    NSEntityDescription* entity = [NSEntityDescription entityForName:USER inManagedObjectContext:appContext];
    return [super initFromJSONDictionary:jsonDictionary withEntityDescription:entity insertIntoResourceContext:resourceContext];
}

//returns the number of unexpired, unopened notifications for this user in the database
+ (int) unopenedNotificationsFor:(NSNumber*)objectid 
{
    ResourceContext* resourceContext = [ResourceContext instance];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:DATECREATED ascending:NO];
    NSArray* feedObjects = [resourceContext resourcesWithType:FEED withValueEqual:[objectid stringValue] forAttribute:USERID sortBy:[NSArray arrayWithObject:sortDescriptor]];
    
    
    int count = 0;
    //get the current date
    double date = [[NSDate date] timeIntervalSince1970];
    
    for (Feed* feed in feedObjects) 
    {
        if ([feed.dateexpires doubleValue] > date && [feed.hasopened boolValue] == NO) {
            //its unexpired and unopened
            count++;
        }
    }
    return count;
    
}
@end
