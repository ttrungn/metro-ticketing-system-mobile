import 'package:flutter/material.dart';

import '../../../../core/common/presentation/modals/dashed_line_painter.dart';
import '../../../../core/constants/app_color.dart';
import 'buy_button.dart';

class BuyTicketDialogBottomPart extends StatefulWidget {
  final int currentValue;
  final ValueChanged onChangedQuantity;
  final VoidCallback onPressed;
  const BuyTicketDialogBottomPart({
    required this.onPressed,
    required this.onChangedQuantity,
    required this.currentValue,
    super.key,
  });

  @override
  State<BuyTicketDialogBottomPart> createState() =>
      _BuyTicketDialogBottomPartState();
}

class _BuyTicketDialogBottomPartState extends State<BuyTicketDialogBottomPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomStepper(
          value: widget.currentValue,
          minValue: 1,
          maxValue: 100,
          onChanged: widget.onChangedQuantity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomPaint(painter: DashedLinePainter()),
          ),
        ),
        BuyButton(onPressed: widget.onPressed),
      ],
    );
  }
}

class CustomStepper extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const CustomStepper({
    super.key,
    required this.value,
    this.minValue = 1,
    this.maxValue = 100,
    required this.onChanged,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late int _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.value;
  }

  void _increase() {
    if (_value < widget.maxValue) {
      setState(() {
        _value++;
      });
      widget.onChanged(_value);
    }
  }

  void _decrease() {
    if (_value > widget.minValue) {
      setState(() {
        _value--;
      });
      widget.onChanged(_value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _value > widget.minValue ? _decrease : null,
          icon: Icon(Icons.remove_circle_outline),
          color: ConstantAppColor.primary,
          iconSize: 36,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ConstantAppColor.primary),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$_value',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ConstantAppColor.primary,
            ),
          ),
        ),
        IconButton(
          onPressed: _value < widget.maxValue ? _increase : null,
          icon: Icon(Icons.add_circle_outline),
          color: ConstantAppColor.primary,
          iconSize: 36,
        ),
      ],
    );
  }
}
