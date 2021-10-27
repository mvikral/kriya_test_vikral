import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../application/cubit/purchase_cubit.dart';
import 'package:kriya_test_vikral/features/purchase/domain/entities/product.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.select(
      (PurchaseCubit cubit) => cubit.state.products,
    );
    return ListView.builder(
      itemBuilder: (context, index) {
        return ProductListItem(index: index);
      },
      itemCount: products.length,
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final product = context.select(
      (PurchaseCubit cubit) => cubit.state.products[index],
    );

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
            SizedBox(
              width: size.width * 0.4,
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              width: size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _substrackButton(context, product),
                  _itemQuantity(size, product, context),
                  _addButton(context, product),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  IconButton _addButton(BuildContext context, Product product) {
    return IconButton(
      onPressed: () {
        context.read<PurchaseCubit>().addProductToCart(product);
      },
      icon: const Icon(
        FontAwesomeIcons.plus,
        color: Colors.blue,
      ),
    );
  }

  SizedBox _itemQuantity(Size size, Product product, BuildContext context) {
    return SizedBox(
      width: size.width * 0.1,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          product.quantity.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }

  Expanded _substrackButton(BuildContext context, Product product) {
    return Expanded(
      flex: 1,
      child: IconButton(
        onPressed: () {
          context.read<PurchaseCubit>().substractProductFromCart(product);
        },
        icon: const Icon(
          FontAwesomeIcons.minus,
          color: Colors.red,
        ),
      ),
    );
  }
}
