//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "Three20UI/TTTextView.h"

// UI
#import "Three20UI/UIViewAdditions.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTextView

@synthesize autoresizesToText = _autoresizesToText;
@synthesize overflowed        = _overflowed;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {
  if (_autoresizesToText) {
    if (!_overflowed) {
      // In autosizing mode, we don't ever allow the text view to scroll past zero
      // unless it has past its maximum number of lines
      [super setContentOffset:CGPointZero animated:animated];

    } else {
      // If there is an overflow, we force the text view to keep the cursor at the bottom of the
      // view but only if we are already at bottom. Otherwise it becomes IMPOSSIBLE to scroll back
	  // to the top
		if (offset.y + self.height >= self.contentSize.height)
		  [super setContentOffset: CGPointMake(offset.x, self.contentSize.height - self.height)
						 animated: animated];
		else
		  [super setContentOffset:offset animated:animated];
    }

  } else {
    [super setContentOffset:offset animated:animated];
  }
}


@end
