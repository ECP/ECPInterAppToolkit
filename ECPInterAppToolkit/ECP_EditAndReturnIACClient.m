//
//  ECP_EditAndReturnIACClient.m
//  ECP Snapback
//
//  Created by Steve Troppoli on 12/13/13.
//  Copyright (c) 2013 East Coast Pixels, Inc. All rights reserved.
//

#import "ECP_EditAndReturnIACClient.h"

@implementation ECP_EditAndReturnIACClient

- (void)returnEditedImage:(UIImage*)image previousPreset:(NSString*)preset withCallback:(void(^)(UIImage* image, NSString* preset, NSError *error))callback
{
    if (!callback) return;
    
	UIPasteboard* sysPB = [UIPasteboard generalPasteboard];
	UIPasteboard* tmpPB = nil;
	if ([sysPB.items count]) {	// if there's something on the cliboard, lets be nice and save and restore it.
		tmpPB = [UIPasteboard pasteboardWithName:@"returnEditedImageTmp" create:YES];
		[tmpPB setItems:sysPB.items];
	}
	[sysPB setImage:image];
	
    [self performAction:@"returnEditedClipboardImage"
             parameters:(preset ? @{@"preset":preset} : nil)
              onSuccess:^(NSDictionary *result) {
				  
				  callback(sysPB.image,result[@"preset"],nil);
				  if (tmpPB) {
					  [sysPB setItems:tmpPB.items];
					  [UIPasteboard removePasteboardWithName:tmpPB.name];
				  }
              }
              onFailure:^(NSError *error) {
                  callback(nil, nil, error);
				  if (tmpPB) {
					  [sysPB setItems:tmpPB.items];
					  [UIPasteboard removePasteboardWithName:tmpPB.name];
				  }
              }
     ];
	
}

@end
