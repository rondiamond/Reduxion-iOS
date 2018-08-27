#import <Foundation/Foundation.h>
#import "ObjCTryCatch.h"

@implementation ObjCTryCatch

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error {
    @try {
        tryBlock();
        return YES;     // must return something (to prevent falling through to Catch block)
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
}

@end
