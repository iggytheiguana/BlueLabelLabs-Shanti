//
//  Follow.m
//  Platform
//
//  Created by Jasjeet Gill on 3/21/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import "Follow.h"
#import "User.h"
#import "Attributes.h"

@implementation Follow
@dynamic followername;
@dynamic userid;
@dynamic followeruserid;
@dynamic username;
@dynamic followerimageurl;
@dynamic userimageurl;


#pragma mark - Static Methods
+ (BOOL) doesFollowExistFor:(NSNumber*)userid withFollowerID:(NSNumber *)followeruserid
{
    BOOL retVal = NO;
    ResourceContext* resourceContext = [ResourceContext instance];
    Follow* follow = (Follow*)[resourceContext resourceWithType:FOLLOW withValuesEqual:[NSArray arrayWithObjects:userid,followeruserid, nil] forAttributes:[NSArray arrayWithObjects:USERID,FOLLOWERUSERID, nil] sortBy:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:DATECREATED ascending:NO]]];
    
    if (follow == nil) {
        retVal = NO;
    }
    else {
        retVal = YES;
    }
    return retVal;
}

#pragma mark - Static Initializers
//creates a Follow object with the follower following the user
+ (Follow*)createFollowFor:(NSNumber *)userid withFollowerID:(NSNumber *)followeruserid {
    ResourceContext* resourceContext = [ResourceContext instance];
    Follow* retVal = (Follow*) [Resource createInstanceOfType:FOLLOW withResourceContext:resourceContext];
    
    //need to grab the relevant user objects
    User* follower = (User*)[resourceContext resourceWithType:USER withID:followeruserid];
    User* user = (User*)[resourceContext resourceWithType:USER withID:userid];
    
    if (follower != nil) {
        retVal.followername = follower.username;
        
        //increment the follower counter on the user
        user.numberoffollowers = [NSNumber numberWithInt:([user.numberoffollowers intValue] + 1)];
        
    }
    
    if (user != nil) {
        retVal.username = user.username;
    }
    
    retVal.userid = userid;
    retVal.followeruserid = followeruserid;
    return  retVal;
}


+ (void) unfollowFor:(NSNumber *)userid withFollowerID:(NSNumber *)followeruserid
{
    //we delete the follow object
    ResourceContext* resourceContext = [ResourceContext instance];
    Follow* follow = (Follow*)[resourceContext resourceWithType:FOLLOW withValuesEqual:[NSArray arrayWithObjects:userid,followeruserid, nil] forAttributes:[NSArray arrayWithObjects:USERID,FOLLOWERUSERID, nil] sortBy:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:DATECREATED ascending:NO]]];
    
    if (follow != nil) 
    {
        [resourceContext.managedObjectContext deleteObject:follow];
        
        //need to grab the relevant user object
        User* user = (User*)[resourceContext resourceWithType:USER withID:userid];
        
        //decrement the follower counter on the user
        user.numberoffollowers = [NSNumber numberWithInt:([user.numberoffollowers intValue] - 1)];
    }
    
}
@end
