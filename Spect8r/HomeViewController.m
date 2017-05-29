//
//  Register1ViewController.m
//  Vouchify
//
//  Created by Kostya on 07.03.16.
//  Copyright © 2016 CherryPie Studio. All rights reserved.
//

#import "HomeViewController.h"
#import "SignInViewController.h"
#import "AppDelegate.h"
#import "UIButton+ButtonsTypes.h"
#import "NMBottomTabBarController.h"
#import "ShapeSelectView.h"
@interface HomeViewController ()
{
    float prevOffsetY;

}
@property (strong, nonatomic) NSArray<NSString *> *menus;
@property (strong, nonatomic) NSArray<NSString *> *icons;
@property (strong, nonatomic) NSArray<NSString *> *sicons;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menus = @[@"All events", @"Concerts", @"Festivals"];
    self.icons = @[@"ic_menu_allevents", @"ic_menu_concerts", @"ic_menu_festivals"];
    self.sicons = @[@"ic_menu_allevents_selected", @"ic_menu_concerts_selected", @"ic_menu_festivals_selected"];

    prevOffsetY = 0;
    self.imvBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, [self getViewHeight])];
//    [self.imvBack setImage:[UIImage imageNamed:@"home_back"]];
    UIView *overlay = [[UIView alloc] initWithFrame:self.view.bounds];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];
    [self.imvBack setImage:[UIImage imageNamed:@"homeback"]];
    [self.imvBack addSubview:overlay];
    [self.view addSubview:self.imvBack];
    
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, [self getViewHeight] - 50)];
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 0.1);
    [self.view addSubview:self.scrollView];

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
   
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 4, 68, 36)];
    [menuButton setImage:[UIImage imageNamed:@"ic_menu_selected"] forState:UIControlStateSelected];
    [menuButton setImage:[UIImage imageNamed:@"ic_menu"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(clickedMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // Create dropdown menu in code
    
    self.navBarMenu = [[MKDropdownMenu alloc] initWithFrame:CGRectMake(8, 8, 56, 28)];
    self.navBarMenu.dataSource = self;
    self.navBarMenu.delegate = self;
    UIImageView *menuview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [menuview setImage:[UIImage imageNamed:@"ic_menu_allevents"]];
    [menuview setContentMode:UIViewContentModeScaleAspectFit];
    [self.navBarMenu addSubview:menuview];
    // Make background light instead of dark when presenting the dropdown
//    self.navBarMenu.backgroundDimmingOpacity = -0.67;
    
    // Set custom disclosure indicator image
    UIImage *indicator = [UIImage imageNamed:@"indicator"];
    self.navBarMenu.disclosureIndicatorImage = indicator;
    
    // Add an arrow between the menu header and the dropdown
//    UIImageView *spacer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
    
    // Prevent the arrow image from stretching
//    spacer.contentMode = UIViewContentModeCenter;
    
//    self.navBarMenu.spacerView = spacer;
    
    // Offset the arrow to align with the disclosure indicator
    self.navBarMenu.spacerViewOffset = UIOffsetMake(self.navBarMenu.bounds.size.width/2 - indicator.size.width/2 - 8, 1);
    
    // Hide top row separator to blend with the arrow
    self.navBarMenu.dropdownShowsTopRowSeparator = NO;
    self.navBarMenu.selectedComponentBackgroundColor = UIColorFromRGBAndAlpha(0x000000, 0);
    self.navBarMenu.dropdownBackgroundColor = UIColorFromRGBAndAlpha(0x000000, 0.2f);
    self.navBarMenu.dropdownBouncesScroll = NO;
    
    self.navBarMenu.rowSeparatorColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.navBarMenu.rowTextAlignment = NSTextAlignmentCenter;
    
    // Round all corners (by default only bottom corners are rounded)
    self.navBarMenu.dropdownRoundedCorners = UIRectCornerAllCorners;
    
    // Let the dropdown take the whole width of the screen with 10pt insets
    self.navBarMenu.useFullScreenWidth = YES;
    self.navBarMenu.fullScreenInsetLeft = 5;
    self.navBarMenu.fullScreenInsetRight = self.width * 3/ 5;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:self.navBarMenu];
    self.navigationItem.leftBarButtonItem = left;
    
    // Add the dropdown menu to navigation bar
//    self.navigationItem.leftBarButtonItem = self.navBarMenu;
   
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.width, 3)];
    [line1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blue_line"]]];
    [self.view addSubview:line1];

    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(self.width * 0.1f, self.height * 0.1f, self.width * 0.8f, self.height *0.2f)];
    [blueView setBackgroundColor:UIColorFromRGB(0x28bedd)];
    [blueView.layer setCornerRadius:2];
    
    UIImageView *imvSearch = [[UIImageView alloc] initWithFrame:CGRectMake(blueView.bounds.size.width * 0.1f, blueView.bounds.size.height / 2 - 16, 32, 32)];
    [imvSearch setImage:[UIImage imageNamed:@"ic_search"]];
    [blueView addSubview:imvSearch];
    
    NSString *string1 = @"Your feed is empty! Click here to search for friends, venues, and artists to follow.";
    NSDictionary *fontAttributes1 = [[NSDictionary alloc] initWithObjectsAndKeys:MuseosansFont500(14), NSFontAttributeName, nil];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:string1 attributes:fontAttributes1];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(blueView.bounds.size.width * 0.25f, blueView.bounds.size.height / 2 - 30, blueView.bounds.size.width * 0.65f, 60)];
    [lbltitle setAttributedText:attributedString1];
    [lbltitle setTextColor: [UIColor whiteColor]];
    [lbltitle setNumberOfLines:3];
    [lbltitle setTextAlignment:NSTextAlignmentCenter];
    [blueView addSubview:lbltitle];
    
    [self.scrollView addSubview:blueView];

    [self resizeScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)resizeScrollView {
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;

}


