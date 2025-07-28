import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/widgets/cart_button.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

import '../../cubit/loading_cubit.dart';

class GlobalLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool showCartButton;
  const GlobalLoadingOverlay({
    required this.child,
    required this.showCartButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return Stack(
          children: [
            child,
            if (state.isLoading)
              Container(
                color: Colors.black45,
                child: Center(
                  child: SpinKitCubeGrid(
                    size: 70,
                    color: ConstantAppColor.primary,
                    duration: Duration(milliseconds: 350),
                  ),
                ),
              ),
            if (showCartButton)
              Positioned(bottom: 30, right: 30, child: CartButton()),
          ],
        );
      },
    );
  }
}
