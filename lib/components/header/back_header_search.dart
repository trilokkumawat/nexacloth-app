import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';

class BackHeaderSearch extends StatelessWidget implements PreferredSizeWidget {
  final String? hintText;
  final TextEditingController? controller;
  final VoidCallback? onBack;
  final ValueChanged<String>? onChanged;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isBackVisible;
  final bool? isSuffixiconVisible;

  const BackHeaderSearch({
    Key? key,
    this.hintText = "Search...",
    this.controller,
    this.onBack,
    this.onChanged,
    this.suffixIcon,
    this.onSuffixTap,
    this.isBackVisible = true,
    this.isSuffixiconVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBackVisible
          ? Container(
              decoration: BoxDecoration(
                color: CustomAppColor.greylight,
                borderRadius: BorderRadius.circular(48),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 24),
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              ),
            )
          : null,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: CustomAppColor.greylight,
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: const TextStyle(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: CustomAppColor.black.withOpacity(0.5)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 0,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black54,
              size: 22,
            ),
            suffixIcon: isSuffixiconVisible == true && suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon, color: Colors.black, size: 22),
                    onPressed: onSuffixTap,
                  )
                : null,
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
