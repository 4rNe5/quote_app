class Quote {
  final String author;
  final String authorProfile;
  final String message;

  Quote({
    required this.author,
    required this.authorProfile,
    required this.message,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      author: json['author'] ?? '',
      authorProfile: json['authorProfile'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
