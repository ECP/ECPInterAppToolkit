//
//  ECP_EditAndReturnIACClient.h
//  ECP Snapback
//
//  Created by Steve Troppoli on 12/13/13.
//  Copyright (c) 2013 East Coast Pixels, Inc. All rights reserved.
//

#import "IACClient.h"

@interface ECP_EditAndReturnIACClient : IACClient
- (void)returnEditedImage:(UIImage*)image previousPreset:(NSString*)preset withCallback:(void(^)(UIImage* image, NSString* preset, NSError *error))callback;
@end
