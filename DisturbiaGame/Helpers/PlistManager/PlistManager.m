#import "PlistManager.h"

@interface PlistManager ()

@property (nonatomic, strong) NSString *documentsPath;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation PlistManager

+ (id) sharedManager
{
    static PlistManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id) init
{
    self = [super init];

    _documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath = [_documentsPath stringByAppendingPathComponent:@"data.plist"];

    return self;
}

- (NSMutableDictionary *) readFile
{
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath: _filePath];

    if (!fileExists) {
        [[NSFileManager defaultManager] copyItemAtPath: [[NSBundle mainBundle] pathForResource: @"data" ofType: @"plist"] toPath: _filePath error: nil]; // let @"data" generic
    }

    return [NSMutableDictionary dictionaryWithContentsOfFile: _filePath];
}

- (void) writeFileWith: (NSMutableDictionary *)dictionary
{
    [dictionary writeToFile: _filePath atomically: YES];
}

@end
