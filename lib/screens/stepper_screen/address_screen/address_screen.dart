import 'package:bpbm2/blocs/address_bloc/address_bloc.dart';
import 'package:bpbm2/blocs/stepper_bloc/stepper_bloc.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:bpbm2/providers/price_provider.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/address_status.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/current_address_screen.dart';
import 'package:bpbm2/screens/stepper_screen/address_screen/widgets/new_address_screen.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_button.dart';
import 'package:bpbm2/screens/stepper_screen/widgets/stepper_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late AddressBloc bloc;
  int selectedAddress = -1;
  bool isCurrentAddressScreen = true;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddressBloc>(context);
    bloc.add(AddressStarted(context: context));
  }

  void selectRadioButton(int? value) {
    setState(() {
      selectedAddress = value ?? -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                if (state is CurrentAddressSuccess) {
                  isCurrentAddressScreen = true;
                  return CurrentAddressScreeen(
                    bloc: bloc,
                    state: state,
                    selectedAddress: selectedAddress,
                    selectRadioButton: selectRadioButton,
                  );
                } else if (state is NewAddressSuccess) {
                  isCurrentAddressScreen = false;
                  return NewAddressScreen(
                    state: state,
                    bloc: bloc,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // const StepperButtons(),
      ],
    );
  }
}
