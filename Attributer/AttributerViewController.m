//
//  AttributerViewController.m
//  Attributer
//
//  Created by Sameer Totey on 9/15/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "AttributerViewController.h"
#import "TextStatsViewController.h"

@interface AttributerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributerViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Analyze Text"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatsViewController class]]) {
            TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
            tsvc.textToAnalyze = self.body.textStorage;
        }
        
    }
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender
{
    [self.body.textStorage addAttribute: NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName: self.outlineButton.tintColor} range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    
}

- (IBAction)outlineBodySelection
{
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3,
                                           NSStrokeColorAttributeName: [UIColor blackColor]} range:self.body.selectedRange];
}

- (IBAction)unOutlineBodySelection
{
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged) name:UIContentSizeCategoryDidChangeNotification object:nil];

}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}


- (void) preferredFontsChanged
{
    [self usePreferredFonts];
}

- (void) usePreferredFonts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
@end
