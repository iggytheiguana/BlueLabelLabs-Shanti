//
//  shAntiMeditateViewController.m
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "shAntiMeditateViewController.h"
#import "shAntiMeditationViewController.h"
#include <stdlib.h>

@interface shAntiMeditateViewController ()

@end

@implementation shAntiMeditateViewController
@synthesize tbl_meditate    = m_tbl_meditate;
@synthesize deepBreathing   = m_deepBreathing;
@synthesize bobyScan        = m_bobyScan;
@synthesize groupMeditation = m_groupMeditation;

#pragma mark - Properties
- (void)setupArrays {
    self.deepBreathing = [NSArray arrayWithObjects:@"2 min", @"5 min", @"10 min", nil];
    self.bobyScan = [NSArray arrayWithObjects:@"2 min", @"5 min", @"10 min", nil];
    self.groupMeditation = [NSArray arrayWithObjects:@"30 min @ 3pm", @"30 min @ 4pm", @"30 min @ 5pm", nil];
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
    
    if (indexPath.section == 0) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    shAntiMeditationViewController *meditationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MeditationViewController"];
    [self.navigationController pushViewController:meditationViewController animated:YES];
}

@end
