class Artist {
  final String id;
  final String name;
  final String imageUrl;
  final int totalFollowers;
  final List<String> genres;
  final String type;
  
  Artist({
    required this.totalFollowers,
    required this.genres,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.type,
  });
}

