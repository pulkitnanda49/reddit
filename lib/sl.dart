import 'package:ads_url_test/core/database/database.dart';
import 'package:ads_url_test/repository/repository.dart';
import 'package:ads_url_test/repository/source/cache_data_source.dart';
import 'package:ads_url_test/repository/source/remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final GetIt sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton(
    () => Repository(
      cacheSource: sl(),
      remoteSource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => CacheDataSource(
      db: sl(),
    ),
  );

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(sl()),
  );

  sl.registerLazySingleton<Client>(() => Client());

  final _db = DataBase();
  await _db.init();
  sl.registerLazySingleton<DataBase>(() => _db);
}
