import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kriya_test_vikral/features/purchase/data/datasources/purchase_remote_data_implementations.dart';
import 'package:kriya_test_vikral/features/purchase/domain/usecases/fetch_all_products.dart';
import 'package:kriya_test_vikral/global/global.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:kriya_test_vikral/features/purchase/domain/repositories/purchase_repository_contract.dart';

@GenerateMocks([
  IPurchaseRepository,
  http.Client,
  InternetConnectionChecker,
  NetworkInfo,
  PurchaseRemoteData,
  FetchAllProducts,
])
void main(List<String> args) {}
