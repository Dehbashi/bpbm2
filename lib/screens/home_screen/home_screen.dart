import 'package:bpbm2/blocs/service_list_bloc/service_list_bloc.dart';
import 'package:bpbm2/screens/home_screen/widgets/home_screen_service_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ServiceListBloc>(context)
        .add(ServiceListStarted(context: context));
    return BlocBuilder<ServiceListBloc, ServiceListState>(
      builder: (context, state) {
        if (state is ServiceListFailed) {
          return const Center(
            child: Text('خطای نامشخص'),
          );
        } else if (state is ServiceListSuccessful) {
          final serviceList = state.serviceList;
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'چه کارهایی رو می تونید با خیال راحت به ما بسپارید؟',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: HomeScreenServiceList(serviceList: serviceList),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
