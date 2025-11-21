import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/fontsize.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final InputBorder? border;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showPrefixIcon;
  final bool showSuffixIcon;
  final String? Function(String?)? validator;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  final Color? fillColor;

  /// bg color change: set [fillColor], defaults to [CustomAppColor.greybg]
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.showPrefixIcon = true,
    this.showSuffixIcon = true,
    this.validator,
    this.initialValue,
    this.onChanged,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.fillColor, // new param for background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final InputBorder effectiveBorder =
        border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CustomAppColor.greylight),
        );

    final InputBorder effectiveEnabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomAppColor.greylight),
    );

    final InputBorder effectiveFocusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomAppColor.greylight),
    );

    final InputBorder effectiveErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: CustomAppColor.greylight),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      initialValue: controller == null ? initialValue : null,
      validator: validator,
      onChanged: onChanged,
      textInputAction: textInputAction,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        hintText: hintText,
        hintStyle: AppTextStyle.custom(
          fontWeight: FontWeight.w600,
          fontSize: CustomFontSize.bodyMedium,
          color: CustomAppColor.grey,
        ),
        border: effectiveBorder,
        enabledBorder: effectiveEnabledBorder,
        focusedBorder: effectiveFocusedBorder,
        errorBorder: effectiveErrorBorder,
        focusedErrorBorder: effectiveErrorBorder,
        prefixIcon: showPrefixIcon ? prefixIcon : null,
        suffixIcon: showSuffixIcon ? suffixIcon : null,
        counterText: maxLength == null ? null : '',
        filled: true,
        fillColor:
            fillColor ??
            CustomAppColor
                .background, // set default fill color/background color
      ),
      style: AppTextStyle.custom(fontSize: CustomFontSize.bodyMedium),
    );
  }
}
