import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';
import 'package:metro_ticketing_system_mobile/features/bus/data/bus_repository.dart';
import 'package:metro_ticketing_system_mobile/features/bus/data/bus_service.dart';
import 'package:metro_ticketing_system_mobile/features/bus/logic/bus_cubit.dart';
import 'package:metro_ticketing_system_mobile/features/bus/presentation/widgets/bus_tile.dart';

class ViewBusPage extends StatefulWidget {
  const ViewBusPage({Key? key}) : super(key: key);

  @override
  State<ViewBusPage> createState() => _ViewBusPageState();
}

class _ViewBusPageState extends State<ViewBusPage> {
  final TextEditingController _stationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _onSearch(BuildContext context) {
    final station = _stationController.text.trim();
    final dest = _destinationController.text.trim();
    context.read<BusCubit>().fetchBuses(
      stationName: station.isNotEmpty ? station : null,
      destinationName: dest.isNotEmpty ? dest : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BusCubit>(
      create: (_) => BusCubit(BusService(BusRepository()))..fetchBuses(),
      child: Builder(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: ConstantAppColor.primary,
                title: const Text(
                  'Danh sách xe bus',
                  style: TextStyle(color: ConstantAppColor.primaryLight),
                ),
              ),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ConstantAppColor.primary.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _stationController,
                                  decoration: InputDecoration(
                                    labelText: 'Tên Trạm',
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                      color: ConstantAppColor.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ConstantAppColor.primary,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: ConstantAppColor.primaryLight
                                        .withOpacity(0.3),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ConstantAppColor.primary.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _destinationController,
                                  decoration: InputDecoration(
                                    labelText: 'Điểm Đến',
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    prefixIcon: Icon(
                                      Icons.flag_outlined,
                                      color: ConstantAppColor.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: ConstantAppColor.primary,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: ConstantAppColor.primaryLight
                                        .withOpacity(0.3),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _onSearch(context),
                            icon: const Icon(Icons.search, color: Colors.white),
                            label: const Text(
                              'Tìm kiếm xe bus',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ConstantAppColor.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<BusCubit, BusState>(
                      builder: (context, state) {
                        if (state is BusLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is BusLoaded) {
                          final buses = state.buses;
                          if (buses.isEmpty) {
                            return const Center(child: Text('Không có bus'));
                          }
                          return ListView.builder(
                            itemCount: buses.length,
                            itemBuilder: (context, index) {
                              return BusTile(bus: buses[index]);
                            },
                          );
                        } else if (state is BusError) {
                          return Center(child: Text('Lỗi: ${state.message}'));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
