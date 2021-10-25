import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String title;
  final int quantity;
  const Product({
    required this.title,
    required this.quantity,
  });
  @override
  List<Object?> get props => [title, quantity];
}
