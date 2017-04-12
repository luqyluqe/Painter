//
//  PTScribbleThumbnailCell.m
//

#import "PTScribbleThumbnailCell.h"


@implementation PTScribbleThumbnailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
  {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
  }
  
  return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
  //[super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

+ (NSInteger) numberOfPlaceHolders
{
  return 3;
}


- (void) addThumbnailView:(UIView *)thumbnailView 
                  atIndex:(NSInteger)index
{
  
  if (index == 0)
  {
    for (UIView *view in self.contentView.subviews)
    {
      [view removeFromSuperview];
    }
  }
  
  if (index < [PTScribbleThumbnailCell numberOfPlaceHolders])
  {
    CGFloat x = index *90 + (index + 1) *12;
    CGFloat y = 10;
    CGFloat width = 90;
    CGFloat height = 130;
    
    thumbnailView.frame = CGRectMake(x, y, width, height);
    
    [self.contentView addSubview:thumbnailView];
  }
}

@end
