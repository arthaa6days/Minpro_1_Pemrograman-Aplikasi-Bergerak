class Ticket {
  final int? id;
  final String concertName;
  final String artist;
  final String date;
  final String venue;
  final String price;

  Ticket({
    this.id,
    required this.concertName,
    required this.artist,
    required this.date,
    required this.venue,
    required this.price,
  });

  Ticket copyWith({
    int? id,
    String? concertName,
    String? artist,
    String? date,
    String? venue,
    String? price,
  }) {
    return Ticket(
      id: id ?? this.id,
      concertName: concertName ?? this.concertName,
      artist: artist ?? this.artist,
      date: date ?? this.date,
      venue: venue ?? this.venue,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nama_konser': concertName,
      'nama_artis': artist,
      'tanggal_konser': date,
      'lokasi_venue': venue,
      'harga': price,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as int?,
      concertName: json['nama_konser'] ?? '',
      artist: json['nama_artis'] ?? '',
      date: json['tanggal_konser'] ?? '',
      venue: json['lokasi_venue'] ?? '',
      price: json['harga']?.toString() ?? '',
    );
  }
}
