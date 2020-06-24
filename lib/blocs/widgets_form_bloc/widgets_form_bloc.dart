import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class WidgetsFormBloc extends FormBloc<String, String> {
  final question = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final List anwsers = List.generate(
    3,
    (index) => [
      TextFieldBloc(validators: [
        FieldBlocValidators.required,
      ]),
      SelectFieldBloc(),
    ],
  );

  @override
  void onSubmitting() {
    // TODO: implement onSubmitting
  }
}
