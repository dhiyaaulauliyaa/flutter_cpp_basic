#ifndef COUNTER_H
#define COUNTER_H

class Counter {
private:
  int value = 0;

public:
  int getValue() const;
  void increment();
  void decrement();
  void reset();
};

#endif // COUNTER_H