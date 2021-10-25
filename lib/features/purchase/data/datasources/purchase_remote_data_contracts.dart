import '../../domain/entities/product.dart';

abstract class IPurchaseRemoteData {
  Future<List<Product>> fetchAllProducts();
}
