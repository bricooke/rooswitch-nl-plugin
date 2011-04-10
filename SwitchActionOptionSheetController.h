//
//  SwitchActionOptionSheetController.h
//  rooSwitchNLPlugin
//
//  Created by Brian Cooke on 3/13/07.
//  Copyright 2007 roobasoft, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SKOptionSheetController.h"


@interface SwitchActionOptionSheetController : SKOptionSheetController {
    IBOutlet NSPopUpButton *applications;
    IBOutlet NSPopUpButton *profiles;
}

- (IBAction)applicationChanged:(id)sender;
- (IBAction)profileChanged:(id)sender;


@end
