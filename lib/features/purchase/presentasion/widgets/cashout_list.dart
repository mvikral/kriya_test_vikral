import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';

import '../../application/cubit/purchase_cubit.dart';

class CashoutList extends StatelessWidget {
  const CashoutList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.select(
      (PurchaseCubit cubit) => cubit.state.cart,
    );
    return cart.products.isEmpty
        ? Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/lottie/empty.json',
                fit: BoxFit.cover,
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return CashoutListItems(
                product: cart.products[index],
              );
            },
            itemCount: cart.products.length,
          );
  }
}

class CashoutListItems extends StatelessWidget {
  const CashoutListItems({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      child: Container(
        height: size.height * 0.15,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _titleItem(size, product, context),
            _quantityItem(size, product, context)
          ],
        ),
      ),
    );
  }

  SizedBox _titleItem(Size size, Product product, BuildContext context) {
    return SizedBox(
      width: size.width * 0.4,
      child: Text(
        product.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  SizedBox _quantityItem(Size size, Product product, BuildContext context) {
    return SizedBox(
      width: size.width * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: size.width * 0.1,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                product.quantity.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
