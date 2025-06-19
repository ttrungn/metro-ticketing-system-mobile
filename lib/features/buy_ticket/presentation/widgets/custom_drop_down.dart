import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController textController;
  final Icon? icon;
  final Text labelText;
  final double customWidth;
  final List<DropdownMenuEntry<dynamic>> dropDownList;
  final ValueChanged<dynamic> onChanged;

  const CustomDropDown({
    super.key,
    required this.textController,
     this.icon,
    required this.labelText,
    required this.dropDownList,
    required this.customWidth,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<dynamic>(
      controller: textController,
      initialSelection: dropDownList[0],
      enableFilter: true,
      enableSearch: true,
      requestFocusOnTap: true,
      width: customWidth,
      label: labelText,
      leadingIcon: icon,
      dropdownMenuEntries: dropDownList,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: ConstantAppColor.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: ConstantAppColor.primary),
          borderRadius: BorderRadius.circular(10),
        ),

      ),
      menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
        minimumSize: WidgetStatePropertyAll(Size(250, 300)),
      ),
      onSelected: onChanged,

      alignmentOffset: Offset(-20, 0),

    );
  }
}
