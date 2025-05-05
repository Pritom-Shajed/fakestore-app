enum ApiClientMethod {
  get,
  post,
  put,
  patch,
  delete,
}

extension ApiClientMethodExt on ApiClientMethod {
  String get value {
    switch (this) {
      case ApiClientMethod.get:
        return 'GET';
      case ApiClientMethod.post:
        return 'POST';
      case ApiClientMethod.put:
        return 'PUT';
      case ApiClientMethod.patch:
        return 'PATCH';
      case ApiClientMethod.delete:
        return 'DELETE';
    }
  }
}