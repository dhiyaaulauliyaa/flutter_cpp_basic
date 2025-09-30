#include "counter.h"
#include <jni.h>

int Counter::getValue() const { return value; }

void Counter::increment() { value++; }

void Counter::decrement() { value--; }

void Counter::reset() { value = 0; }

// Global counter instance
static Counter counter;

// JNI functions to expose to Java/Kotlin
extern "C" {
JNIEXPORT jint JNICALL
Java_com_example_flutter_1cpp_1basic_CounterWrapper_getValue(JNIEnv *env,
                                                             jobject thiz) {
  return counter.getValue();
}

JNIEXPORT void JNICALL
Java_com_example_flutter_1cpp_1basic_CounterWrapper_increment(JNIEnv *env,
                                                              jobject thiz) {
  counter.increment();
}

JNIEXPORT void JNICALL
Java_com_example_flutter_1cpp_1basic_CounterWrapper_decrement(JNIEnv *env,
                                                              jobject thiz) {
  counter.decrement();
}

JNIEXPORT void JNICALL
Java_com_example_flutter_1cpp_1basic_CounterWrapper_reset(JNIEnv *env,
                                                          jobject thiz) {
  counter.reset();
}
}