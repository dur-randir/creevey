//Copyright 2005 Dominic Yu. Some rights reserved.
//This work is licensed under the Creative Commons
//Attribution-NonCommercial-ShareAlike License. To view a copy of this
//license, visit http://creativecommons.org/licenses/by-nc-sa/2.0/ or send
//a letter to Creative Commons, 559 Nathan Abbott Way, Stanford,
//California 94305, USA.

//  Created by d on 2005.06.13.

#import "NSIndexSetSymDiffExtension.h"

@implementation NSMutableIndexSet (SymDiffExtension)

- (void)symmetricDifference:(NSIndexSet *)setB
{
	NSUInteger * restrict a, * restrict b, aCount, bCount, i, j;
	aCount = self.count; i = 0;
	bCount = setB.count; j = 0;
	
	// some trivial cases
	if (bCount == 0) return;
	if (aCount == 0) {
		[self addIndexes:setB];
		return;
	}
	// now the meat
	a = malloc(aCount*sizeof(NSUInteger)); if (!a) return;
	b = malloc(bCount*sizeof(NSUInteger)); if (!b) { free(a); return; }
	[self getIndexes:a maxCount:aCount inIndexRange:NULL];
	[setB getIndexes:b maxCount:bCount inIndexRange:NULL];
	while (i < aCount && j < bCount) {
		if (a[i] == b[j]) {
			[self removeIndex:a[i++]];
			++j;
		} else if (a[i] < b[j]) {
			++i;
		} else {
			[self addIndex:b[j++]];
		}
	}
	while (j < bCount) [self addIndex:b[j++]];
	free(a);
	free(b);
}

@end
