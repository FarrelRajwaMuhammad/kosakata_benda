import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ButtonSVG extends StatelessWidget {
  final VoidCallback onPressed;
  final String SVGpath;
  final double size;

  const ButtonSVG({
    Key? key,
    required this.onPressed,
    required this.SVGpath,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size,
            height: size,
            child: Center(
              child: SvgPicture.asset(
                SVGpath,
              ),
            ),
          ),
        ),
      ),
    );
  }
}