import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriya_test_vikral/features/purchase/application/cubit/purchase_cubit.dart';
import 'package:kriya_test_vikral/features/purchase/presentasion/widgets/cashout_list.dart';
import 'package:kriya_test_vikral/features/purchase/presentasion/widgets/shop_cart_icon.dart';

class CashoutPage extends StatelessWidget {
  const CashoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart =
        context.select((PurchaseCubit cubit) => cubit.state.cart.total);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () async {
              await context.read<PurchaseCubit>().finishPayment();
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: Text(
                      'Bayar',
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
      body: const CashoutList(),
    );
  }
}
