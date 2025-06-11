

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

import '../../cubit/loading_cubit.dart';

class GlobalLoadingOverlay extends StatelessWidget {
  final Widget child;
  const GlobalLoadingOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder: (context, isLoading) {
        return Stack(
          children: [
            child,
            if (isLoading)
              Container(
                color: Colors.black45,
                child:  Center(
                  child: SpinKitCubeGrid(
                    size: 70,
                    color: ConstantAppColor.primary,
                      duration: Duration(milliseconds: 350),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
