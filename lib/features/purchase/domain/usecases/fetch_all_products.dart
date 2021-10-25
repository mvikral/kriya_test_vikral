import 'package:dartz/dartz.dart';

import '../../../../global/error/failures.dart';
import '../entities/product.dart';
import '../repositories/purchase_repository_contract.dart';

class FetchAllProducts {
  final IPurchaseRepository repository;

  FetchAllProducts(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.fetchAllProducts();
  }
}
