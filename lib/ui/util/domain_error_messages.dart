import 'package:vitrine/domain/error/domain_error.dart';

extension DomainErrorMessages on DomainError {
  String message() {
    switch (this) {
      case DomainError.unexpected:
        return "Um erro inesperado aconteceu. Tente novamente mais tarde!";
      case DomainError.unauthorized:
        return "Acesso não autorizado.";
      case DomainError.invalidCredential:
        return "Credenciais inválidas.";
      case DomainError.userDisabled:
        return "Usuário desabilitado.";
      case DomainError.emailAlreadyInUse:
        return "Este e-mail já está sendo utilizado.";
      case DomainError.invalidEmail:
        return "Este e-mail é inválido.";
      case DomainError.wrongPassword:
        return "Senha incorreta.";
      case DomainError.userNotFound:
        return "Esta conta não existe.";
      case DomainError.networkError:
        return "Falha na rede. Verifique sua conexão e tente novamente.";
    }
  }
}
