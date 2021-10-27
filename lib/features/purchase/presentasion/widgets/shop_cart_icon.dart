import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShopCartButton extends StatelessWidget {
  const ShopCartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final int cart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(FontAwesomeIcons.shoppingCart),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            child: Text(
              cart.toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
    );
  }
}
