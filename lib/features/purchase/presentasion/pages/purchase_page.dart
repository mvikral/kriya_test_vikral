import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriya_test_vikral/features/purchase/presentasion/pages/cashout_page.dart';
import 'package:kriya_test_vikral/features/purchase/presentasion/widgets/shop_cart_icon.dart';
import '../../application/cubit/purchase_cubit.dart';
import '../widgets/products_list.dart';
import 'package:lottie/lottie.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart =
        context.select((PurchaseCubit cubit) => cubit.state.cart.total);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return const CashoutPage();
                  },
                ),
              );
            },
            child: SizedBox(
              width: size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: Text(
                      'Checkout',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  ShopCartButton(cart: cart),
                ],
              ),
            ),
          ),
        ],
      ),
      body: const PurchasePageStatus(),
    );
  }
}

class PurchasePageStatus extends StatelessWidget {
  const PurchasePageStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((PurchaseCubit cubit) => cubit.state.status);
    switch (status) {
      case LoadingStatus.initial:
        return Container();
      case LoadingStatus.loading:
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: Lottie.asset(
              'assets/lottie/loading_Lottie.json',
              fit: BoxFit.cover,
            ),
          ),
        );
      case LoadingStatus.loaded:
        return const ProductsList();
      case LoadingStatus.networkFailure:
        return Center(
          child: Lottie.asset(
            'assets/lottie/slow_connection.json',
            fit: BoxFit.cover,
            repeat: false,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        );
      case LoadingStatus.serverFailure:
        return Center(
          child: Lottie.asset(
            'assets/lottie/404.json',
            fit: BoxFit.cover,
            repeat: false,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        );
    }
  }
}
