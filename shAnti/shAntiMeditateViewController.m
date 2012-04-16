//
//  shAntiMeditateViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shAntiMeditateViewController.h"
#import "shAntiMeditationViewController.h"
#import "shAntiMindfulnessViewController.h"
#import "shAntiFavoritesViewController.h"
#import "DateTimeHelper.h"
#import "Meditation.h"
#import "MeditationInstance.h"
#import "MeditationType.h"
#import "MeditationState.h"

@interface shAntiMeditateViewController ()

@end

@implementation shAntiMeditateViewController
@synthesize sgmt_segmentedControl   = m_sgmt_segmentedControl;
@synthesize tbl_meditate    = m_tbl_meditate;
@synthesize deepBreathing   = m_deepBreathing;
@synthesize bobyScan        = m_bobyScan;
@synthesize groupMeditation = m_groupMeditation;

#pragma mark - Properties
- (void)setupArrays {
    /*self.deepBreathing = [NSArray arrayWithObjects:@"2 min", @"5 min", @"10 min", nil];
    self.bobyScan = [NSArray arrayWithObjects:@"2 min", @"5 min", @"10 min", nil];
    self.groupMeditation = [[NSMutableArray alloc]init];
    
    //@"30 min @ 4pm", @"30 min @ 5pm", nil];
    
    NSDate *currentDate = [NSDate date];
    
    for (int i = 1; i <= 3; i++) {
        NSTimeInterval interval = 60 * 60 * i;
        NSDate *nextDate = [currentDate dateByAddingTimeInterval:interval];
        int nextHour = [DateTimeHelper getHourComponentFromDate:nextDate];
        NSString* nextHourPeriod = [DateTimeHelper getPeriodComponentFromDate:nextDate];
        [self.groupMeditation addObject:[NSString stringWithFormat:@"30 min @ %d:00%@", nextHour, nextHourPeriod]];
    }*/
    
    self.deepBreathing = [Meditation loadDefaultMeditationsOfType:[NSNumber numberWithInt:DEEPBREATHING]];
    self.bobyScan = [Meditation loadDefaultMeditationsOfType:[NSNumber numberWithInt:BODYSCAN]];
    self.groupMeditation = [Meditation loadDefaultMeditationsOfType:[NSNumber numberWithInt:GROUP]];
    
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
    
    [self setupArrays];

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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.deepBreathing.count;
    }
    else if (section == 1) {
        return self.bobyScan.count;
    }
    else if (section == 2) {
        return self.groupMeditation.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    UITableViewCell *cell;
    
    /*if (indexPath.section == 0) {
        CellIdentifier = @"DeepBreathing";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [self.deepBreathing objectAtIndex:indexPath.row];
        int numLikes = arc4random() % 10;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d likes", numLikes];
    }
    else if (indexPath.section == 1) {
        CellIdentifier = @"BodyScan";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [self.bobyScan objectAtIndex:indexPath.row];
        int numLikes = arc4random() % 10;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d likes", numLikes];
    }
    else {
        CellIdentifier = @"GroupMeditation";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [self.groupMeditation objectAtIndex:indexPath.row];
        int numPeople = arc4random() % 10;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d ppl", numPeople];
    }*/
    
    
    if (indexPath.section == 0) {
        CellIdentifier = @"DeepBreathing";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        Meditation *meditation = [self.deepBreathing objectAtIndex:indexPath.row];
        
        cell.textLabel.text = meditation.displayname;
        cell.detailTextLabel.text = [meditation.numlikes stringValue];
    }
    else if (indexPath.section == 1) {
        CellIdentifier = @"BodyScan";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        Meditation *meditation = [self.bobyScan objectAtIndex:indexPath.row];
        
        cell.textLabel.text = meditation.displayname;
        cell.detailTextLabel.text = [meditation.numlikes stringValue];
    }
    else {
        CellIdentifier = @"GroupMeditation";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        Meditation *meditation = [self.groupMeditation objectAtIndex:indexPath.row];
        
        cell.textLabel.text = meditation.displayname;
        cell.detailTextLabel.text = [meditation.numpeople stringValue];
    }
    
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

#pragma mark - Segmented Control management
- (IBAction)indexDidChangeForSegmentedControl:(UISegmentedControl*)segmentedControl {
    NSUInteger index = segmentedControl.selectedSegmentIndex;
    
    if (index == 1) {
        shAntiMindfulnessViewController *mindfulnessViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MindfulnessViewController"];
        NSArray * theViewControllers = [NSArray arrayWithObject:mindfulnessViewController];
        [self.navigationController setViewControllers:theViewControllers animated:NO];
    }
    else if (index == 2) {
        shAntiFavoritesViewController *favoritesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoritesViewController"];
        NSArray * theViewControllers = [NSArray arrayWithObject:favoritesViewController];
        [self.navigationController setViewControllers:theViewControllers animated:NO];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        Meditation *meditation = [self.deepBreathing objectAtIndex:indexPath.row];
        
        // Create a new meditation instance
        MeditationInstance* meditationInstance = [MeditationInstance createInstanceOfMeditation:meditation.objectid forUserID:nil withState:[NSNumber numberWithInt:kINPROGRESS] withScheduledDate:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceNow]]];
        
        // Save new meditation instance
        ResourceContext* resourceContext = [ResourceContext instance];
        [resourceContext save:NO onFinishCallback:nil trackProgressWith:nil];
        
        shAntiMeditationViewController *meditationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MeditationViewController"];
        [meditationViewController setTitle:@"Deep Breathing"];
        //[meditationViewController setDuration:[meditation.duration intValue]];
        [meditationViewController setDuration:10];
        [self.navigationController pushViewController:meditationViewController animated:YES];
    }
    else if (indexPath.section == 1) {
        Meditation *meditation = [self.bobyScan objectAtIndex:indexPath.row];
        
        // Create a new meditation instance
        MeditationInstance* meditationInstance = [MeditationInstance createInstanceOfMeditation:meditation.objectid forUserID:nil withState:[NSNumber numberWithInt:kINPROGRESS] withScheduledDate:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceNow]]];
        
        // Save new meditation instance
        ResourceContext* resourceContext = [ResourceContext instance];
        [resourceContext save:NO onFinishCallback:nil trackProgressWith:nil];
        
        shAntiMeditationViewController *meditationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MeditationViewController"];
        [meditationViewController setTitle:@"Boby Scan"];
        [meditationViewController setDuration:[meditation.duration intValue]];
        [self.navigationController pushViewController:meditationViewController animated:YES];
    }
    else {
        // Create the scheduled date of the meditation
        NSDateComponents *time = [[NSCalendar currentCalendar]
                                  components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit
                                  fromDate:[NSDate date]];
        NSInteger hour = [time hour];
        [time setHour:(hour + indexPath.row + 1)];
        NSDate *startDate = [[NSCalendar currentCalendar] dateFromComponents:time];
        
        // Create a new meditation instance
        Meditation *meditation = [self.groupMeditation objectAtIndex:indexPath.row];
        MeditationInstance* meditationInstance = [MeditationInstance createInstanceOfMeditation:meditation.objectid forUserID:nil withState:[NSNumber numberWithInt:kSCHEDULED] withScheduledDate:[NSNumber numberWithDouble:[startDate timeIntervalSinceNow]]];
        
        // Save new meditation instance
        ResourceContext* resourceContext = [ResourceContext instance];
        [resourceContext save:NO onFinishCallback:nil trackProgressWith:nil];
        
        // Create calendar event
        EKEventStore *eventStore = [[[EKEventStore alloc] init] autorelease];
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        event.title = @"shAnti Group Meditation";
        event.location = @"shAnti for iPhone";
        
        event.startDate = startDate;
        event.endDate = [[NSDate alloc] initWithTimeInterval:[meditation.duration intValue] sinceDate:event.startDate];
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:(-15 * 60)]];
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        
        // Launch Event View Controller for editing and saving event
        EKEventEditViewController *eventViewController = [[EKEventEditViewController alloc] init];
        eventViewController.eventStore = eventStore;
        eventViewController.event = event;
        eventViewController.editViewDelegate = self;
        [self presentModalViewController:eventViewController animated:YES];
        [eventViewController release];
    }
}

#pragma mark - EventKitUI delegate
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action {
    [self dismissModalViewControllerAnimated:YES];
}

@end
