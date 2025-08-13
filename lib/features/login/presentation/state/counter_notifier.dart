import 'package:flutter/foundation.dart';
import '../../domain/entities/counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import '../../../../core/usecase/usecase.dart';

class CounterNotifier extends ChangeNotifier {
  final GetCounter getCounter;
  final IncrementCounter incrementCounter;

  Counter? _counter;
  bool _loading = false;

  CounterNotifier({
    required this.getCounter,
    required this.incrementCounter,
  });

  Counter? get counter => _counter;
  bool get isLoading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _counter = await getCounter(const NoParams());
    _loading = false;
    notifyListeners();
  }

  Future<void> increment() async {
    _loading = true;
    notifyListeners();
    _counter = await incrementCounter(const NoParams());
    _loading = false;
    notifyListeners();
  }
}
