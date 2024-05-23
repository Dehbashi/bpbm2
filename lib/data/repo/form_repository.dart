import 'package:bpbm2/data/models/form_model/contact_form_model.dart';
import 'package:bpbm2/data/source/form_data_source.dart';

final formRepository = FormRepository(dataSource: FormRemoteDataSource());

abstract class IFormRepository {
  Future<ContactFormModel> sendContactForm({
    required String name,
    required String cellNumber,
    required String subject,
    required String text,
  });
  Future<ContactFormModel> sendTechnicianForm({
    required String firstName,
    required String lastName,
    required String cellNumber,
    required String text,
    required String nationalId,
  });
}

class FormRepository implements IFormRepository {
  final IFormDataSource dataSource;

  const FormRepository({required this.dataSource});

  @override
  Future<ContactFormModel> sendContactForm({
    required String name,
    required String cellNumber,
    required String subject,
    required String text,
  }) async {
    return dataSource.sendContactForm(
      name: name,
      cellNumber: cellNumber,
      subject: subject,
      text: text,
    );
  }

  @override
  Future<ContactFormModel> sendTechnicianForm({
    required String firstName,
    required String lastName,
    required String cellNumber,
    required String text,
    required String nationalId,
  }) async {
    return dataSource.sendTechnicianForm(
      firstName: firstName,
      lastName: lastName,
      cellNumber: cellNumber,
      text: text,
      nationalId: nationalId,
    );
  }
}
