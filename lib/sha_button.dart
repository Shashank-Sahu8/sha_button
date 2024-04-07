library sha_button;
import 'package:flutter/material.dart';

class sha_button extends StatefulWidget {
  @override
  _sha_buttonState createState() => _sha_buttonState();
}

class _sha_buttonState extends State<sha_button>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    _colorAnimation = ColorTween(
      begin: Colors.teal,
      end: Colors.indigo,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuad,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: toggleMode,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _colorAnimation.value!,
                        _colorAnimation.value!.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.7, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _colorAnimation.value!.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: isDarkMode
                          ? Icon(
                        Icons.nights_stay,
                        size: 40,
                        color: Colors.white,
                        key: UniqueKey(),
                      )
                          : Icon(
                        Icons.wb_sunny,
                        size: 40,
                        color: Colors.amber,
                        key: UniqueKey(),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}