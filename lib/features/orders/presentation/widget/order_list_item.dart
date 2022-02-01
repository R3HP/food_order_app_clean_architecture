import 'package:flutter/material.dart';

import 'package:food_order_app/features/orders/domain/entity/order.dart';

class OrderListItem extends StatefulWidget {
  final OrderModel orderModel;

  const OrderListItem({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var expand = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
      reverseDuration: const Duration(milliseconds: 200),
      
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1,color: Colors.grey),
          // boxShadow: const [BoxShadow(offset: Offset(2,2),)]
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.orderModel.totalPrice.toString()),
                if (expand)
                  ...widget.orderModel.cartItemsName
                      .map((productName) => Text(productName))
                      .toList(),
                if (expand) Text(widget.orderModel.address)
              ],
            )),
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
      ),
    );
  }
}
