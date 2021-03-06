//
//  LIstOfAllTasks.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "LIstOfAllTasks.h"
#import "TaskItem.h"


@interface LIstOfAllTasks ()

@end

@implementation LIstOfAllTasks

-(void)loadView{
    [super loadView];
    
    self.listOfTasks.dataSource = self;
    self.listOfTasks.delegate = self;
    self.database = [[dataManager alloc] initDefault];
    self.datacontainer = [NSMutableArray arrayWithArray:[self.database downloadDataFromBase]];
    
    [self.listOfTasks reloadData];
    
}

-(void) loadData{
    self.datacontainer = [self.database downloadDataFromBase];
    [self.listOfTasks reloadData];
    [self.listOfTasks reloadSections:[NSIndexSet indexSetWithIndex:0 ] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadView];
    self.listOfTasks.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datacontainer.count;
    
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* myIdentifire = @"taskInfoCell";
    
    UITableViewCell* cell = [self.listOfTasks dequeueReusableCellWithIdentifier:myIdentifire];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifire];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    

    TaskItem* temp = [self.datacontainer objectAtIndex:indexPath.row];

    
    cell.textLabel.text = temp.titleName;
    cell.detailTextLabel.text = temp.subtitleName;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    

    TaskItem* temp = [self.datacontainer objectAtIndex:indexPath.row];
    self.recordToEdit = temp;
    [self performSegueWithIdentifier:@"idEdit" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    editingTaskViewController *editInfoViewController = [segue destinationViewController];
    editInfoViewController.delegate = self;
    editInfoViewController.recordToEdit = self.recordToEdit;
    editInfoViewController.dataFrom = self.database.dataFrom;
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {

    UIContextualAction * delete =
    [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                            title:@"Delete"
                                          handler:^(UIContextualAction *  action,  UIView *  sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                                              TaskItem* task = (TaskItem*)[self.datacontainer objectAtIndex:indexPath.row];
                                              [self.database deliteItem:task];
                                              [self loadData];
                                              completionHandler(YES);
                                          }];
    UISwipeActionsConfiguration *swipe = [UISwipeActionsConfiguration configurationWithActions:@[delete]];
    return swipe;
}

-(void)editingInfoWasFinished{
    [self loadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




- (IBAction)addNewRecord:(id)sender {
    if (self.recordToEdit) {
        self.recordToEdit = nil;
    }
    
    [self performSegueWithIdentifier:@"idEdit" sender:self];
}
- (IBAction)DataFromSet:(id)sender {
    if (self.DataFromSetControl.selectedSegmentIndex == 0) {
        self.database.dataFrom = fromSqlDataBase;
        [self loadData];
    }
    
    else if (self.DataFromSetControl.selectedSegmentIndex == 1){
        self.database.dataFrom = fromCoreData;
        [self loadData];
    }
    
}
@end
