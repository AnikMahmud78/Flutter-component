import 'dart:async';
import 'package:flutter/material.dart';
import '../models/invoice_ocr_attributes.dart';

class OcrEnrollmentScreen extends StatefulWidget {
  const OcrEnrollmentScreen({super.key});

  @override
  State<OcrEnrollmentScreen> createState() => _OcrEnrollmentScreenState();
}

class _OcrEnrollmentScreenState extends State<OcrEnrollmentScreen> {
  late Timer _timer;
  int _secondsRemaining = 10; // Set to 10s to demonstrate deadline lockout
  bool _isLockedOut = false;

  InvoiceOcrAttributes _ocrAttributes = InvoiceOcrAttributes(
    vendorName: 'Acme Logistics Inc.',
    billDate: '2026-08-11',
    baseAmount: 2450.00,
    taxId: '', // Intentionally missing to demonstrate error indicators
  );

  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        setState(() {
          _isLockedOut = true; // Hard system lockout upon expiration
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Color _getBannerColor() {
    if (_secondsRemaining > 6) return Colors.indigo.shade800;
    if (_secondsRemaining > 3) return Colors.orange.shade800;
    return Colors.red.shade800;
  }

  String _formatTimeRemaining() {
    int mins = _secondsRemaining ~/ 60;
    int secs = _secondsRemaining % 60;
    return '${mins.toString().padLeft(2, '0')}m ${secs.toString().padLeft(2, '0')}s left';
  }

  void _simulateCameraOcrScan() {
    if (_isLockedOut) return;

    setState(() {
      _isScanning = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _ocrAttributes = InvoiceOcrAttributes(
            vendorName: 'Global Corp Systems',
            billDate: '2026-08-11',
            baseAmount: 5120.50,
            taxId: 'TAX-99812-X', // Fully populated
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Ingestion & Enrollment'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: Column(
        children: [
          // Persistent Material Banner with Color Shifts
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: _isLockedOut ? Colors.grey.shade900 : _getBannerColor(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(
                  _isLockedOut ? Icons.lock : Icons.timer,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isLockedOut
                        ? 'Enrollment Period Closed • System Locked'
                        : 'Enrollment Window Active: ${_formatTimeRemaining()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (!_isLockedOut)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Live Sync',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
          ),

          // Main View / Lockout Screen
          Expanded(
            child: _isLockedOut
                ? _buildPadlockReadonlyScreen()
                : _buildActiveIngestionForm(),
          ),
        ],
      ),

      // Material FAB Camera Input
      floatingActionButton: _isLockedOut
          ? null
          : FloatingActionButton.extended(
              backgroundColor: Colors.indigo.shade800,
              foregroundColor: Colors.white,
              onPressed: _simulateCameraOcrScan,
              icon: _isScanning
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.camera_alt_rounded),
              label: Text(
                _isScanning ? 'Extracting OCR...' : 'Capture Invoice',
              ),
            ),
    );
  }

  Widget _buildActiveIngestionForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Receipt Preview (Pinch to Zoom)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 180,
              width: double.infinity,
              color: Colors.blueGrey.shade900,
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.blueGrey.shade800,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description, color: Colors.white70, size: 40),
                      SizedBox(height: 6),
                      Text(
                        'SUPPLIER INVOICE #99812',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Smart zoom active • Pinch to inspect fine print',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Extracted Attribute Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSummaryChip(
                label: 'Vendor',
                value: _ocrAttributes.vendorName,
                isMissing: _ocrAttributes.isVendorMissing,
              ),
              _buildSummaryChip(
                label: 'Bill Date',
                value: _ocrAttributes.billDate,
                isMissing: _ocrAttributes.isDateMissing,
              ),
              _buildSummaryChip(
                label: 'Base Amount',
                value:
                    _ocrAttributes.baseAmount != null &&
                        _ocrAttributes.baseAmount! > 0
                    ? '\$${_ocrAttributes.baseAmount!.toStringAsFixed(2)}'
                    : null,
                isMissing: _ocrAttributes.isAmountMissing,
              ),
              _buildSummaryChip(
                label: 'Tax ID',
                value: _ocrAttributes.taxId,
                isMissing: _ocrAttributes.isTaxIdMissing,
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildOcrInputField(
            label: 'Vendor Name',
            value: _ocrAttributes.vendorName ?? '',
            isMissing: _ocrAttributes.isVendorMissing,
            errorMsg: 'Vendor Name attribute required.',
          ),
          const SizedBox(height: 12),

          _buildOcrInputField(
            label: 'Bill Date',
            value: _ocrAttributes.billDate ?? '',
            isMissing: _ocrAttributes.isDateMissing,
            errorMsg: 'Bill Date attribute required.',
          ),
          const SizedBox(height: 12),

          _buildOcrInputField(
            label: 'Base Amount (\$)',
            value:
                _ocrAttributes.baseAmount != null &&
                    _ocrAttributes.baseAmount! > 0
                ? _ocrAttributes.baseAmount.toString()
                : '',
            isMissing: _ocrAttributes.isAmountMissing,
            errorMsg: 'Base Amount attribute missing or invalid.',
          ),
          const SizedBox(height: 12),

          _buildOcrInputField(
            label: 'Tax ID',
            value: _ocrAttributes.taxId ?? '',
            isMissing: _ocrAttributes.isTaxIdMissing,
            errorMsg: 'Tax ID attribute missing. Ingestion gate blocked.',
          ),
        ],
      ),
    );
  }

  Widget _buildPadlockReadonlyScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_clock,
                size: 64,
                color: Colors.red.shade800,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'System Access Locked',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'The enrollment window timestamp has passed. Database write-access is physically revoked to prevent policy chasing.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _secondsRemaining = 10;
                  _isLockedOut = false;
                  _startCountdownTimer();
                });
              },
              child: const Text('Reset Demo Window'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryChip({
    required String label,
    required String? value,
    required bool isMissing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isMissing ? Colors.red.shade50 : Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isMissing ? Colors.red.shade300 : Colors.indigo.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMissing ? Icons.warning_amber_rounded : Icons.check_circle,
            size: 14,
            color: isMissing ? Colors.red.shade800 : Colors.indigo.shade800,
          ),
          const SizedBox(width: 6),
          Text(
            '$label: ${isMissing ? 'MISSING' : value}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isMissing ? Colors.red.shade900 : Colors.indigo.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOcrInputField({
    required String label,
    required String value,
    required bool isMissing,
    required String errorMsg,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: value,
          key: Key('$label-$value'),
          readOnly: _isLockedOut,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isMissing ? Colors.red.shade700 : Colors.grey.shade400,
                width: isMissing ? 1.5 : 1.0,
              ),
            ),
            suffixIcon: Icon(
              isMissing ? Icons.error : Icons.verified,
              color: isMissing ? Colors.red.shade700 : Colors.green,
            ),
          ),
        ),
        if (isMissing)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              errorMsg,
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
      ],
    );
  }
}
