import 'package:flutter/material.dart';
import 'package:food_order_app/dependecy_injection.dart';
import 'package:food_order_app/features/accounting/data/dataSource/account_data_source.dart';
import 'package:food_order_app/features/accounting/domain/entity/account.dart';
import 'package:food_order_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:food_order_app/features/orders/presentation/screens/orders_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:lottie/lottie.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AccountDataSource(supabase: getIt()).getAccountFromDataBase(
            Supabase.instance.client.auth.currentUser!.id),
        builder: (ctx, AsyncSnapshot<Account> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(10.0),

                      color: Colors.deepOrange.shade200,
                      child: Column(children: [
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Center(child: Text(snapshot.data!.username ?? 'Profile',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
                        ),
                        Column(
                          children: [
                            Lottie.asset('assets/lottie/wallet.json',
                                height: 350,
                                repeat: true),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(

                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: const Text(
                                '\$00.00',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0))),
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(width: 0.7)
                                ),
                                leading: const Icon(Icons.logout,color: Colors.red,),
                                title: const Text('Orders'),
                                onTap: () => Navigator.of(context)
                                      .pushNamed(OrdersScreen.ROUTE_NAME),
                              ),
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(width: 0.7)
                                ),
                                leading: const Icon(Icons.shopping_cart,color: Colors.amber,),
                                title: const Text('Cart'),
                                onTap: () => Navigator.of(context)
                                      .pushNamed(CartScreen.ROUTE_NAME),
                              ),
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(width: 0.7)
                                ),
                                leading: const Icon(Icons.logout,color: Colors.red,),
                                title: const Text('LogOut'),
                                onTap: () => Supabase.instance.client.auth.signOut(),
                              ),
                              
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ));
  }
}
