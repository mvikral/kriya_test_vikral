import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application_theme.dart';
import 'features/purchase/application/cubit/purchase_cubit.dart';
import 'features/purchase/presentasion/pages/purchase_page.dart';
import 'injection_container.dart' as dependency_injector;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PurchaseCubit>()..fetchAllProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AplicationTheme().applicationTheme(),
        home: const PurchasePage(),
      ),
    );
  }
}
