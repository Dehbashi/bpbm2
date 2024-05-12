import 'package:bpbm2/blocs/final_order_bloc/final_order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class DiscountWidget extends StatelessWidget {
  final FinalOrderSuccess state;
  const DiscountWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اگر کد تخفیف دارید اینجا ثبت کنید',
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: _controller,
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomLeft: Radius.circular(3),
                            ),
                          ),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<FinalOrderBloc>(context)
                            .add(RegisterDiscount(discount: _controller.text));
                      },
                      child: state.isDiscountLoading
                          ? const CircularProgressIndicator()
                          : const Text('ثبت کد تخفیف'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'تخفیف: ${state.discount.toString().toPersianDigit().seRagham()} ریال',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
