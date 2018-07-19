//
//  editingTaskViewController.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "editingTaskViewController.h"

static int MIN_LENGTH_OF_TITLE = 1;

@interface editingTaskViewController ()<UITextViewDelegate>

@end

@implementation editingTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.taskName.delegate = self;
    self.subtitle.delegate = self;
    self.additionalInfo.delegate = self;
    
    self.database = [[dataManager alloc] initWithDataFrom:self.dataFrom];
    
    if (self.recordToEdit) {
        
        self.taskName.text = self.recordToEdit.titleName;
        self.subtitle.text = self.recordToEdit.subtitleName;
        self.additionalInfo.text = self.recordToEdit.additonalonfo;
        
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)Save:(id)sender {
    
    if (self.taskName.text.length > MIN_LENGTH_OF_TITLE) {
        
        
        if (!self.recordToEdit) {
            extern int TaskCount;
            
            TaskItem* item = [[TaskItem alloc] initWithCustomId];
            item.titleName = self.taskName.text;
            item.subtitleName = self.subtitle.text;
            item.additonalonfo = self.additionalInfo.text;
            
            [self.database addItem:item];
        } else{
            
            //TaskItem* item = [[TaskItem alloc] init];
            
            TaskItem* item = self.recordToEdit;
            
            item.titleName = self.taskName.text;
            item.subtitleName = self.subtitle.text;
            item.additonalonfo = self.additionalInfo.text;
            
            
            [self.database updateItem:item];
        }
    }
    [self.delegate editingInfoWasFinished];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
