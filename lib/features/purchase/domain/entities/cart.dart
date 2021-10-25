import 'package:equatable/equatable.dart';

import 'product.dart';

class Cart extends Equatable {
  final List<Product> products;
  final int total;

  const Cart({
    required this.products,
    required this.total,
  });
  @override
  List<Object?> get props => [total, products];
}
