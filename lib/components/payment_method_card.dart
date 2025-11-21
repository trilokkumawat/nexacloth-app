import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';
import 'package:nexacloth/components/fontsize.dart';

class PaymentMethodCard extends StatefulWidget {
  final IconData paymentIcon;
  final String paymentName;
  final bool initialSelected;
  final ValueChanged<bool>? onSelectionChanged;
  final bool paymenticonVisible;

  const PaymentMethodCard({
    super.key,
    this.paymentIcon = Icons.credit_card,
    required this.paymentName,
    this.initialSelected = false,
    this.onSelectionChanged,
    this.paymenticonVisible = true,
  });

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initialSelected;
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onSelectionChanged?.call(_isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.paymenticonVisible)
          Icon(widget.paymentIcon, color: CustomAppColor.primary),
        const SizedBox(width: 8),
        Text(
          widget.paymentName,
          style: AppTextStyle.custom(
            fontSize: CustomFontSize.bodySmall,
            fontWeight: FontWeight.w600,
            color: CustomAppColor.text,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: _toggleSelection,
          child: Icon(
            _isSelected ? Icons.check_circle : Icons.remove_circle,
            color: CustomAppColor.primary,
          ),
        ),
      ],
    );
  }
}
