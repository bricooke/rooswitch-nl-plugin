//
//  SwitchActionOptionSheetController.m
//  rooSwitchNLPlugin
//
//  Created by Brian Cooke on 3/13/07.
//  Copyright 2007 roobasoft, LLC. All rights reserved.
//

#import "SwitchActionOptionSheetController.h"


@implementation SwitchActionOptionSheetController

- (void) awakeFromNib
{
    [profiles removeAllItems];
    [profiles setEnabled:NO];
    [applications removeAllItems];
    
    [applications addItemWithTitle:@"Choose..."];
    
    // set the popup of applications to switch to the files present in
    // their app support/rooSwitch dir
    NSString *dir = [NSHomeDirectory() stringByAppendingString:@"/Library/Application Support/rooSwitch"];
    NSArray *files = [[NSFileManager defaultManager] directoryContentsAtPath:dir];
    NSString *file = nil;
    NSEnumerator *enumerator = [files objectEnumerator];
    while ((file = [enumerator nextObject]))
    {
        if ([[file pathExtension] isEqualToString:@"rooSwitch"])
        {
            NSString *title = [[file lastPathComponent] stringByDeletingPathExtension];
            [applications addItemWithTitle:title];
            
            NSMenuItem *menuItem = [applications itemWithTitle:title];
            NSString *fullPath = [dir stringByAppendingPathComponent:file];
            [menuItem setRepresentedObject:[fullPath retain]];
            
            if ([[options valueForKey:@"application"] isEqualToString:fullPath])
            {
                [applications selectItemWithTitle:title];
                [self applicationChanged:self];
            }
            
            // [menuItem setImage:[[NSImage alloc] initByReferencingFile:]
        }
    }
}

- (IBAction)applicationChanged:(id)sender
{
    [options setValue:[[applications selectedItem] representedObject] forKey:@"application"];
    NSString *rooSwitchFile = [options valueForKey:@"application"];
    NSLog(@"Now we have %@", rooSwitchFile);
    
    [profiles removeAllItems];
    [profiles setEnabled:YES];
    
    // load up the profiles
    NSXMLDocument *xmlDoc = nil;
    NSError *err=nil;
    NSURL *furl = [NSURL fileURLWithPath:[rooSwitchFile stringByAppendingPathComponent:@"profiles.xml"]];
    if (!furl) 
    {
        return;
    }
    xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error:&err];
    
    if( xmlDoc == nil ) 
    {
        xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:NSXMLDocumentTidyXML error:&err];
    }
    
    NSArray *matches = [xmlDoc nodesForXPath:@".//object[@type=\"PROFILE\"]//attribute[@name=\"name\"]" error:&err];
    NSLog(@"Matches = %@ - err = %@", matches, err);
    
    NSEnumerator *enumerator = [matches objectEnumerator];
    NSXMLNode *profile = nil;
    while ((profile = [enumerator nextObject]))
    {
        [profiles addItemWithTitle:[profile stringValue]];
        if ([[options valueForKey:@"profile"] isEqualToString:[profile stringValue]])
            [profiles selectItemWithTitle:[profile stringValue]];
    }
}

- (IBAction)profileChanged:(id)sender
{
    [options setValue:[[profiles selectedItem] title] forKey:@"profile"];
}

@end
