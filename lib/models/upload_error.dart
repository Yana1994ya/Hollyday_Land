class UploadError implements Exception {
  final int status;
  final String cause;

  UploadError(this.status, this.cause);
}
