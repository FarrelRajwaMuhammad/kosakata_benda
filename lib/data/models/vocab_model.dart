class Vocab {
  final int? id;
  final String judul;
  final String category;
  final String image_url;

  Vocab({
    this.id,
    required this.judul,
    required this.category,
    required this.image_url,
  });

  factory Vocab.fromJson(Map<String, dynamic> json) {
    final rawUrl = json['image_url'];
    String fullUrl = '';

    if (rawUrl != null && rawUrl.toString().isNotEmpty) {
      fullUrl = rawUrl.toString().startsWith('http')
          ? rawUrl
          : 'https://sxkykrzzconjmvqidcxc.supabase.co/rest/v1/vocabs$rawUrl';
    }

    return Vocab(
      id: json['id'],
      judul: json['judul'],
      category: json['category'],
      image_url: fullUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'category': category,
      'imageUrl': image_url,
    };
  }
}
