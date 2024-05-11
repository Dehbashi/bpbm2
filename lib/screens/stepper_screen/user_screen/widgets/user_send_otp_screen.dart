import 'package:bpbm2/blocs/user_bloc/user_bloc.dart';
import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/common/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class UserSendOtpScreen extends StatefulWidget {
  final UserSendSmsSuccess state;
  const UserSendOtpScreen({super.key, required this.state});

  @override
  State<UserSendOtpScreen> createState() => _UserSendOtpScreenState();
}

class _UserSendOtpScreenState extends State<UserSendOtpScreen> {
  @override
  Widget build(BuildContext context) {
    String otpCode = '';
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user,
              size: 150,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'کد فعالسازی که پیامک شده به شماره',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.state.cellNumber,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'رو وارد کنید',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: OtpTextField(
                numberOfFields: 5,
                borderRadius: BorderRadius.circular(10),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
                fieldWidth: 50,
                filled: true,
                fillColor: const Color(0xff989898),
                showFieldAsBox: true,
                onSubmit: (value) {
                  otpCode = value;
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
              isLoading: widget.state.isLoading,
              buttonWidth: MediaQuery.of(context).size.width * 0.7,
              onPressed: () {
                if (otpCode != '' || otpCode.isNotEmpty) {
                  BlocProvider.of<UserBloc>(context).add(
                    SendOtp(otpCode: otpCode),
                  );
                } else {
                  customErrorMessenger(
                    context: context,
                    message: 'کد وارد شده اشتباه است',
                  );
                }
              },
              text: 'اعتبار سنجی کد فعالسازی',
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'ارسال مجدد کد فعالسازی',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(ChangeCellNumber());
              },
              child: Text(
                'تغییر شماره تلفن',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
