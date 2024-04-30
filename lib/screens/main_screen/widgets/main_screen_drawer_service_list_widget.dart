import 'package:bpbm2/blocs/service_detail_bloc/service_detail_bloc.dart';
import 'package:bpbm2/data/models/service_list/service_list_model.dart';
import 'package:bpbm2/screens/service_detail_screen/detail_screens/service_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenDrawerServiceListWidget extends StatelessWidget {
  const MainScreenDrawerServiceListWidget({
    super.key,
    required this.service,
    required this.navKey,
    required this.imagePath,
    required this.scaffoldKey,
  });

  final ServiceListModel service;
  final GlobalKey<NavigatorState> navKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        BlocProvider.of<ServiceDetailBloc>(context).add(
          ServiceDetailStarted(
            serviceId: service.id,
            context: context,
          ),
        );
        navKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => const ServiceDetailScreen(),
          ),
        );
        scaffoldKey.currentState!.closeDrawer();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 20,
            ),
            const SizedBox(width: 20),
            Text(service.title),
          ],
        ),
      ),
    );
  }
}