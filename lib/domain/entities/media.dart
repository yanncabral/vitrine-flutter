enum MediaType { photo, video }

class Media {
  Media(this.blurHash, this.url, this.altText, this.mediaType);

  String get id => blurHash;

  final String blurHash;
  final String url;
  final String altText;
  final MediaType mediaType;
}
