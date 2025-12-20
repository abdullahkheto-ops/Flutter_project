class Reservation {
  String? reservationId;
  String? houseId;
  String? CustomerId;
  ReservationStatus? status;
  //Date startTime;
  //Date endTime;
  PaymentStatus? paymentStatus;
  int? guestNum;
  int? childrenNum;
  int? petNum;
  double? totalPrice;

}

enum PaymentStatus { cash, PayPal }

enum ReservationStatus { confirmed, unaccepeted }
