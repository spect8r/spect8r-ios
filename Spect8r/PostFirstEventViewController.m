//
//  Register1ViewController.m
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "PostFirstEventViewController.h"
#import "EditEventDetailViewController.h"
#import "AppDelegate.h"
#import "UIButton+ButtonsTypes.h"

@interface PostFirstEventViewController ()
{
    float prevOffsetY;

}
@end

@implementation PostFirstEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setHidden:true];
    
    int txth = self.height * 0.1f * 0.8f;
    prevOffsetY = 0;
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
    [self.imvBack setBackgroundColor:UIColorFromRGB(0x111111)];
    [self.imvBack addSubview:overlay];
    
    
    NSDictionary *fontAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(24), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:APPNAME attributes:fontAttributes];
    
    float spacing = 6.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [APPNAME length])];
    self.lblAppName = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.2f, 12, self.width * 0.6f, 30)];
    [self.lblAppName setAttributedText:attributedString];
    [self.lblAppName setTextColor: [UIColor whiteColor]];
    [self.lblAppName setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = self.lblAppName;
   
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.width, 3)];
    [line1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blue_line"]]];
    [self.view addSubview:line1];
    
    NSString *string1 = @"Post your first event";
    NSDictionary *fontAttributes1 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont500(18), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1 attributes:fontAttributes1];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f - 40, self.width * 0.8f, 30)];
    [lbltitle setAttributedText:attributedString1];
    [lbltitle setTextColor: [UIColor whiteColor]];
    [lbltitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lbltitle];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f, self.width * 0.8f, 2)];
    [line2 setBackgroundColor:UIColorFromRGB(0xAAAAAA)];
    [self.view addSubview:line2];
    
    NSString *string2 = @"Choose a photo from a concert or festival. Spect8r will search the image for details automatically";
    NSDictionary *fontAttributes2 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(12), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:string2 attributes:fontAttributes2];
    
    UILabel *lbltitle2 = [[UILabel alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f + 10, self.width * 0.8f, 50)];
    [lbltitle2 setAttributedText:attributedString2];
    [lbltitle2 setTextColor: [UIColor whiteColor]];
    [lbltitle2 setNumberOfLines:2];
    [lbltitle2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lbltitle2];
    
    self.imvPostEvent = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 - self.width * 0.3f, (self.height * 0.1f + 60 + self.height - self.navheight - self.navheight - self.statheight - txth - 20 - txth) / 2  - self.width * 0.3f, self.width * 0.6f, self.width * 0.6f)];
    [self.view addSubview:self.imvPostEvent];
    [self.imvPostEvent setImage:[UIImage imageNamed:@"eventphoto"]];
    
    NSString *string3 = @"tap here to select a photo from your event";
    NSDictionary *fontAttributes3 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:string3 attributes:fontAttributes3];
    UILabel *lblselect = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2 - self.width * 0.25f, (self.height * 0.1f + 60 + self.height - self.navheight - self.navheight - self.statheight - txth - 20 - txth) / 2, self.width * 0.5f, self.width * 0.3f)];
    [lblselect setAttributedText:attributedString3];
    [lblselect setTextColor: UIColorFromRGB(0x28bedd)];
    [lblselect setNumberOfLines:2];
    [lblselect setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lblselect];
    
    NSString *string4 = @"I don't have a photo";
    NSDictionary *fontAttributes4 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont(14), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:string4 attributes:fontAttributes4];
    UILabel *lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - self.navheight - self.navheight - self.statheight - txth - 20 - txth, self.width , txth)];
    [lbl4 setAttributedText:attributedString4];
    [lbl4 setTextColor: UIColorFromRGB(0xAAAAAA)];
    [lbl4 setNumberOfLines:1];
    [lbl4 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lbl4];
    
    
    self.btnNext = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height - self.navheight - self.navheight - self.statheight - txth - 20, self.width * 0.8f , txth)];
    [self.btnNext.titleLabel setFont:MuseosansFont500(18)];
    [self.btnNext setTitle:@"Next" forState:UIControlStateNormal];
    [self.btnNext setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.btnNext setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self.btnNext addTarget:self action:@selector(clickedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnNext];
    
    self.btnSkip = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - self.navheight - self.navheight - self.statheight, self.width , self.navheight)];
    [self.btnSkip addTarget:self action:@selector(clickedSkipButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSkip.titleLabel setFont:MuseosansFont500(18)];
    [self.btnSkip setTitle:@"Skip this setup" forState:UIControlStateNormal];
    [self.btnSkip setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [self.btnSkip setBackgroundColor:UIColorFromRGB(0x000000)];
    [self.view addSubview:self.btnSkip];
    

    
}
- (void) clickedNextButton:(id)sender {
    EditEventDetailViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditEventDetailViewController"];
    [self.navigationController pushViewController:newViewController animated:true];

}

- (void) clickedSkipButton:(id)sender {
    EditEventDetailViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditEventDetailViewController"];
    [self.navigationController pushViewController:newViewController animated:true];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clickedBackButton:(id)sender{
    [self.navigationController popViewControllerAnimated:true];
}

@end
