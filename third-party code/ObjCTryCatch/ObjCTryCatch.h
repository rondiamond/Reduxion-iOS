#ifndef ObjCTryCatch_h
#define ObjCTryCatch_h

#import <Foundation/Foundation.h>

@interface ObjCTryCatch : NSObject

/*
 // Wrapper to convert NSException to Swift error
 // from http://stackoverflow.com/a/36454808 (user 'freytag')

 Usage:
 
 do {
    try ObjCTryCatch.catchException {
    // calls that might throw an NSException
    }
 }
 catch let error {
    print("An error ocurred: \(error)")
 }
*/

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end

#endif /* ObjCTryCatch_h */
