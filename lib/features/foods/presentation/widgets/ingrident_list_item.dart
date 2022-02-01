import 'package:flutter/material.dart';

import 'package:food_order_app/features/foods/data/model/ingridient_model.dart';

class IngridientListItem extends StatelessWidget {
  final IngridientModel ingridient;

  const IngridientListItem({
    Key? key,
    required this.ingridient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10.0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: 
          // Text('image')
          Image.asset(determinetImageName(),width: 100,height: 100,),
        ),
        title: Text(ingridient.name),
        trailing: Text(ingridient.size),
      ),
    );
  }

  String determinetImageName() {
    var imageName = 'assets/picture/not_found.png';
    switch(ingridient.name){
      case 'Cheese':
      imageName = 'assets/pictures/cheese.png';
      break;
      case 'Meat' :
      imageName = 'assets/pictures/meat.png';
      break;
      case 'Potato' :
      imageName = 'assets/pictures/potato.png';
      break;
      case 'Pepperoni':
      imageName = 'assets/pictures/pepperoni.png';
      break;
    }
    return imageName;
  }
}
