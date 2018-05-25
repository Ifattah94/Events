//
//  PersistenceHelper.m
//  Events
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "PersistenceHelper.h"
#import "Event.h"

#define SAVEFILE @"savedevents.plist"

@interface PersistenceHelper ()

@property (strong, nonatomic) NSArray *events;

@end

@implementation PersistenceHelper

+ (instancetype)shared {
    static PersistenceHelper *persistenceHelper;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        persistenceHelper = [[PersistenceHelper alloc] init];
    });
    return persistenceHelper;
}

-(NSString*)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *filename = SAVEFILE;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    return path;
}


- (NSArray *)getFavoriteEvents {
    NSArray <Event *> *events = [NSKeyedUnarchiver unarchiveObjectWithFile:[self documentsPath]];
    _events = events;
    if(!events)
        NSLog(@"failed to unarchive events");
    return _events;
}

- (BOOL)saveEvent:(Event *)event {
    
    if (_events) {
        NSMutableArray *mutableEvents = [NSMutableArray arrayWithArray:_events];
        [mutableEvents addObject:event];
        _events = mutableEvents;
    } else {
        _events = @[event];
        
    }
    
    BOOL archived = [NSKeyedArchiver archiveRootObject:_events toFile:[self documentsPath]];
    if (!archived) {
        NSLog(@"failed to archive");
    } else {
        NSLog(@"events saved to documents path: %@", [self documentsPath]);
    }
    return archived;
}




@end
