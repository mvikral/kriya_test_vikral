import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/purchase/application/cubit/purchase_cubit.dart';
import 'features/purchase/data/datasources/purchase_remote_data_contracts.dart';
import 'features/purchase/data/datasources/purchase_remote_data_implementations.dart';
import 'features/purchase/domain/repositories/purchase_repository_contract.dart';
import 'features/purchase/domain/repositories/purchase_repository_implementations.dart';
import 'features/purchase/domain/usecases/fetch_all_products.dart';
import 'global/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory(
    () => PurchaseCubit(
      fetchAllProducts: sl(),
    ),
  );
  //Use case
  sl.registerLazySingleton(() => FetchAllProducts(sl()));
  //Repository
  sl.registerLazySingleton<IPurchaseRepository>(
    () => PurchaseRepository(
      service: sl(),
      networkInfo: sl(),
    ),
  );
  //Data Source
  sl.registerLazySingleton<IPurchaseRemoteData>(
    () => PurchaseRemoteData(
      client: sl(),
    ),
  );
  //global
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );
  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
