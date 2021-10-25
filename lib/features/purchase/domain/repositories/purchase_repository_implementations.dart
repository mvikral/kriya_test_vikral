import 'package:dartz/dartz.dart';

import 'package:kriya_test_vikral/features/purchase/data/datasources/purchase_remote_data_implementations.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';
import 'package:kriya_test_vikral/features/purchase/domain/repositories/purchase_repository_contract.dart';
import 'package:kriya_test_vikral/global/error/exeptions.dart';
import 'package:kriya_test_vikral/global/error/failures.dart';
import 'package:kriya_test_vikral/global/network/network_info.dart';

class PurchaseRepository implements IPurchaseRepository {
  final PurchaseRemoteData service;
  final NetworkInfo networkInfo;
  PurchaseRepository({
    required this.service,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Product>>> fetchAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await service.fetchAllProducts();
        return Right(data);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
