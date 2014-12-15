//
//  Notes.h
//  MyHealth
//
//  Created by Ashish Chhabra on 05/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"
#import "NoteDetails.h"
@interface Notes : JSONModel

@property (nonatomic, retain) NSMutableArray <NoteDetails> *arrayNotes;

@end
