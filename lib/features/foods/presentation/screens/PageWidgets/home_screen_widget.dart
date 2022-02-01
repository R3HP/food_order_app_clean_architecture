import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/features/foods/presentation/widgets/category_food_bloc_builder.dart';
import 'package:food_order_app/features/foods/presentation/widgets/hot_food_bloc_builder.dart';

import '../../../../../dependecy_injection.dart';

class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget({
    Key? key,
  }) : super(key: key);

  final textFieldKey = GlobalKey();
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(textFieldKey.currentState!.context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0,right: 15.0,left: 15.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hello,Again',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 24),),
                    SizedBox(height: 5.0,),
                    Text(
                      'what are you looking for today ?',
                      style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic,),
                    ),
                  ],
                ),
                IconButton(onPressed: () => Navigator.of(context).pushNamed(CartScreen.ROUTE_NAME), icon: const Icon(Icons.shopping_bag_rounded,color: Colors.green,))
              ],
            ),
            const SizedBox(height: 10.0,),
            RoundedTextField(key: textFieldKey,),
            const SizedBox(height: 15.0,),
            // TODO : Food Trivia
            // if(isSomething)
            // showRandomShit
            const Text(
              'Hot Foods',
              style: TextStyle(fontSize: 24, color: Colors.redAccent),
            ),
            const Text(
              'up to 50% off',
            ),
            BlocProvider<FoodCubit>(
              create: (context) => getIt<FoodCubit>(),
              child: HotFoodsBlocBuilder(),
            ),
            const CategoryFoodBlocBuilder(),
          ],
        ),
      ),
    );
  }
}

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  double _radiusBorder = 10;
  FocusNode textFiledFocusNode = FocusNode();
  // final _key = GlobalKey<_RoundedTextFieldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFiledFocusNode.addListener(() {
      if(textFiledFocusNode.hasFocus){
      setState(() {
        _radiusBorder = 25;
      });
      }else{
        setState(() {
          _radiusBorder = 10;
        });
      }
    });    
  }

  @override
  void dispose() {
    textFiledFocusNode.removeListener(() { });
    textFiledFocusNode.removeListener(() { });
    textFiledFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      padding: const EdgeInsets.all(8.0),
      duration: const Duration(microseconds: 2),
      curve: Curves.linear,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(_radiusBorder)
      ),
      child: TextField(
        focusNode: textFiledFocusNode,
        // key: _key,
        // onTap: () {
        //   setState(() {
        //     _radiusBorder = 25.0;
        //   });
        // },
        // focusNode: textFiledFocusNode,
        decoration: const InputDecoration(
            icon: Icon(Icons.search_sharp),
            hintText: 'Search for a Food',
            // filled: true,
            // fillColor: Colors.grey,
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            //   borderSide: const BorderSide(width: 0.5)
            // ),
            // focusedBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(15),
            //     borderSide: const BorderSide(width: 1)),
            hintStyle: TextStyle(color: Colors.cyan)),
        onSubmitted: (str) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('this is not implemented yet'),
          ),
        ),
      ),
    );
  }
}
