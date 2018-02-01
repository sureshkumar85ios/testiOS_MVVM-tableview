//
//  asyncImageView.m
//  Suresh_CodeTest
//
//  Created by Suresh on 31/01/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import "asyncImageView.h"

@interface asyncImageView()

@property (nonatomic, readwrite, copy) NSString *url;

//Activity indicator to be shown while image is downloaded
 
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *activityIndicator;

- (void)initializeControl;

@end

@implementation asyncImageView

@synthesize url = url_;
@synthesize activityIndicator = activityIndicator_;

- (void)initializeControl {
    
    if (self) {
        
        activityIndicator_ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator_ setHidesWhenStopped:YES];
        [activityIndicator_ setCenter:CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]))];
        [activityIndicator_ setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
        [self addSubview:activityIndicator_];
    }
}

- (id)init {
    
    if (self = [super init]) {
        
        [self initializeControl];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initializeControl];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initializeControl];
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image {
    
    if (self = [super initWithImage:image]) {
        
        [self initializeControl];
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        
        [self initializeControl];
    }
    
    return self;
}

#pragma mark - IMAGE download

//Downloads and displays the image from the given URL.

- (void)displayImageFromURL:(NSString *)url
          completionHandler:(void(^)(NSError *error))completionBlock {
    
    if ([url length] > 0 && ![url_ isEqualToString:url]) {
        
        [self setImage:nil];
        url_ = [url copy];
        [activityIndicator_ startAnimating];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *error = nil;
                [activityIndicator_ stopAnimating];
                
                if (image != nil) {
                    
                    [self setImage:image];
                    
                } else {
                    
                    error = [NSError errorWithDomain:@"Error!"
                                                code:-1
                                            userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Cannot download image from '%@'", url_] }];
                }
                
                completionBlock(error);
            });
        });
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
