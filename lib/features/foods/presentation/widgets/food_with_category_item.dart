import 'package:dartz/dartz.dart' as either;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_app/core/error/failure.dart';

import 'package:food_order_app/core/model/food_category.dart';
import 'package:food_order_app/dependecy_injection.dart';
import 'package:food_order_app/features/foods/data/model/food_model.dart';
import 'package:food_order_app/features/foods/domain/usecase/get_filtered_food.dart';
import 'package:food_order_app/features/foods/presentation/cubit/food_cubit.dart';
import 'package:food_order_app/features/foods/presentation/widgets/food_card.dart';

class FoodWithCategoryItem extends StatefulWidget {
  final Food_Category category;

  const FoodWithCategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<FoodWithCategoryItem> createState() => _FoodWithCategoryItemState();
}

class _FoodWithCategoryItemState extends State<FoodWithCategoryItem> {
  var expand = false;

  @override
  Widget build(BuildContext context) {
    
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepOrange,width: 1.0,),
          boxShadow: const [BoxShadow(offset: Offset(1.0, 1.0),color: Colors.transparent)]
          
        ),
        
        height: expand ? 350 : 50,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(widget.category.toString())),
                IconButton(
                    onPressed: () {
                      setState(() {
                        expand = !expand;
                      });
                    },
                    icon: Icon(expand
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded))
              ],
            ),
            if (expand)
              Expanded(
                child: FutureBuilder(
                    future: GetFilteredFood(repository: getIt())
                        .call(widget.category),
                    builder: (ctx,
                        AsyncSnapshot<either.Either<Failure, List<FoodModel>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.orange,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return snapshot.data!.fold(
                          (failure) => Center(
                            child: Text(failure.toString()),
                          ),
                          (success) => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: success.length,
                            itemBuilder: (ctx, index) =>
                                FoodCard(foodModel: success[index]),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('couldn\'t retrieve data'),
                        );
                      }
                    }),
              )
          ],
        ),
      ),
    );
  }
}
