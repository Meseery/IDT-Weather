//
//  ReversedString.m
//  IDT-Test
//
//  Created by Mohamed EL Meseery on 11/29/16.
//  Copyright © 2016 Mohamed EL Meseery. All rights reserved.
//

#import "ReversedString.h"

@implementation ReversedString

+ (NSString *)reverseString:(NSString*)string {
    NSUInteger length = [string length];
    // If string is just one character, it will be the same reversed.
    if (length < 2) {
        return string;
    }
    
    // a mutable string is used to compose the reversed string.
    NSMutableString *reversedString = [NSMutableString stringWithCapacity:length];
    // enumurate over each character in `string` and append the `reversedString`.
    [string enumerateSubstringsInRange:NSMakeRange(0, length)
                             options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              // Get Last character from string and append it.
                              [reversedString appendString:substring];
                          }];
    return reversedString;
}

@end
