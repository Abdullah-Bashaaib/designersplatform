import '../../domain/entities/counter.dart';

abstract class CounterLocalDataSource {
  Future<Counter> read();
  Future<Counter> increment();
}

class InMemoryCounterLocalDataSource implements CounterLocalDataSource {
  int _value;

  InMemoryCounterLocalDataSource({int initialValue = 0})
      : _value = initialValue;

  @override
  Future<Counter> read() async {
    return Counter(_value);
  }

  @override
  Future<Counter> increment() async {
    _value += 1;
    return Counter(_value);
  }
}
