
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskmanager/presentation/utils/assets_path.dart';

class applogo extends StatelessWidget {
  const applogo({super.key,});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsPath.logoSvg,
      width: 120,
      fit: BoxFit.scaleDown,
    );
  }
}
