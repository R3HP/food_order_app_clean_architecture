import 'dart:async';

import 'package:flutter/material.dart';

class FavoritsScreen extends StatefulWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  @override
  State<FavoritsScreen> createState() => _FavoritsScreenState();
}

class _FavoritsScreenState extends State<FavoritsScreen>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this);
    var _showFirst = true;
    late final Timer timer ;

  var imagePath= 'assets/icons/heart.png';

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) { 
      setState(() {
        _showFirst = !_showFirst;
      });
    });
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();

    
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 500,
          width: double.infinity,
          child: AnimatedCrossFade(
            firstChild: Image.asset('assets/icons/heart.png'),
            secondChild: Image.asset('assets/icons/favourite.png'),
            crossFadeState: _showFirst? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            duration: const Duration(milliseconds: 200),
            
            )),
      ),
    ),
    const Text('Nothing Yet'),
      ],
    );
  }
}
