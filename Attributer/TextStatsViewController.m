//
//  TextStatsViewController.m
//  Attributer
//
//  Created by Sameer Totey on 9/15/14.
//  Copyright (c) 2014 Sameer Totey. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)characterWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    unsigned long index = 0;
    
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location  + range.length;
        } else {
            index++;
        }
    }
    
    return characters;
}

- (void) updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%ld colorful characters", [[self characterWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%ld outlined characters", [[self characterWithAttribute:NSStrokeWidthAttributeName] length] ];
}

@end
