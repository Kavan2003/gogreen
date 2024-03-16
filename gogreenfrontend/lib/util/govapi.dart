class ApiResponse {
  final int created;
  final int updated;
  final String createdDate;
  final String updatedDate;
  final int active;
  final String indexName;
  final String message;
  final String version;
  final String status;
  final int total;
  final int count;
  final String limit;
  final String offset;
  final List<String> field;
  final List<Record> records;

  ApiResponse({
    required this.created,
    required this.updated,
    required this.createdDate,
    required this.updatedDate,
    required this.active,
    required this.indexName,
    required this.message,
    required this.version,
    required this.status,
    required this.total,
    required this.count,
    required this.limit,
    required this.offset,
    required this.field,
    required this.records,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        created: json['created'] as int,
        updated: json['updated'] as int,
        createdDate: json['created_date'] as String,
        updatedDate: json['updated_date'] as String,
        active: json['active'] as int,
        indexName: json['index_name'] as String,
        message: json['message'] as String,
        version: json['version'] as String,
        status: json['status'] as String,
        total: json['total'] as int,
        count: json['count'] as int,
        limit: json['limit'] as String,
        offset: json['offset'] as String,
        field: (json['field'] as List<dynamic>).cast<String>(),
        records: (json['records'] as List<dynamic>)
            .map((e) => Record.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class Record {
  final String country;
  final String state;
  final String city;
  final String station;
  final String lastUpdate;
  final String latitude;
  final String longitude;
  final String pollutantId;
  final String pollutantMin;
  final String pollutantMax;
  final String pollutantAvg;

  Record({
    required this.country,
    required this.state,
    required this.city,
    required this.station,
    required this.lastUpdate,
    required this.latitude,
    required this.longitude,
    required this.pollutantId,
    required this.pollutantMin,
    required this.pollutantMax,
    required this.pollutantAvg,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        country: json['country'] as String,
        state: json['state'] as String,
        city: json['city'] as String,
        station: json['station'] as String,
        lastUpdate: json['last_update'] as String,
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
        pollutantId: json['pollutant_id'] as String,
        pollutantMin: json['pollutant_min'] as String,
        pollutantMax: json['pollutant_max'] as String,
        pollutantAvg: json['pollutant_avg'] as String,
      );
}

class ApiQualityarea {
  final String country;
  final String state;
  final String city;
  final String station;
  final String lastUpdate;
  final String latitude;
  final String longitude;
  final String? pollutant_co;
  final String? pollutant_nh3;
  final String? pollutant_ozone;
  final String? pollutant_pm10;
  final String? pollutant_pm2_5;
  final String? pollutant_so2;
  final String? pollutant_no2;

  ApiQualityarea({
    required this.country,
    required this.state,
    required this.city,
    required this.station,
    required this.lastUpdate,
    required this.latitude,
    required this.longitude,
    required this.pollutant_co,
    required this.pollutant_nh3,
    required this.pollutant_ozone,
    required this.pollutant_pm10,
    required this.pollutant_pm2_5,
    required this.pollutant_so2,
    required this.pollutant_no2,
  });

  ApiQualityarea updatePollutants({
    String? pollutant_co,
    String? pollutant_nh3,
    String? pollutant_ozone,
    String? pollutant_pm10,
    String? pollutant_pm2_5,
    String? pollutant_so2,
    String? pollutant_no2,
  }) {
    return ApiQualityarea(
      country: this.country,
      state: this.state,
      city: this.city,
      station: this.station,
      lastUpdate: this.lastUpdate,
      latitude: this.latitude,
      longitude: this.longitude,
      pollutant_co: pollutant_co ?? this.pollutant_co,
      pollutant_nh3: pollutant_nh3 ?? this.pollutant_nh3,
      pollutant_ozone: pollutant_ozone ?? this.pollutant_ozone,
      pollutant_pm10: pollutant_pm10 ?? this.pollutant_pm10,
      pollutant_pm2_5: pollutant_pm2_5 ?? this.pollutant_pm2_5,
      pollutant_so2: pollutant_so2 ?? this.pollutant_so2,
      pollutant_no2: pollutant_no2 ?? this.pollutant_no2,
    );
  }
}

class AirQuality {
  final String co;
  final String nh3;
  final String ozone;
  final String pm10;
  final String pm2_5;
  final String so2;
  AirQuality({
    required this.co,
    required this.nh3,
    required this.ozone,
    required this.pm10,
    required this.pm2_5,
    required this.so2,
  });

  String get airQuality {
    final thresholds = {
      'CO': {
        'good': '<= 9',
        'moderate': '10 <= x <= 40',
        'bad': '> 40',
      },
      'NH3': {
        'good': '<= 200',
        'moderate': '201 <= x <= 700',
        'bad': '> 700',
      },
      'OZONE': {
        'good': '<= 100',
        'moderate': '101 <= x <= 164',
        'bad': '> 164',
      },
      'PM10': {
        'good': '<= 50',
        'moderate': '51 <= x <= 150',
        'bad': '> 150',
      },
      'PM2.5': {
        'good': '<= 12',
        'moderate': '13 <= x <= 35',
        'bad': '> 35',
      },
      'SO2': {
        'good': '<= 50',
        'moderate': '51 <= x <= 150',
        'bad': '> 150',
      },
    };

    // Check each pollutant against good, moderate, bad thresholds
    final ratings = [
      _getRating(co, thresholds['CO']!),
      _getRating(nh3, thresholds['NH3']!),
      _getRating(ozone, thresholds['OZONE']!),
      _getRating(pm10, thresholds['PM10']!),
      _getRating(pm2_5, thresholds['PM2.5']!),
      _getRating(so2, thresholds['SO2']!),
    ];

    // Get the worst rating (highest severity)
    final worstRating = ratings.reduce((a, b) => a == 'bad' ? a : b);

    return {
      'good': 'green',
      'moderate': 'yellow',
      'bad': 'red',
    }[worstRating]!;
  }

  String _getRating(String value, Map<String, String> thresholds) {
    if (thresholds['good']!.contains(value)) {
      return 'good';
    } else if (thresholds['moderate']!.contains(value)) {
      return 'moderate';
    } else {
      return 'bad';
    }
  }
}
