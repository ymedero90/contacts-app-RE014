enum AuthStatus {
  unknown,
  checkingUserSession,
  authenticated,
  unauthenticated,
  allowBiometrics,
  checkBiometrics,
  biometricNotSupport,
  biometricSupported,
  biometricAllowed,
  biometricNotAllowed,
  biometricSuccess,
  biometricFail,
  sessionActive,
  sessionInactive,
  submitting,
  loginWithoutBio,
}
