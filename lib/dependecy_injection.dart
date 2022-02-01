
import 'package:food_order_app/features/accounting/data/dataSource/account_data_source.dart';
import 'package:food_order_app/features/accounting/data/repository/account_repository_impl.dart';
import 'package:food_order_app/features/accounting/domain/repository/account_repository.dart';
import 'package:food_order_app/features/accounting/domain/usecase/account_signin.dart';
import 'package:food_order_app/features/accounting/domain/usecase/account_signup.dart';
import 'package:food_order_app/features/accounting/domain/usecase/account_update.dart';
import 'package:food_order_app/features/cart/data/dataSource/cart_data_source.dart';
import 'package:food_order_app/features/cart/data/repository/cart_repository_impl.dart';
import 'package:food_order_app/features/cart/domain/repository/cart_repository.dart';
import 'package:food_order_app/features/cart/domain/usecase/add_cart_item_cart_list.dart';
import 'package:food_order_app/features/cart/domain/usecase/clear_cart.dart';
import 'package:food_order_app/features/cart/domain/usecase/delete_cart_item_from_cart_list.dart';
import 'package:food_order_app/features/cart/domain/usecase/get_cart_items.dart';
import 'package:food_order_app/features/cart/domain/usecase/update_item_quantity.dart';
import 'package:food_order_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_order_app/features/foods/data/dataSource/foods_data_source.dart';
import 'package:food_order_app/features/foods/data/repository/food_repository_impl.dart';
import 'package:food_order_app/features/foods/domain/repository/food_repository.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_all_food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_filtered_food.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_hot_food.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/features/orders/data/dataSource/order_data_source.dart';
import 'package:food_order_app/features/orders/data/respository/order_repository_impl.dart';
import 'package:food_order_app/features/orders/domain/repository/order_repository.dart';
import 'package:food_order_app/features/orders/domain/usecase/add_new_order_usecase.dart';
import 'package:food_order_app/features/orders/domain/usecase/get_user_orders_data_usecase.dart';
import 'package:food_order_app/features/orders/domain/usecase/update_order.dart';
import 'package:food_order_app/features/orders/presentation/cubit/order_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/accounting/presentation/cubit/account_cubit.dart';

final GetIt getIt = GetIt.instance;

void injectDependency(){

  //Blocs and Cubits 
  //FoodCubit
  getIt.registerFactory<FoodCubit>(() => FoodCubit(allFood: getIt(),hotFood: getIt(), filteredFood: getIt()));
  // getIt.registerFactory<FoodCubit>(() => FoodCubit(allFood: getIt(), filteredFood: getIt()),instanceName: 'categoryCubit');
  //AccountCubit
  getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt(), getIt(), getIt()));
  // Cart 
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt(), getIt(), getIt(), getIt()));
  // Order 
  getIt.registerFactory<OrderCubit>(() => OrderCubit(getIt(),getIt(),getIt()));
  


  //UseCases

  //FoodUseCases
  getIt.registerLazySingleton<GetAllFoodUseCase>(() => GetAllFoodUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetFilteredFood>(() => GetFilteredFood(repository: getIt()));
  getIt.registerLazySingleton<GetHotFoodUseCase>(() => GetHotFoodUseCase(repository: getIt()));
  //AccountUseCase
  getIt.registerLazySingleton<AccountSignUpUseCase>(() => AccountSignUpUseCase(repository: getIt()));
  getIt.registerLazySingleton<AccountSignInUseCase>(() => AccountSignInUseCase(repository: getIt()));
  getIt.registerLazySingleton<AccountUpdateUseCase>(() => AccountUpdateUseCase(repository: getIt()));
  // CartUseCase 
  getIt.registerLazySingleton<GetCartItemsUseCase>(() => GetCartItemsUseCase(cartRepository: getIt()));
  getIt.registerLazySingleton<ClearCartUseCase>(() => ClearCartUseCase(cartRepository: getIt()));
  getIt.registerLazySingleton<AddCartItemToCartListUseCase>(() => AddCartItemToCartListUseCase(cartRepository: getIt()));
  getIt.registerLazySingleton<DeleteCartItemFromCartListUseCase>(() => DeleteCartItemFromCartListUseCase(cartRepository: getIt()));
  getIt.registerLazySingleton<UpdateItemQuantityUseCase>(() => UpdateItemQuantityUseCase(cartRepository: getIt()));
  // OrderUseCase
  getIt.registerLazySingleton<AddNewOrderUseCase>(() => AddNewOrderUseCase(orderRepository: getIt()));
  getIt.registerLazySingleton<GetUserOrdersUseCase>(() => GetUserOrdersUseCase(orderRepository: getIt()));
  getIt.registerLazySingleton<UpdateOrderUseCase>(() => UpdateOrderUseCase(orderRepository: getIt()));

  //Repositories

  //FoodRepository
  getIt.registerLazySingleton<FoodRepository>(() => FoodRepositoryImp(dataSource: getIt()));
  //AccountRepository
  getIt.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(dataSource: getIt()));
  // CartRepository
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(dataSource: getIt()));
  //OrderRepository
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepositoryIMpl(orderDataSource: getIt()));


  //DataSources

  //FoodDataSource
  getIt.registerLazySingleton<FoodDataSource>(() => FoodDataSourceImpl(supabase: getIt()));
  //AccountDataSource
  getIt.registerLazySingleton<AccountDataSource>(() => AccountDataSource(supabase: getIt()));
  // CartDataSource
  getIt.registerLazySingleton<CartDataSource>(() => CartDataSourceImpl());
  // OrderDataSource
  getIt.registerLazySingleton<OrderDataSource>(() => OrderDataSource(supabase: getIt()));


  //EXTERNALS

  //SupaBase
  getIt.registerLazySingleton<Supabase>(() => Supabase.instance);


}