class RequestHeaderEntry {
  String description;
  List<String> praises;
  List<String> requests;
  String details;

  RequestHeaderEntry({
    this.details,
    this.description,
    this.praises = const [],
    this.requests = const [],
  });

  RequestHeaderEntry.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        praises = json['praises'],
        requests = json['requests'],
        details = json['details'];

  Map<String, dynamic> toJson() {
    List<String> convertedPraises;
    List<String> convertedRequests;
    praises.forEach((praise) {
      convertedPraises.add(praise);
    });
    requests.forEach((request) {
      convertedRequests.add(request);
    });

    return {
      'details': details,
      'description': description,
      'praises': convertedPraises,
      'requests': convertedRequests,
    };
  }
}
