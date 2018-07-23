//
//  coreDataManager.m
//  anotherDBBasedtaskmngr
//
//  Created by Pavel Koka on 7/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

#import "coreDataManager.h"

static NSString* EntityName = @"KPITasksTable";

@implementation coreDataManager

 NSString* identifireS = @"identifire";
 NSString* statementS = @"statement";
 NSString* taskTitleS = @"taskTitle";
 NSString* taskSubtitleS = @"taskSubtitle";
 NSString* additionalInfoS = @"additionalInfo";

-(NSManagedObjectContext*) managedObjectContext{
    if (!_managedObjectContext) {
        _appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        _managedObjectContext = _appDelegate.persistentContainer.viewContext;
    }
    return _managedObjectContext;
}

-(void) addItem:(TaskItem*)item{
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:EntityName inManagedObjectContext:self.managedObjectContext];
    
    [managedObject setValue:[NSNumber numberWithInt: item.identifire] forKey:identifireS];
    [managedObject setValue:[NSNumber numberWithInt: item.state] forKey:statementS];
    [managedObject setValue:item.titleName forKey:taskTitleS];
    [managedObject setValue:item.subtitleName forKey:taskSubtitleS];
    [managedObject setValue:item.additonalonfo forKey:additionalInfoS];
    [_appDelegate saveContext];
}

- (void)deleteTaskWithID:(TaskItem *)item {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:EntityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(identifire = %d)", item.identifire];
    [fetchRequest setPredicate:predicate];
    
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *managedObject in items) {
        [self.managedObjectContext deleteObject:managedObject];
    }
    [_appDelegate saveContext];
}

- (void)editTask:(TaskItem *)item {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:EntityName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(identifire = %d)", item.identifire];
    [fetchRequest setPredicate:predicate];
    
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *managedObject in items) {
        [managedObject setValue:[NSNumber numberWithInt: item.identifire] forKey:identifireS];
        [managedObject setValue:[NSNumber numberWithInt:item.state] forKey:statementS];

        [managedObject setValue:item.titleName forKey:taskTitleS];
        [managedObject setValue:item.subtitleName forKey:taskSubtitleS];
        [managedObject setValue:item.additonalonfo forKey:additionalInfoS];
    }
    [_appDelegate saveContext];
}

- (NSMutableArray*)loadTasks {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:EntityName];
   return [self parseArray:[self.managedObjectContext executeFetchRequest:request error:nil]];
}

- (NSMutableArray*)parseArray:(NSArray*)array {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSManagedObject* object in array) {

        TaskItem* item = [[TaskItem alloc]
                          initWithUniqeId:[[object valueForKey:identifireS] intValue]
                          withState:[[object valueForKey:statementS] intValue]
                          title:[object valueForKey:taskTitleS]
                          subtitle:[object valueForKey:taskSubtitleS]
                          additionalInformation:[object valueForKey:additionalInfoS]];

        
        [tempArray addObject:item];
    }
    self.dataContainer = [NSMutableArray arrayWithArray:tempArray];
    
    return self.dataContainer;
}



@end
