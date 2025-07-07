
import 'package:basic_billing_application/core/result.dart';
import 'package:basic_billing_application/domain/models/login_request.dart';
import 'package:basic_billing_application/domain/repositories/auth_repository.dart';
import 'package:basic_billing_application/ui/features/auth/viewModels/auth_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

class StubAuthRepository implements AuthRepository {
  bool shouldFail;
  StubAuthRepository({this.shouldFail = false});

  @override
  Future<Result<void>> loginUser(LoginRequest request) async {
    if(shouldFail)
    {
      return Failure<void>('Error message.');
    }
    return Success<void>(null);
  }
}
void main() {
  late StubAuthRepository stubRepo;
  late AuthViewModel viewModel;


  test('Login success returns true and sets no error message', () async {
    //Arrange
    stubRepo = StubAuthRepository(shouldFail: false);
    viewModel = AuthViewModel();
    viewModel.updateRepository(stubRepo);
    
    //Act 
    final result = await viewModel.login('user', 'pass');

    //Assert
    expect(result, true);
    expect(viewModel.errorMessage, isNull);
    expect(viewModel.isLoading, false);
  });

  test('Login failure returns false and sets error message', () async {
    // Arrange
    stubRepo = StubAuthRepository(shouldFail: true);
    viewModel = AuthViewModel();
    viewModel.updateRepository(stubRepo);

    // Act
    final result = await viewModel.login('wrong', 'wrong');

    // Assert
    expect(result, false);
    expect(viewModel.errorMessage, 'Error message.');
    expect(viewModel.isLoading, false);
  });
}