enum MediaType { photo, video }

class Media {
  Media({
    required this.blurHash,
    required this.url,
    required this.altText,
    required this.mediaType,
  });

  String get id => blurHash;

  final String blurHash;
  final String url;
  final String altText;
  final MediaType mediaType;
}
