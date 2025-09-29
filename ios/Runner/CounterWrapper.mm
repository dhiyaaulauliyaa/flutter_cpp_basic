#import "CounterWrapper.h"
#include "cpp/counter.h"

@implementation CounterWrapper {
    Counter *counter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        counter = new Counter();
    }
    return self;
}

- (void)dealloc {
    delete counter;
}

- (int)getValue {
    return counter->getValue();
}

- (void)increment {
    counter->increment();
}

- (void)decrement {
    counter->decrement();
}

- (void)reset {
    counter->reset();
}

@end