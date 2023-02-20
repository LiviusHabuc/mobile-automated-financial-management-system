import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: "./constants.env")
abstract class Env {

  @EnviedField(varName: "REVO_SANDBOX_URL")
  static const revoSandboxURL = _Env.revoSandboxURL;

  @EnviedField(varName: "REVO_SANDBOX_API_KEY", obfuscate: true)
  static final revoSandboxAPIKey = _Env.revoSandboxAPIKey;

  @EnviedField(varName: "IBKR_CLIENT_PORTAL_URL")
  static const ibkrClientPortalURL = _Env.ibkrClientPortalURL;
}
