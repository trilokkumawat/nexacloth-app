import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';

class CustomGoogleCard extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool isEnabled;

  const CustomGoogleCard({
    Key? key,
    this.color,
    this.onTap,
    this.padding,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? CustomAppColor.card,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isEnabled ? onTap : null,
        child: Opacity(
          opacity: isEnabled ? 1.0 : 0.5,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return customGradient.createShader(bounds);
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                Text('Continue with Google', style: AppTextStyle.subtextMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
