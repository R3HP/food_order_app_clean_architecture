import 'package:flutter/material.dart';

class CuStomBottomNavigationBar extends StatefulWidget {
  final List<IconData> iconDatas;
  final List<String>? labels;
  final Color selectedColor;
  final Color unSelectedColor;
  // final Color gradiantColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color background;
  final Color? shadowColor;
  const CuStomBottomNavigationBar({
    Key? key,
    required this.iconDatas,
    this.labels,
    required this.selectedColor,
    required this.unSelectedColor,
    // required this.gradiantColor,
    this.background = Colors.black87,
    this.shadowColor,
    this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    required this.padding,
    this.radius = 20,
  }) : super(key: key);

  @override
  _CuStomBottomNavigationBarState createState() =>
      _CuStomBottomNavigationBarState();
}

class _CuStomBottomNavigationBarState extends State<CuStomBottomNavigationBar> {
  var _selectedIndex = 0;

  onTap(index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(widget.radius),
        color: widget.background,
        child: Container(
          height: 70,
          width: double.infinity,
          padding: widget.padding,
          child: ListView.builder(

            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            scrollDirection: Axis.horizontal,            
            itemCount: widget.iconDatas.length,
            itemBuilder: (ctx, index) => AnimatedContainer(
              padding: EdgeInsets.symmetric(horizontal: 15),
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                border: index == _selectedIndex
                    ? Border(
                        top: BorderSide(
                          width: 3,
                            color: widget.shadowColor ?? widget.selectedColor),
                      )
                    : null,
                gradient: index == _selectedIndex
                    ? LinearGradient(
                        colors: [
                          widget.shadowColor ?? widget.selectedColor,
                          widget.background.withOpacity(0.7),
                          Colors.black
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
              ),
              child: IconButton(
                onPressed: () => onTap(index),
                icon: Icon(
                  widget.iconDatas[index],
                  size: 35,
                  color: index == _selectedIndex
                      ? widget.selectedColor
                      : widget.unSelectedColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
