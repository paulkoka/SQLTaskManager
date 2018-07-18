//
//  editingTaskViewController.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskItem.h"
#import "dataManager.h"

@protocol editingTaskViewControllerProtocol

-(void)editingInfoWasFinished;

@end

@interface editingTaskViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *subtitle;
@property (weak, nonatomic) IBOutlet UITextView *additionalInfo;
@property (nonatomic, assign) DataFrom dataFrom;


@property (nonatomic) TaskItem* recordToEdit;

@property(nonatomic, strong) dataManager* database;

@property (nonatomic, strong) id<editingTaskViewControllerProtocol> delegate;

- (IBAction)Save:(id)sender;

@end
