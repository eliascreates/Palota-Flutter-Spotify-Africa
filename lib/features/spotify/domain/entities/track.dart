class Track {
  final String id;
  final String name;
  final String imageUrl;
  final List<Map<String, String>> artistMap;
  final int durationInMilliseconds;

  Track({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.artistMap,
    required this.durationInMilliseconds,
  }); 
}
