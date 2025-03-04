part of 'auth_sign_in_form_bloc.dart';

@immutable
abstract class AuthSignInFormState extends Equatable {
  final SignInFormData data;

  const AuthSignInFormState(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthSignInFormInitialState extends AuthSignInFormState {
  const AuthSignInFormInitialState()
      : super(
          const SignInFormData(
            email: "",
            password: "",
            isValid: false,
          ),
        );
}

class AuthSignInFormDataState extends AuthSignInFormState {
  final SignInFormInputData inputData;

  AuthSignInFormDataState(this.inputData)
      : super(
          SignInFormData(
            email: inputData.inputEmail,
            password: inputData.inputPassword,
            isValid: inputData.inputIsValid,
          ),
        );

  @override
  List<Object?> get props => [inputData];
}
