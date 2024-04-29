import 'package:bpbm2/data/models/service_list/service_list_model.dart';
import 'package:flutter/material.dart';

class HomeScreenServiceList extends StatelessWidget {
  const HomeScreenServiceList({
    super.key,
    required this.serviceList,
  });

  final List<ServiceListModel> serviceList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
          onTap: () {},
          child: Column(
            children: [
              Image.asset(
                'assets/icons/homeicons/${service.id}.webp',
                width: 50,
                height: 50,
              ),
              Text(
                service.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
