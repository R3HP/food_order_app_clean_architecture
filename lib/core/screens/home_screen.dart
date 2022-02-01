import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/features/accounting/presentation/screen/favorits_screen.dart';
import 'package:food_order_app/features/accounting/presentation/screen/profile_screen.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/features/foods/presentation/screens/PageWidgets/all_food_with_category.dart';
import 'package:food_order_app/features/foods/presentation/screens/PageWidgets/home_screen_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  bottomNavigationOnTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final bottomIcons = const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_sharp),
                label: 'See All',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'YourAccount',
              )
            ];

  final bodies = <Map<String,dynamic>>[
    {'name': 'Home', 'page':  HomeScreenWidget()},
    {'name' : 'Categories' , 'page' : const AllFoodWithCategoryScreen()},
    {'name' : 'Favourites' , 'page' : const FavoritsScreen()},
    {'name' : 'YourAccount' , 'page' : const ProfileScreen()},
    
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bool isFirst = true;
    // BlocProvider.value(value: value)
    if (isFirst) {
      context.read<FoodCubit>().loadAllFoodsList();
      isFirst = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: CuStomBottomNavigationBar(iconDatas: const [Icons.home,Icons.list,Icons.favorite,Icons.person], selectedColor: Colors.white, unSelectedColor: Colors.grey, padding: EdgeInsets.all(8.0),shadowColor: Colors.grey,),
        bottomNavigationBar: BottomNavigationBar(
            onTap: bottomNavigationOnTap,
            currentIndex: _currentIndex,
            elevation: 25,
            items: bottomIcons),
        body: bodies[_currentIndex]['page']);
  }
}
