//
//  FavoriteRestaurantTableViewController.m
//  PitStop
//
//  Created by Hriday Kemburu on 9/2/14.
//  Copyright (c) 2014 Hriday Kemburu. All rights reserved.
//

#import "FavoriteRestaurantTableViewController.h"
#import "SWRevealViewController.h"
#import "Restaurant.h"

@interface FavoriteRestaurantTableViewController ()

@property NSMutableArray *foodPlaces;
@property NSArray *list;

@end

@implementation FavoriteRestaurantTableViewController

@synthesize sidebarButton = _sidebarButton;
@synthesize list = _list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //make navigation bar transparent
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    //sidebar button
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.foodPlaces = [[NSMutableArray alloc] init];
//    _list = @[@"Taco Bell", @"McDonald's", @"Subway", @"Chipotle", @"Pizza Hut"];
//    NSInteger *count = 1;
//    for (NSString *s in _list) {
//        
//    }
    //self.foodPlaces = [[NSMutableArray alloc] init];
    Restaurant *item1 = [[Restaurant alloc] init];
    item1.itemName = @"Taco Bell";
    [self.foodPlaces addObject:item1];
    Restaurant *item2 = [[Restaurant alloc] init];
    item2.itemName = @"McDonald's";
    [self.foodPlaces addObject:item2];
    Restaurant *item3 = [[Restaurant alloc] init];
    item3.itemName = @"Subway";
    [self.foodPlaces addObject:item3];
    Restaurant *item4 = [[Restaurant alloc] init];
    item4.itemName = @"Chipotle";
    [self.foodPlaces addObject:item4];
    Restaurant *item5 = [[Restaurant alloc] init];
    item5.itemName = @"KFC";
    [self.foodPlaces addObject:item5];
    Restaurant *item6 = [[Restaurant alloc] init];
    item6.itemName = @"Pizza Hut";
    [self.foodPlaces addObject:item6];
    Restaurant *item7 = [[Restaurant alloc] init];
    item7.itemName = @"Domino's Pizza";
    [self.foodPlaces addObject:item7];
    Restaurant *item8 = [[Restaurant alloc] init];
    item8.itemName = @"Panera Bread";
    [self.foodPlaces addObject:item8];
    Restaurant *item9 = [[Restaurant alloc] init];
    item9.itemName = @"Chick-Fil-A";
    [self.foodPlaces addObject:item9];
    Restaurant *item10 = [[Restaurant alloc] init];
    item10.itemName = @"Burger King";
    [self.foodPlaces addObject:item10];
    Restaurant *item11 = [[Restaurant alloc] init];
    item11.itemName = @"Wendy's";
    [self.foodPlaces addObject:item11];
    Restaurant *item12 = [[Restaurant alloc] init];
    item12.itemName = @"Starbucks";
    [self.foodPlaces addObject:item12];
    Restaurant *item13 = [[Restaurant alloc] init];
    item13.itemName = @"cable car cafe";
    [self.foodPlaces addObject:item13];
    PFUser *currentUser = [PFUser currentUser];
    NSArray *food = [currentUser objectForKey:@"restaurants"];
    for (Restaurant *r in self.foodPlaces) {
        NSString *f = r.itemName;
        for (NSString *s in food) {
            if ([s isEqualToString:f]) {
                r.liked = TRUE;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.foodPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Restaurant *restaurant = [self.foodPlaces objectAtIndex:indexPath.row];
    cell.textLabel.text = restaurant.itemName;
    if (restaurant.liked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Restaurant *tappedItem = [self.foodPlaces objectAtIndex:indexPath.row];
    tappedItem.liked = !tappedItem.liked;
    PFUser *currentUser = [PFUser currentUser];
    if (tappedItem.liked) {
        [currentUser addObject:tappedItem.itemName forKey:@"restaurants"];
    } else {
        [currentUser removeObject:tappedItem.itemName forKey:@"restaurants"];
    }
    [currentUser saveInBackground];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
