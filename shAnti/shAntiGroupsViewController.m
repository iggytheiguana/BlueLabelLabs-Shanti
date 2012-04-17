//
//  shAntiGroupsViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/15/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import "shAntiGroupsViewController.h"
#import "Attributes.h"
#import "DateTimeHelper.h"
#import "Meditation.h"
#import "MeditationInstance.h"
#import "MeditationType.h"
#import "MeditationState.h"
#import "shAntiMeditationViewController.h"

@interface shAntiGroupsViewController ()

@end

@implementation shAntiGroupsViewController
@synthesize frc_meditationInstances = __frc_meditationInstances;
@synthesize tbl_groups              = m_tbl_groups;


#pragma mark - Properties
//this NSFetchedResultsController will query for all published pages
- (NSFetchedResultsController*) frc_meditationInstances {
    if (__frc_meditationInstances != nil) {
        return __frc_meditationInstances;
    }
    
    ResourceContext* resourceContext = [ResourceContext instance];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:MEDITATIONINSTANCE inManagedObjectContext:resourceContext.managedObjectContext];
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:DATECREATED ascending:NO];
    
    //add predicate to grab only group meditation instances
    //NSString* stateAttributeNameStringValue = [NSString stringWithFormat:@"%@", TYPE];
    //NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K=%d", stateAttributeNameStringValue, GROUP];
    
    //add predicate to grab only scheduled meditations
    NSString* stateAttributeNameStringValue = [NSString stringWithFormat:@"%@",STATE];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K=%d",stateAttributeNameStringValue, kSCHEDULED];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController* controller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:resourceContext.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    controller.delegate = self;
    self.frc_meditationInstances = controller;
    
    
    NSError* error = nil;
    [controller performFetch:&error];
  	if (error != nil)
    {
        //LOG_BOOKVIEWCONTROLLER(1, @"%@Could not create instance of NSFetchedResultsController due to %@",activityName,[error userInfo]);
    }
    
    [controller release];
    [fetchRequest release];
    [sortDescriptor release];
    return __frc_meditationInstances;
    
}

- (NSString *)getTextLabelStringForMeditationInstance:(NSNumber *)meditationInstanceID {
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = (MeditationInstance *)[resourceContext resourceWithType:MEDITATIONINSTANCE withID:meditationInstanceID];
    Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    NSDate *dateScheduled = [DateTimeHelper parseWebServiceDateDouble:meditationInstance.datecompleted];
    NSString *dateScheduledString = [DateTimeHelper formatMediumDate:dateScheduled];
    
    NSString *textLabelString = [NSString stringWithFormat:@"Group meditation scheduled for %@, %@.", dateScheduledString, meditation.displayname];
    
    return textLabelString;
}


#pragma mark - Initialization
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.tbl_groups = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Ensure Navigation bar is hidden
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.tbl_groups reloadData];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    __frc_meditationInstances = nil;
    self.frc_meditationInstances = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    int retVal = [[self.frc_meditationInstances fetchedObjects]count];
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Groups";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = [[self.frc_meditationInstances fetchedObjects] objectAtIndex:indexPath.row];
    Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    //cell.textLabel.text = meditation.displayname;
    cell.textLabel.text = [self getTextLabelStringForMeditationInstance:meditationInstance.objectid];
    
    //NSDate *dateCompleted = [DateTimeHelper parseWebServiceDateDouble:meditationInstance.datecompleted];
    //cell.detailTextLabel.text = [DateTimeHelper formatMediumDateWithTime:dateCompleted includeSeconds:NO];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ people attending", [meditation.numpeople stringValue]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = [[self.frc_meditationInstances fetchedObjects] objectAtIndex:indexPath.row];
    Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    NSString *textLabelString = [self getTextLabelStringForMeditationInstance:meditationInstance.objectid];
    
    CGSize sizeTextLabel = [textLabelString 
                            sizeWithFont:[UIFont boldSystemFontOfSize:18] 
                            constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    
    CGSize sizeDetailTextLabel = [[NSString stringWithFormat:@"%@ people attending", [meditation.numpeople stringValue]] 
                                  sizeWithFont:[UIFont systemFontOfSize:14] 
                                  constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    
    return sizeTextLabel.height + sizeDetailTextLabel.height + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = [[self.frc_meditationInstances fetchedObjects] objectAtIndex:indexPath.row];
    Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    NSDate *scheduledDate = [DateTimeHelper parseWebServiceDateDouble:meditationInstance.datescheduled];
    
    if ([scheduledDate compare:[NSDate date]] == NSOrderedDescending) {
        // scheduledDate is later than current date
        // Show alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"This group meditation hasn't begun yet. Please check back at the scheduled date and time." 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else {
        // scheduledDate is prior to or equal to the current date, start the meditation
        shAntiMeditationViewController *meditationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MeditationViewController"];
        [meditationViewController setTitle:@"Group Meditation"];
        meditationViewController.meditationInstanceID = meditationInstance.objectid;
        [meditationViewController setDuration:[meditation.duration intValue]];
        [self.navigationController pushViewController:meditationViewController animated:YES];
    }
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}



#pragma mark - NSFetchedResultsControllerDelegate methods
-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
}

- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
}


- (void) controller:(NSFetchedResultsController *)controller 
    didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath 
      forChangeType:(NSFetchedResultsChangeType)type 
       newIndexPath:(NSIndexPath *)newIndexPath
{
    
}


@end
