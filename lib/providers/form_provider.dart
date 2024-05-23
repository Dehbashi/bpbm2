import 'package:bpbm2/common/custom_error_messenger.dart';
import 'package:bpbm2/data/repo/form_repository.dart';
import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  Future<void> sendContactForm({
    required BuildContext context,
    required String cellNumber,
    required String name,
    required String subject,
    required String text,
  }) async {
    try {
      await formRepository.sendContactForm(
        name: name,
        cellNumber: cellNumber,
        subject: subject,
        text: text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ثبت پیام با موفقیت انجام شد.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      notifyListeners();
    } catch (e) {
      customErrorMessenger(
        context: context,
        message: 'خطای نامشخص',
      );
      notifyListeners();
    }
  }

  Future<void> sendTechnicianForm({
    required BuildContext context,
    required String cellNumber,
    required String firstName,
    required String lastName,
    required String nationalId,
    required String text,
  }) async {
    try {
      await formRepository.sendTechnicianForm(
        firstName: firstName,
        lastName: lastName,
        cellNumber: cellNumber,
        text: text,
        nationalId: nationalId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'درخواست شما با موفقیت ثبت شد.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
      notifyListeners();
    } catch (e) {
      customErrorMessenger(
        context: context,
        message: 'خطای نامشخص',
      );
      notifyListeners();
    }
  }
}
