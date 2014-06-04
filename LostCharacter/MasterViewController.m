//The Core Data framework provides generalized and automated solutions to common tasks associated with object life-cycle and object graph management, including persistence.

#import "MasterViewController.h"
#import "AddViewController.h"
#import "CharacterTableViewCell.h"
#import "DetailViewController.h"

@interface MasterViewController() <UITableViewDataSource, UIAlertViewDelegate>

@property NSArray *allCharactersArray;
@property NSMutableArray *plistArray;

@property (strong, nonatomic) NSManagedObject *selectedManagedObjectContext;

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
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"actor" ascending:YES];

    request.sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    [self.managedObjectContext save:nil];
    [self.tableView reloadData];
}

-(void)loadPList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];

        NSManagedObject *character1 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];

        NSManagedObject *character2 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];

        NSManagedObject *character3 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];

            NSManagedObject *character4 = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.managedObjectContext];

        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"actor"] forKey:@"actor"];
        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"passenger"] forKey:@"passenger"];
        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"age"] forKey:@"age"];
        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"hometown"] forKey:@"hometown"];
        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"profession"] forKey:@"profession"];
        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"seat"] forKey:@"seat"];

        [self.plistArray addObject:character1];

        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"actor"] forKey:@"actor"];
        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"passenger"] forKey:@"passenger"];
        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"age"] forKey:@"age"];
        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"hometown"] forKey:@"hometown"];
        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"profession"] forKey:@"profession"];
        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"seat"] forKey:@"seat"];
        [self.plistArray addObject:character2];

        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"actor"] forKey:@"actor"];
        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"passenger"] forKey:@"passenger"];
        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"age"] forKey:@"age"];
        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"hometown"] forKey:@"hometown"];
        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"profession"] forKey:@"profession"];
        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"seat"] forKey:@"seat"];
        [self.plistArray addObject:character3];

        [character4 setValue:[[array objectAtIndex:3]objectForKey:@"actor"] forKey:@"actor"];
        [character4 setValue:[[array objectAtIndex:3]objectForKey:@"passenger"] forKey:@"passenger"];
        [character4 setValue:[[array objectAtIndex:3]objectForKey:@"age"] forKey:@"age"];
        [character4 setValue:[[array objectAtIndex:3]objectForKey:@"hometown"] forKey:@"hometown"];
        [character4 setValue:[[array objectAtIndex:3]objectForKey:@"profession"] forKey:@"profession"];
        [character4 setValue:[[array objectAtIndex:3]objectForKey:@"seat"] forKey:@"seat"];
        [self.plistArray addObject:character4];

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

    self.selectedManagedObjectContext = character;

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

        NSMutableArray *copiedMutableArray = [NSMutableArray arrayWithArray:self.allCharactersArray];
        [copiedMutableArray removeObjectAtIndex:self.indexPathRowToBeDeleted];
        self.allCharactersArray = copiedMutableArray;

        [self.tableView reloadData];
        NSLog(@"ALL CHARACTERS ARRAY IS %@",self.allCharactersArray);
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