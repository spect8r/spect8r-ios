#import "UILabel+dynamicSizeMe.h"

@implementation UILabel (dynamicSizeMe)

-(float)resizeToFit{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];

    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,9999);
    
    CGRect textRect = [[self text] boundingRectWithSize:maximumLabelSize
                                             options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName:[self font]}
                                             context:nil];
    
    return textRect.size.height + self.font.pointSize*0.5;
}

@end