#pragma mark - MKDropdownMenuDataSource

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {

    return 3;
}

#pragma mark - MKDropdownMenuDelegate

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
        return 44;
}

//- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu widthForComponent:(NSInteger)component {
//    return MAX(dropdownMenu.bounds.size.width/3, 125);
////    return 0; // use automatic width
//}

- (BOOL)dropdownMenu:(MKDropdownMenu *)dropdownMenu shouldUseFullRowWidthForComponent:(NSInteger)component {
    return YES;
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
//    return [[NSAttributedString alloc] initWithString:self.componentTitles[component]
//                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightLight],
//                                                        NSForegroundColorAttributeName: self.view.tintColor}];
    return nil;
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForSelectedComponent:(NSInteger)component {
//    return [[NSAttributedString alloc] initWithString:self.componentTitles[component]
//                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightRegular],
//                                                        NSForegroundColorAttributeName: self.view.tintColor}];
    return nil;
}

- (UIView *)dropdownMenu:(MKDropdownMenu *)dropdownMenu viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    ShapeSelectView *shapeSelectView = (ShapeSelectView *)view;
    if (shapeSelectView == nil || ![shapeSelectView isKindOfClass:[ShapeSelectView class]]) {
        shapeSelectView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShapeSelectView class]) owner:nil options:nil] firstObject];
    }
    shapeSelectView.icon = [UIImage imageNamed:self.icons[row]];
    shapeSelectView.selected_icon = [UIImage imageNamed:self.sicons[row]];
    [shapeSelectView.shapeView setImage:[UIImage imageNamed:self.icons[row]]];
    shapeSelectView.textLabel.text = self.menus[row];
//    shapeSelectView.selected = (shapeSelectView.shapeView.sidesCount == self.shapeView.sidesCount);
    return shapeSelectView;
}

- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForRow:(NSInteger)row forComponent:(NSInteger)component {
        return UIColorFromRGBAndAlpha(0x000000, 0.1);

}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    delay(0.15, ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
    });
}

#pragma mark -
#pragma mark - TextField Delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.txtVenueName) {
        
        [self.txtHeadliner becomeFirstResponder];
        
    }
    else if(textField == self.txtHeadliner) {
        
        [self.txtSupportingArtist becomeFirstResponder];
        
    }
    
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
    self.activeField.delegate = self;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self registNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self unregistNotification];
    [self.navBarMenu closeAllComponentsAnimated:NO];
}
-(void) registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void) unregistNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShown:(NSNotification*)notification
{
    float offsetY = 0;
    
    if (self.activeField == self.txtVenueName)
        offsetY = 20;
    else if (self.activeField == self.txtHeadliner)
        offsetY = 40;
    else if (self.activeField == self.txtSupportingArtist)
        offsetY = 60;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = self.view.frame;
        f.origin.y -= offsetY - prevOffsetY;//(offsetY + deltaY);
        prevOffsetY = offsetY;
        self.view.frame = f;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
        prevOffsetY = 0;
        
    }];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}
-(void)rel{
    //    [dropDown release];
    self.dropDown = nil;
}


- (void) clickedDropdownButton:(id)sender {
    
//    if (self.btnEventDate.selected == false) {
//        self.btnEventDate.selected = true;
//    } else {
//        self.btnEventDate.selected = false;
//    }
//    NSArray * arr = [[NSArray alloc] init];
//    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
//    NSArray * arrImage = [[NSArray alloc] init];
//    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
//    if(self.dropDown == nil) {
//        CGFloat f = 200;
//        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
//        self.dropDown.delegate = self;
//    }
//    else {
//        [self.dropDown hideDropDown:sender];
//        [self rel];
//        
//    }
    
}

@end
