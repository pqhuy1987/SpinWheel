//
//  ANViewController.m
//  SpinWheel
//
//  Created by Alex Nichol on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
@import GoogleMobileAds;
#import "ANViewController.h"


#define ADID @"ca-app-pub-5722562744549789/4480008957"

@interface ANViewController () {
    UIImage *kindWheel;
    int wheelId;
    UIImageView *pointView;
}

@end

@interface ANViewController ()<GADInterstitialDelegate>

@property (nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self interstisal];
    
    [self performSelector:@selector(LoadInterstitialAds) withObject:self afterDelay:1.0];

    wheelId = 1;
    kindWheel = [UIImage imageNamed:@"fortune1.png"];
	// Do any additional setup after loading the view, typically from a nib.
    imageWheel = [[ANImageWheel alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width - 50, self.view.frame.size.width - 50)];
    [imageWheel setImage:kindWheel];
    [imageWheel startAnimating:self];
    [imageWheel setDrag:1];
    imageWheel.center = CGPointMake(self.view.frame.size.width/2, imageWheel.center.y + 40);
    [self.view addSubview:imageWheel];
    
    
    pointView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chaibia"]];
    pointView.frame = CGRectMake(0, 0, 100, 50);
    pointView.center = imageWheel.center;
    [self.view addSubview:pointView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(selectWheel)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"changeImg"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60.0, 60.0);
    button.center = CGPointMake(imageWheel.center.x, self.view.frame.size.height - 100);
    [self.view addSubview:button];
}

-  (void)selectWheel {
    if (wheelId <3) {
        wheelId++;
    }
    else {
        wheelId = 1;
    }
    
    if (wheelId == 3) {
        pointView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    
    [self interstisal];
    
    [self performSelector:@selector(LoadInterstitialAds) withObject:self afterDelay:1.0];
    
    kindWheel = [UIImage imageNamed:[NSString stringWithFormat:@"fortune%d",wheelId]];
    [imageWheel setImage:kindWheel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)interstisal{
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:ADID];
    
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    [self.interstitial loadRequest:request];
    
}

-(void)LoadInterstitialAds{
    
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}

@end
