import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';

class BackHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool isFavoriteVisible;
  final Color? titleColor;
  final IconData leadingIcon;
  final IconData? actionIcon;

  const BackHeader({
    Key? key,
    this.title = '',
    this.onBack,
    this.isFavoriteVisible = false,
    this.titleColor = CustomAppColor.black,
    this.leadingIcon = Icons.arrow_back,
    this.actionIcon, // default null; if null, use favorite below if isFavoriteVisible
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        decoration: BoxDecoration(
          color: CustomAppColor.greylight,
          borderRadius: BorderRadius.circular(48),
        ),
        child: IconButton(
          icon: Icon(leadingIcon, size: 24),
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
      ),
      actions: [
        if (isFavoriteVisible)
          Container(
            decoration: BoxDecoration(
              color: CustomAppColor.greylight,
              borderRadius: BorderRadius.circular(48),
            ),
            child: IconButton(
              icon: Icon(
                actionIcon ?? Icons.favorite,
                size: 24,
                color: CustomAppColor.black.withOpacity(0.5),
              ),
              onPressed: () {},
            ),
          ),
      ],
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
