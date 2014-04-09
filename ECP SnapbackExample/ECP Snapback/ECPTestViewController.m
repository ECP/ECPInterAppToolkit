//
//  ECPTestViewController.m
//  ECP Snapback
//
//  Created by Steve Troppoli on 12/13/13.
//  Copyright (c) 2013 East Coast Pixels, Inc. All rights reserved.
//

#import "ECPTestViewController.h"
#import "ECP_EditAndReturnIACClient.h"

@interface ECPTestViewController ()
@property (weak) UIImageView* imageView;
@property (strong) ECP_EditAndReturnIACClient* eriClient;
@end

@implementation ECPTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
	self.imageView = iv;
	iv.image = [UIImage imageNamed:@"IMG_0811.JPG"];
	iv.center = self.view.center;
	iv.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:iv];

	UIButton* editImage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[editImage setTitle:@"edit pic" forState:UIControlStateNormal];
	[editImage addTarget:self action:@selector(doEditPic:) forControlEvents:UIControlEventTouchUpInside];
	[editImage sizeToFit];
	CGPoint tmpCenter = iv.center;
	tmpCenter.y = iv.frame.origin.y + iv.frame.size.height + editImage.frame.size.height;
	editImage.center = tmpCenter;
	[self.view addSubview:editImage];
	
}

-(IBAction)doEditPic:(id)sender
{
	if (!self.eriClient) {
		self.eriClient = [[ECP_EditAndReturnIACClient alloc] initWithURLScheme:@"phototoaster-x-callback"];
	}
	
	// Optionally pass a reviously returned preset to setup the inital settings for an edit session.
	//	NSString* prev = @"phototoasterpreset://?Technicolor=0&BGSaturation=1&BGBrightness=0&LensVignetteSize=0.5&Sharpen=1.5&VignetteSize=0&Intensity=0&TextureOpacity=0.75&BGTintColor=-1&Saturation=1.3&Tint=0&Border=2&VignetteSoftness=0.2&Contrast=0&Temp=0&AddLight=0.5&TintColor=-1&TextureSet=0&Texture=0&Soften=0&CrossProcess=0&BGBlur=12&Curves=0&BorderWidth=0.75&BorderSet=0&Dynamic=0&Exposure=0&Recovery=0&Blacks=0&Brightness=0.5";
	NSString* prev = nil;
	
	ECPTestViewController __weak* weakSelf = self;
	[self.eriClient returnEditedImage:self.imageView.image previousPreset:prev withCallback:^(UIImage *image, NSString *preset, NSError *error) {
		if(!weakSelf)	// do not let this block keep us alive. Just ignore an old response if the caller is gone.
			return;
		
		if(image){
			weakSelf.imageView.image = image;
		}
		if (error) {
			[[[UIAlertView alloc] initWithTitle:@"error !?!" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}];
}
@end
