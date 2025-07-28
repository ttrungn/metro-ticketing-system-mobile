class DeepLinkRoute {
  final String scheme;
  final String host;
  final String path;
  final String routeName;

  const DeepLinkRoute({
    required this.scheme,
    required this.host,
    required this.path,
    required this.routeName,
  });

  bool matches(Uri uri) {
    return uri.scheme == scheme && uri.host == host && uri.path == path;
  }
}
