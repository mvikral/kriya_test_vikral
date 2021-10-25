import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kriya_test_vikral/features/purchase/data/model/product_model.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const testProduct = [
    ProductModel(title: 'delectus aut autem', quantity: 0),
    ProductModel(title: 'quis ut nam facilis et officia qui', quantity: 0),
  ];

  group('Product model', () {
    test(
      'should be a subclass of ProductsEntity',
      () {
        expect(testProduct[0], isA<Product>());
        expect(testProduct[1], isA<Product>());
      },
    );

    test(
      'should return a valid model from json',
      () {
        List<dynamic> jsonList = json.decode(
          fixture('products.json'),
        );
        var jsonMap = jsonList.map((item) => ProductModel.fromJson(item));
        expect(jsonMap, equals(testProduct));
      },
    );
  });
}
