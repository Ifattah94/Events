//
//  EventDetailViewController.m
//  Events
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import "EventDetailViewController.h"
#import "ImageCache.h"
#import "PersistenceHelper.h"
#import "Event.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;




@end

@implementation EventDetailViewController

- (instancetype)initWithEvent:(Event *)event {
    self = [super init];
    if(self) {
        _event = event;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    [self configureFavoriteButton];
    
}

-(void)configureViews {
    self.eventLabel.text = _event.eventName;
    self.groupLabel.text = _event.groupName;
    if(_event.eventDescription) {
    self.descriptionTextView.text = _event.eventDescription;
    } else {
        self.descriptionTextView.text = @"No description available";
    }
    self.rsvpLabel.text = [NSString stringWithFormat:@"RSVP Count: %ld", (long)_event.rsvpCount];
    self.dateLabel.text = _event.localDate;
    if(_event.highResLink) {
        self.imageView.image = [[ImageCache sharedManager] getImageForKey:_event.highResLink];
    } else {
        self.imageView.image =  [UIImage imageNamed:@"placeholder-image"];
    }
    
}
-(void)configureFavoriteButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Favorite" style:UIBarButtonItemStylePlain target:self action:@selector(addFavorite)];
}

-(void)addFavorite {
    [PersistenceHelper.shared saveEvent:self.event];
    
    
}



@end
