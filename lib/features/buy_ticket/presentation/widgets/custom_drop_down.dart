import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController textController;
  final Icon? icon;
  final Text labelText;
  final double customWidth;
  final List<DropdownMenuEntry<dynamic>> dropDownList;
  final ValueChanged<dynamic> onChanged;
  final FormFieldValidator<String>? validator;

  const CustomDropDown({
    super.key,
    required this.textController,
    this.icon,
    required this.labelText,
    required this.dropDownList,
    required this.customWidth,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu<dynamic>(
              controller: textController,
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
              menuStyle: const MenuStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                minimumSize: WidgetStatePropertyAll(Size(250, 300)),
              ),
              onSelected: (value) {
                textController.text = value.toString();
                onChanged(value);
                fieldState.didChange(value);
                print(value);
                // Notify form
              },
              alignmentOffset: const Offset(-20, 0),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  fieldState.errorText ?? '',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
