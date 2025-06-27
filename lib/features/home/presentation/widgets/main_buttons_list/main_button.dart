
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/common/cubit/loading_cubit.dart';
import '../../../../../core/constants/app_color.dart';

class MainButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Future<void> Function() onPressed;

  const MainButton({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      icon: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: ConstantAppColor.primaryLight,
              ),

              child: Center(
                child: FaIcon(
                  icon,
                  color: ConstantAppColor.primary,
                  size: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: ConstantAppColor.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
      onPressed: () async{
        final loadingCubit = context.read<LoadingCubit>();
        loadingCubit.show();
        await Future.delayed(Duration(milliseconds: 500));
        loadingCubit.hide();

        await onPressed();
      },
    );
  }
}
