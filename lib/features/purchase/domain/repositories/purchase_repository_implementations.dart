import 'package:dartz/dartz.dart';

import '../../data/datasources/purchase_remote_data_implementations.dart';
import '../entities/product.dart';
import 'purchase_repository_contract.dart';
import '../../../../global/error/exeptions.dart';
import '../../../../global/error/failures.dart';
import '../../../../global/network/network_info.dart';

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
