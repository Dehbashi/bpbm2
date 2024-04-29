import 'package:bpbm2/blocs/service_detail_bloc/service_detail_bloc.dart';
import 'package:bpbm2/screens/service_detail_screen/widgets/service_detail_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceDetailBloc, ServiceDetailState>(
      builder: (context, state) {
        if (state is ServiceDetailSuccess) {
          return ServiceDetailScreenWidget(
            serviceDetail: state.serviceDetail,
          );
        } else if (state is ServiceDetailFailed) {
          return const Center(
            child: Text('خطای نامشخص'),
          );
        } else if (state is ServiceDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
