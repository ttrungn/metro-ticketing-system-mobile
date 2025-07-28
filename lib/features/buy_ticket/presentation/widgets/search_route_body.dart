import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/common/cubit/loading_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/data/request/add_to_cart_request.dart';
import 'package:metro_ticketing_system_mobile/features/buy_ticket/presentation/widgets/buy_ticket_dialog_bottom_part.dart';

import '../../../../core/common/presentation/modals/dialog_utils.dart';
import '../../../../core/common/presentation/modals/payment_result_dialog.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/ticket/buy_ticket_const.dart';
import '../../../../core/utils/builder/ticket_builder.dart';
import '../../logic/buy_ticket_cubit.dart';
import '../../logic/search_route_cubit.dart';
import 'custom_drop_down.dart';

class SearchRouteBody extends StatefulWidget {
  const SearchRouteBody({super.key});

  @override
  State<SearchRouteBody> createState() => _SearchRouteBodyState();
}

class _SearchRouteBodyState extends State<SearchRouteBody> {
  final routeController = TextEditingController();

  final entryStationController = TextEditingController();

  final exitStationController = TextEditingController();
  int _currentValue = 1;
  String? routeId;
  String? entryId;
  String? exitId;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print('building');

    return Form(
      key: _formKey,
      child: BlocBuilder<SearchRouteCubit, SearchRouteState>(
        builder: (context, state) {
          List<DropdownMenuEntry<dynamic>> routes = [];
          List<DropdownMenuEntry<dynamic>> stations = [];
          print(state.stations);
          if (state.routes.isNotEmpty) {
            routes =
                state.routes
                    .map((e) => DropdownMenuEntry(value: e.id, label: e.name))
                    .toList();
          }
          if (state.stations.isNotEmpty) {
            stations =
                state.stations
                    .map((e) => DropdownMenuEntry(value: e.id, label: e.name))
                    .toList();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.read<BuyTicketCubit>().fetchBuyTickets();
                  },
                ),
                title: Text(
                  ConstantBuyTicket.searchRouteTicket,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: ConstantAppColor.primary,
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final boxSizeWidth = constraints.maxWidth * 0.9;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    margin: EdgeInsets.all(30),
                    width: boxSizeWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-4, -4),
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                        BoxShadow(
                          offset: Offset(4, 4),
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        CustomDropDown(
                          textController: routeController,
                          icon: Icon(
                            Icons.train,
                            size: 30,
                            color: ConstantAppColor.primary,
                          ),
                          labelText: Text(
                            'Tuyến',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          dropDownList: routes,
                          customWidth: MediaQuery.of(context).size.width * 0.9,
                          onChanged: (value) {
                            context.read<SearchRouteCubit>().fetchStations(
                              value,
                            );
                            setState(() {
                              routeId = value;
                              entryId = null;
                              exitId = null;
                              entryStationController.clear();
                              exitStationController.clear();
                            });
                          },
                          validator: (value) {
                            if (routeController.text.trim().isEmpty) {
                              return "Vui lòng chọn tuyến";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Icon Column with vertical stroke
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.pin_drop_outlined,
                                    color: ConstantAppColor.primary,
                                    size: 30,
                                  ),
                                  Container(
                                    width: 2,
                                    height: 40,
                                    // adjust spacing between dropdowns
                                    color:
                                        ConstantAppColor
                                            .primary, // stroke color
                                  ),
                                  Icon(
                                    Icons.pin_drop_outlined,
                                    color: ConstantAppColor.primary,
                                    size: 30,
                                  ),
                                ],
                              ),

                              SizedBox(width: 8),

                              // Right Column for Dropdowns
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomDropDown(
                                      textController: entryStationController,
                                      labelText: Text(
                                        'Ga Đến',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      dropDownList: stations,
                                      customWidth:
                                          MediaQuery.of(context).size.width *
                                          0.7,
                                      onChanged: (value) {
                                        entryId = value;
                                      },
                                      validator: (value) {
                                        if (entryStationController.text
                                                .trim()
                                                .isEmpty ||
                                            entryId == null) {
                                          return 'Vui lòng chọn ga đến';
                                        } else if (entryStationController.text
                                                .trim() ==
                                            exitStationController.text.trim()) {
                                          return 'Vui lòng chọn 2 ga khác nhau';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    CustomDropDown(
                                      textController: exitStationController,
                                      labelText: Text(
                                        'Ga Dừng',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      dropDownList: stations,
                                      customWidth:
                                          MediaQuery.of(context).size.width *
                                          0.7,
                                      onChanged: (value) {
                                        exitId = value;
                                        // TODO: handle selection change for exit station
                                      },
                                      validator: (value) {
                                        if (exitStationController.text
                                                .trim()
                                                .isEmpty ||
                                            exitId == null) {
                                          return 'Vui lòng chọn ga đừng';
                                        } else if (entryStationController.text
                                                .trim() ==
                                            exitStationController.text.trim()) {
                                          return 'Vui lòng chọn 2 ga khác nhau';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var loadingState = context.read<LoadingCubit>();
                              loadingState.show();
                              await Future.delayed(Duration(milliseconds: 300));
                              try {
                                var singleUseTicketInfo = await context
                                    .read<SearchRouteCubit>()
                                    .fetchTicket(routeId!, entryId!, exitId!);
                                context.read<LoadingCubit>().hide();
                                singleUseTicketInfo.entryStationName =
                                    entryStationController.text.trim();
                                singleUseTicketInfo.exitStationName =
                                    exitStationController.text.trim();
                                DialogUtils.buildAndShowBuyTicketDialogAction(
                                  context: context,
                                  ticketDetails:
                                      TicketBuilder.buildSingleUseBuyTicketDetailItems(
                                        singleUseTicketInfo,
                                      ),
                                  bottomPart: BuyTicketDialogBottomPart(
                                    currentValue: _currentValue,
                                    onPressed: () async {
                                      var quantity = _currentValue;
                                      var ticketId = singleUseTicketInfo.id;

                                      var request = AddToCartRequest(
                                        ticketId: ticketId,
                                        quantity: quantity,
                                        entryStationId: entryId,
                                        destinationStationId: exitId,
                                        routeId: routeId,
                                      );
                                      await context
                                          .read<BuyTicketCubit>()
                                          .addToCart(request);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PaymentResultDialog(
                                            isSuccess: true,
                                          );
                                        },
                                      );
                                    },
                                    onChangedQuantity: (value) {
                                      setState(() {
                                        _currentValue = value;
                                      });
                                    },
                                  ),
                                )();
                              } finally {
                                loadingState.hide();
                              }
                            } else {}
                          },
                          style: ButtonStyle(
                            shadowColor: WidgetStatePropertyAll(Colors.black12),
                            backgroundColor: WidgetStatePropertyAll(
                              ConstantAppColor.primary,
                            ),
                            overlayColor: WidgetStatePropertyAll(
                              Colors.white.withAlpha(25),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          child: Text(
                            " Mua Liền! ",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
