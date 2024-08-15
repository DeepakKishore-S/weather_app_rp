class NewsState {
  final bool isLoading;
  final List<dynamic>? newsData;
  final String? errorMessage;

  NewsState({
    required this.isLoading,
    this.newsData,
    this.errorMessage,
  });

  factory NewsState.initial() {
    return NewsState(isLoading: false);
  }

  NewsState copyWith({
    bool? isLoading,
    List<dynamic>? newsData,
    String? errorMessage,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      newsData: newsData ?? this.newsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
