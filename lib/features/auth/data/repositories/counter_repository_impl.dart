import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_data_source.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;

  CounterRepositoryImpl({required this.localDataSource});

  @override
  Future<Counter> getCounter() {
    return localDataSource.read();
  }

  @override
  Future<Counter> increment() {
    return localDataSource.increment();
  }
}
