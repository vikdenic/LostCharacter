//The Core Data framework provides generalized and automated solutions to common tasks associated with object life-cycle and object graph management, including persistence.

#import "MasterViewController.h"
#import "AddViewController.h"
#import "CharacterTableViewCell.h"
#import "DetailViewController.h"

@interface MasterViewController() <UITableViewDataSource, UIAlertViewDelegate>

@property NSArray *allCharactersArray;
@property NSMutableArray *plistArray;

@property NSInteger indexPathRowToBeDeleted;

@end

@implementation MasterViewController

-(void)viewDidLoad
{
    self.allCharactersArray = [NSArray new];
    self.plistArray = [NSMutableArray new];
    [self load];

    if (self.allCharactersArray.count < 1)
    {
        [self loadPList];
    }
}

#pragma mark - Helpers

-(void)load
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Character"];

    self.allCharactersArray = [self.managedObjectContext executeFetchRequest:request error:nil];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    self.allCharactersArray = [self.managedObjectContext executeFetchRequest:request error:nil];

    [self.managedObjectContext save:nil];
    [self.tableView reloadData];
}

-(void)loadPList
{
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"lost" withExtension:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfURL:path];

    for (NSDictionary *dictionary in array) {
         NSManagedObject *character= [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];

        for (NSString *key in dictionary.allKeys) {
            [character setValue:[dictionary valueForKey:key] forKey:key];
        }
        [self.plistArray addObject:character];
    }
    self.allCharactersArray = [NSArray arrayWithArray:self.plistArray];
    [self.tableView reloadData];
}

#pragma mark - Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allCharactersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *character = [self.allCharactersArray objectAtIndex:indexPath.row];

    CharacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.actorCellLabel.text = [character valueForKey:@"actor"];
    cell.passengerCellLabel.text = [character valueForKey:@"passenger"];
    cell.hometownCellLabel.text = [character valueForKey:@"hometown"];
    cell.ageCellLabel.text = [NSString stringWithFormat:@"%@", [character valueForKey:@"age"]];
    cell.seatCellLabel.text = [character valueForKey:@"seat"];
    cell.professionCellLabel.text = [character valueForKey:@"profession"];

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.indexPathRowToBeDeleted = indexPath.row;

    UIAlertView *confirmDeleteAlertView = [[UIAlertView alloc]initWithTitle:@"Delete This Item?"
                                                                    message:@"Are you sure you want to delete this?"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Delete", nil];
    [confirmDeleteAlertView show];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"SMOKEMONSTER";
}

#pragma mark - Alert View

//allows alert view "Delete" button to remove task
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {

//        NSMutableArray *copiedMutableArray = [NSMutableArray arrayWithArray:self.allCharactersArray];

        //* Need to delete from ManagedObjectContext
        NSManagedObject *character = [self.allCharactersArray objectAtIndex:self.indexPathRowToBeDeleted];
        [self.managedObjectContext deleteObject:character];

        [self.managedObjectContext save:nil];
//        [copiedMutableArray removeObjectAtIndex:self.indexPathRowToBeDeleted];
//        self.allCharactersArray = copiedMutableArray;
//        [self.tableView reloadData];
        [self load];
//        NSLog(@"ALL CHARACTERS ARRAY IS %@",self.allCharactersArray);
    }
}

#pragma mark - Segues

-(IBAction)unwindSegue:(UIStoryboardSegue *)sender
{
    AddViewController *sourceVC = sender.sourceViewController;
    self.managedObjectContext = sourceVC.managedObjectContext;

    [self.managedObjectContext save:nil];
    [self load];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual: @"AddSegue"])
    {
        AddViewController *destinationVC = segue.destinationViewController;
        destinationVC.managedObjectContext = self.managedObjectContext;
    }
}

@end