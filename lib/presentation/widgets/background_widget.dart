import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskmanager/presentation/utils/assets_path.dart';

class backgroundwidget extends StatelessWidget {
  const backgroundwidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
