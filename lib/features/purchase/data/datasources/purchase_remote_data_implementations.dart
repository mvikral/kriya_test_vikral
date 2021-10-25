import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../global/error/exeptions.dart';
import '../../domain/entities/product.dart';
import '../model/product_model.dart';
import 'purchase_remote_data_contracts.dart';

class PurchaseRemoteData implements IPurchaseRemoteData {
  final http.Client client;
  PurchaseRemoteData({
    required this.client,
  });
  @override
  Future<List<Product>> fetchAllProducts() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await client.get(
      url,
    );
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body) as List;
      var data = decoded.map((e) => ProductModel.fromJson(e)).toList();
      return data;
    } else {
      throw ServerExeption();
    }
  }
}
