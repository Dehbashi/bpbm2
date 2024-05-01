import 'package:bpbm2/blocs/service_detail_bloc/service_detail_bloc.dart';
import 'package:bpbm2/data/models/service_list/service_list_model.dart';
import 'package:bpbm2/screens/service_detail_screen/detail_screens/service_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenServiceList extends StatelessWidget {
  final ScrollController scrollController;
  const HomeScreenServiceList({
    super.key,
    required this.serviceList,
    required this.scrollController,
  });

  final List<ServiceListModel> serviceList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 2,
        childAspectRatio: 0.75,
        // mainAxisSpacing: 5,
      ),
      itemCount: serviceList.length,
      itemBuilder: (context, index) {
        final service = serviceList[index];
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            BlocProvider.of<ServiceDetailBloc>(context).add(
              ServiceDetailStarted(
                context: context,
                serviceId: service.id,
              ),
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ServiceDetailScreen(),
              ),
            );
          },
          child: Column(
            children: [
              Image.asset(
                'assets/icons/homeicons/${service.id}.webp',
                width: 50,
                height: 50,
              ),
              Expanded(
                child: Text(
                  service.title,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
