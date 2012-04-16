//
//  shAntiProgressViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shAntiProgressViewController.h"
#import "Attributes.h"
#import "DateTimeHelper.h"
#import "Meditation.h"
#import "MeditationInstance.h"
#import "MeditationType.h"
#import "MeditationState.h"

@interface shAntiProgressViewController ()

@end

@implementation shAntiProgressViewController
@synthesize frc_meditationInstances = __frc_meditationInstances;
@synthesize tbl_progress            = m_tbl_progress;


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
    
    //add predicate to grab only completed meditations
    //NSString* stateAttributeNameStringValue = [NSString stringWithFormat:@"%@",STATE];
    
    //NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K=%d",stateAttributeNameStringValue, kCOMPLETED];
    
    //[fetchRequest setPredicate:predicate];
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

- (NSString *)getTextForMeditationType:(NSNumber *)type {
    NSString *retVal;
    
    if ([type intValue] == DEEPBREATHING) {
        retVal = @"deep breathing";
    }
    else if ([type intValue] == BODYSCAN) {
        retVal = @"body scan";
    }
    else if ([type intValue] == GROUP) {
        retVal = @"group";
    }
    else if ([type intValue] == MINDFULNESS) {
        retVal = @"mindfulness";
    }
    else {
        retVal = @"";
    }
    
    return retVal;
}

- (NSString *)getTextLabelStringForMeditationInstance:(NSNumber *)meditationInstanceID {
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = (MeditationInstance *)[resourceContext resourceWithType:MEDITATIONINSTANCE withID:meditationInstanceID];
    Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    NSString *textLabelString;
    
    if ([meditationInstance.state intValue] == kCOMPLETED) {
        textLabelString = [NSString stringWithFormat:@"Congrats! You completed a %@ %@ meditation.", meditation.displayname, [self getTextForMeditationType:meditation.type]];
    }
    else if ([meditationInstance.state intValue] == kINPROGRESS) {
        textLabelString = [NSString stringWithFormat:@"You completed only %d%% of a %@ %@ meditation.", (int)([meditationInstance.percentcompleted doubleValue]*100), meditation.displayname, [self getTextForMeditationType:meditation.type]];
    }
    else {
        textLabelString = meditation.displayname;
    }
    
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
    
    self.tbl_progress = nil;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    int retVal = [[self.frc_meditationInstances fetchedObjects]count];
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Progress";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = [[self.frc_meditationInstances fetchedObjects] objectAtIndex:indexPath.row];
    Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    /*if ([meditationInstance.state intValue] == kCOMPLETED) {
        cell.textLabel.text = [NSString stringWithFormat:@"Congrats! You completed a %@ meditation.", meditation.displayname];
    }
    else if ([meditationInstance.state intValue] == kINPROGRESS) {
        cell.textLabel.text = [NSString stringWithFormat:@"You've completed only %d\% of a %@ meditation.", [meditationInstance.percentcompleted doubleValue]*100, meditation.displayname];
    }
    else {
        cell.textLabel.text = meditation.displayname;
    }*/
    
    //cell.textLabel.text = meditation.displayname;
    cell.textLabel.text = [self getTextLabelStringForMeditationInstance:meditationInstance.objectid];
    
    NSDate *dateCompleted = [DateTimeHelper parseWebServiceDateDouble:meditationInstance.datecompleted];
    cell.detailTextLabel.text = [DateTimeHelper formatMediumDateWithTime:dateCompleted includeSeconds:NO];
    
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
    //ResourceContext *resourceContext = [ResourceContext instance];
    MeditationInstance *meditationInstance = [[self.frc_meditationInstances fetchedObjects] objectAtIndex:indexPath.row];
    //Meditation *meditation = (Meditation *)[resourceContext resourceWithType:MEDITATION withID:meditationInstance.meditationtypeid];
    
    NSString *textLabelString = [self getTextLabelStringForMeditationInstance:meditationInstance.objectid];
    
    /*if ([meditationInstance.state intValue] == kCOMPLETED) {
        textLabelString = [NSString stringWithFormat:@"Congrats! You completed a %@ meditation.", meditation.displayname];
    }
    else if ([meditationInstance.state intValue] == kINPROGRESS) {
        textLabelString = [NSString stringWithFormat:@"You've completed only %d\% of a %@ meditation.", [meditationInstance.percentcompleted doubleValue]*100, meditation.displayname];
    }
    else {
        textLabelString = meditation.displayname;
    }*/
    
    CGSize sizeTextLabel = [textLabelString 
                   sizeWithFont:[UIFont boldSystemFontOfSize:18] 
                   constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    
    NSDate *dateCompleted = [DateTimeHelper parseWebServiceDateDouble:meditationInstance.datecompleted];
    CGSize sizeDetailTextLabel = [[DateTimeHelper formatMediumDateWithTime:dateCompleted includeSeconds:NO] 
                            sizeWithFont:[UIFont systemFontOfSize:14] 
                            constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    
    return sizeTextLabel.height + sizeDetailTextLabel.height + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
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
    [self.tbl_progress reloadData];
}

@end
