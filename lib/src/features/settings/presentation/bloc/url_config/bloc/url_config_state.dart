part of 'url_config_bloc.dart';

class UrlConfigState {
  final TextEditingController baseUrlController;
  final List<String> baseUrls;
  final List<String> headers;
  final int currUrlIndex;
  final bool isProduction;

  UrlConfigState({
    required this.baseUrlController,
    required this.baseUrls,
    required this.headers,
    required this.currUrlIndex,
    required this.isProduction,
  });

  UrlConfigState copyWith({
    TextEditingController? baseUrlController,
    TextEditingController? anonKeyController,
    List<String>? baseUrls,
    List<String>? anonKeys,
    List<String>? headers,
    int? currUrlIndex,
    bool? isProduction,
  }) {
    return UrlConfigState(
      baseUrlController: baseUrlController ?? this.baseUrlController,
      baseUrls: baseUrls ?? this.baseUrls,
      headers: headers ?? this.headers,
      currUrlIndex: currUrlIndex ?? this.currUrlIndex,
      isProduction: isProduction ?? this.isProduction,
    );
  }
}
