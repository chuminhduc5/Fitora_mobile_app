part of 'auth_sign_up_form_bloc.dart';

@immutable
abstract class AuthSignUpFormState extends Equatable {
  final SignUpFormData data;

  const AuthSignUpFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthSignUpFormInitialState extends AuthSignUpFormState {
  const AuthSignUpFormInitialState()
      : super(
          const SignUpFormData(
            email: "",
            username: '',
            password: '',
            confirmPassword: '',
            isValid: false,
          ),
        );
}

class AuthSignUpFormInputDataState extends AuthSignUpFormState {
  final SignUpFormInputData inputData;

  AuthSignUpFormInputDataState(this.inputData)
      : super(
          SignUpFormData(
            email: inputData.inputEmail,
            username: inputData.inputUsername,
            password: inputData.inputPassword,
            confirmPassword: inputData.inputConfirmPassword,
            isValid: inputData.inputValid,
          ),
        );

  @override
  List<Object?> get props => [inputData];
}
