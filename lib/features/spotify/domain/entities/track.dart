class Track {
  final String id;
  final String name;
  final String imageUrl; //Inside of album
  final List<String> artistNames;
  final int durationInMilliseconds;

  Track({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.artistNames,
    required this.durationInMilliseconds,
  }); 
}