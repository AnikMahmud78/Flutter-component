import 'dart:convert';

class AccessPolicyModel {
  final String tokenId;
  final String clientIp;
  final bool isCorporateEgress;
  final double complianceRate;
  final String status;
  final DateTime timestamp;

  AccessPolicyModel({
    required this.tokenId,
    required this.clientIp,
    required this.isCorporateEgress,
    required this.complianceRate,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'token_id': tokenId,
        'client_ip': clientIp,
        'is_corporate_egress': isCorporateEgress,
        'compliance_rate': complianceRate,
        'status': status,
        'timestamp': timestamp.toIso8601String(),
      };

  factory AccessPolicyModel.fromJson(Map<String, dynamic> json) => AccessPolicyModel(
        tokenId: json['token_id'] as String,
        clientIp: json['client_ip'] as String,
        isCorporateEgress: json['is_corporate_egress'] as bool,
        complianceRate: (json['compliance_rate'] as num).toDouble(),
        status: json['status'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}
