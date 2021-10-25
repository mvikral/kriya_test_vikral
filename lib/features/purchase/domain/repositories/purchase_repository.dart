import 'package:dartz/dartz.dart';

import '../../../../global/error/failures.dart';
import '../entities/product.dart';

abstract class IPurchaseRepository {
  Future<Either<Failure, List<Product>>> fetchAllProducts();
}
