class SingleLocationModel {
  List<Schedule>? schedule;
  int? error;

  // SingleLocationModel();
  SingleLocationModel({ this.schedule});

  SingleLocationModel.fromJson(Map<String, dynamic> json) {
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(new Schedule.fromJson(v));
      });
    }
  }

  SingleLocationModel.withError(int e) {
    error = e;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  String? dayOfWeek;
  List<Shutdown>? shutdown;

  Schedule({this.dayOfWeek, this.shutdown});

  Schedule.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
    if (json['shutdown'] != null) {
      shutdown = <Shutdown>[];
      json['shutdown'].forEach((v) {
        shutdown!.add(new Shutdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOfWeek'] = this.dayOfWeek;
    if (this.shutdown != null) {
      data['shutdown'] = this.shutdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shutdown {
  int? order;
  int? shutdownType;
  String? range;
  String? quantity;

  Shutdown({this.order, this.shutdownType, this.range, this.quantity});

  Shutdown.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    shutdownType = json['shutdownType'];
    range = json['range'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['shutdownType'] = this.shutdownType;
    data['range'] = this.range;
    data['quantity'] = this.quantity;
    return data;
  }
}
