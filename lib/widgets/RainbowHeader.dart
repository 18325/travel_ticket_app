import 'package:flutter/material.dart';

class RainbowHeader extends StatefulWidget {
  const RainbowHeader({Key? key}) : super(key: key);

  @override
  _RainbowHeaderState createState() => _RainbowHeaderState();
}

class _RainbowHeaderState extends State<RainbowHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Durée pour l'animation complète
      vsync: this,
    )..repeat(); // Répéter l'animation en boucle

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Libérer les ressources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 150, // Hauteur du header
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0.0),
              end: Alignment(-_animation.value, 1.0),
              colors: const [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
              stops: [0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
