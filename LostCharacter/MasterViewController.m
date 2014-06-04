//The Core Data framework provides generalized and automated solutions to common tasks associated with object life-cycle and object graph management, including persistence.

#import "MasterViewController.h"
#import "AddViewController.h"

@interface MasterViewController() <UITableViewDataSource>

@property NSArray *allCharactersArray;
@property NSMutableArray *plistArray;

@end

@implementation MasterViewController
-(void)viewDidLoad
{
    self.allCharactersArray = [NSArray new];
    self.plistArray = [NSMutableArray new];
    [self loadPList];
}

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

        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"actor"] forKey:@"actor"];
        [character1 setValue:[[array objectAtIndex:0]objectForKey:@"passenger"] forKey:@"passenger"];
        [self.plistArray addObject:character1];

        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"actor"] forKey:@"actor"];
        [character2 setValue:[[array objectAtIndex:1]objectForKey:@"passenger"] forKey:@"passenger"];
        [self.plistArray addObject:character2];

        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"actor"] forKey:@"actor"];
        [character3 setValue:[[array objectAtIndex:2]objectForKey:@"passenger"] forKey:@"passenger"];
        [self.plistArray addObject:character3];

        self.allCharactersArray = [NSArray arrayWithArray:self.plistArray];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allCharactersArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *character = [self.allCharactersArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [character valueForKey:@"actor"];
    cell.detailTextLabel.text = [character valueForKey:@"passenger"];

    return cell;
}

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