import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/features/accounting/presentation/cubit/account_cubit.dart';
import 'package:food_order_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_order_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:food_order_app/features/foods/presentation/screens/food_detail_screen.dart';
import 'package:food_order_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:food_order_app/features/orders/presentation/screens/orders_screen.dart';
import 'package:gotrue/gotrue.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:food_order_app/dependecy_injection.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/core/screens/home_screen.dart';

import 'features/accounting/presentation/screen/auth_screen.dart';

void main() async {
  print('main');
  WidgetsFlutterBinding.ensureInitialized();

  // HydratedBloc.storage = await HydratedStorage.build(
  //     storageDirectory: await syspath.getApplicationDocumentsDirectory());

  await Supabase.initialize(
    localStorage: const HiveLocalStorage(),
    authCallbackUrlHostname: 'login-callback',
    url: 'https://cogemafmwhqnlsvergqx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYzNDQwMjQzMiwiZXhwIjoxOTQ5OTc4NDMyfQ.wnLn0fxdSQsI8pEeKKK2H4cjc8jkpnUVVtY0S6h94SQ',
  );
  // TODO: implement getAllFood

  injectDependency();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodCubit>(
          create: (context) => getIt<FoodCubit>(),
        ),
        BlocProvider<AccountCubit>(
          create: (context) => getIt<AccountCubit>(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => getIt<CartCubit>(),
        ),
        BlocProvider<OrderCubit>(
          create: (context) => getIt<OrderCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          FoodDetailsScreen.ROUTE_NAME: (ctx) => FoodDetailsScreen(),
          CartScreen.ROUTE_NAME: (ctx) => const CartScreen(),
          OrdersScreen.ROUTE_NAME : (ctx) => const OrdersScreen()
        },
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: SupabaseAuth.instance.hasAccessToken,
          builder: (ctx, hasAccessToken) => hasAccessToken.connectionState ==
                  ConnectionState.waiting
              ? SplachScreen()
              : StreamBuilder(
                  initialData: hasAccessToken.data == true
                      ? AuthChangeEvent.signedIn
                      : AuthChangeEvent.signedOut,
                  stream: SupabaseAuth.instance.onAuthChange,
                  builder:
                      (ctx, AsyncSnapshot<AuthChangeEvent> asyncAuthSnapshot) =>
                          asyncAuthSnapshot.data == AuthChangeEvent.signedIn
                              ? HomeScreen()
                              : AuthScreen()),
        ),


        // home: OrdersScreen(),

        // home: StreamBuilder(
        //   stream: SupabaseAuth.instance.onAuthChange,),


        // home: StreamBuilder(
        //   stream: SupabaseAuth.instance.onAuthChange,
        //   builder: (ctx, AsyncSnapshot<AuthChangeEvent> asyncAuthSnapshot) =>
        //       asyncAuthSnapshot.connectionState == ConnectionState.waiting
        //           ? AuthScreen()
        //           : asyncAuthSnapshot.data == AuthChangeEvent.signedOut
        //               ? AuthScreen()
        //               : HomeScreen(),
        // ),
      ),
    );
  }
}

class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('splash'),
      ),
    );
  }
}
