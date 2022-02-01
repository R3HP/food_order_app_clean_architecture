import 'package:flutter/material.dart';

class CustomNotchedBottomNavigationBar extends StatefulWidget {
  const CustomNotchedBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNotchedBottomNavigationBarstate createState() => _CustomNotchedBottomNavigationBarstate();
}

class _CustomNotchedBottomNavigationBarstate extends State<CustomNotchedBottomNavigationBar> {
  var _currentIndex = 0;

  setBottomBarState(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                // overflow: Overflow.visible,
                clipBehavior: Clip.none,
                children: [
                  CustomPaint(
                    painter: BNBPainter(),
                    size: Size(size.width, 80),
                  ),
                  Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: _currentIndex == 0
                                ? Colors.orange
                                : Colors.white,
                          ),
                          onPressed: () {
                            setBottomBarState(0);
                          },
                          splashColor: Colors.white,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.restaurant_menu,
                              color: _currentIndex == 1
                                  ? Colors.orange
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setBottomBarState(1);
                            }),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              color: _currentIndex == 2
                                  ? Colors.orange
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setBottomBarState(2);
                            }),
                        const NavIcon(
                            icon: Icon(Icons.notifications),
                            label: 'notification',
                            activeColor: Colors.blue,
                            nonActiveColor: Colors.white),
                        // IconButton(
                        //     icon: Icon(
                        //       Icons.notifications,
                        //       color: _currentIndex == 3
                        //           ? Colors.orange
                        //           : Colors.white,
                        //     ),
                        //     onPressed: () {
                        //       setBottomBarState(3);
                        //     }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavIcon extends StatefulWidget {
  final Icon icon;
  final String label;
  final Color activeColor;
  final Color nonActiveColor;
  const NavIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.activeColor,
    required this.nonActiveColor,
  }) : super(key: key);

  @override
  _NavIconState createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> {
  late var _showText = false;
  late Color _IconColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _IconColor = widget.nonActiveColor;
  }

  changeActive() {
    setState(() {
      _showText = !_showText;

      _IconColor = _IconColor == widget.activeColor
          ? widget.nonActiveColor
          : widget.activeColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: widget.icon,
          color: _IconColor,
          onPressed: changeActive,
          splashColor: Colors.white,
        ),
        AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: _showText == true ? Text(widget.label) : null)
      ],
    );
  }
}

// class MyCustomBOttomNavigationIcon extends StatelessWidget {
//   final Icon icon;
//   final String title;
//   const MyCustomBOttomNavigationIcon({
//     Key? key,
//     required this.icon,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     BottomNavigationBarItem(icon: icon,)
//   }
// }

class BNBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = new Paint()
    //   ..color = Colors.white
    //   ..style = PaintingStyle.fill;

    // Path path = Path();
    // path.moveTo(0, 20); // Start
    // path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    // path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    // path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    // path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.lineTo(0, 20);
    // canvas.drawShadow(path, Colors.black, 5, true);
    // canvas.drawPath(path, paint);

    // Paint paint1 = Paint()
    // ..color = Colors.white
    // ..style = PaintingStyle.fill;

    // Path path1 = Path();
    // path1.moveTo(0, 20);
    // path1.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    // path1.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    // path1.arcToPoint(Offset(size.width * 0.60, 20) , radius: Radius.circular(20.0) , clockwise: false);
    // path1.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    // path1.quadraticBezierTo(size.width * 0.80, 0, size.width , 20);
    // path1.lineTo(size.width, size.height);
    // path1.lineTo(0, size.height);
    // path1.lineTo(0, 20);
    // canvas.drawPath(path1, paint1);

    Paint paint2 = Paint()
      ..color = Colors.green.shade300
      ..style = PaintingStyle.fill;
    Path path2 = Path();
    path2.moveTo(0, 20);
    path2.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path2.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path2.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path2.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path2.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.lineTo(0, 20);
    canvas.drawShadow(path2, Colors.orange.shade200, 5, true);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
