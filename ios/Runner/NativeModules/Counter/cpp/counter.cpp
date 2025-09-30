#include "counter.h"

int Counter::getValue() const { return value; }

void Counter::increment() { value++; }

void Counter::decrement() { value--; }

void Counter::reset() { value = 0; }