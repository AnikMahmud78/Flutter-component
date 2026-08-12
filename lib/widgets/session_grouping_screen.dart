import 'package:flutter/material.dart';
import '../models/app_session_group_model.dart';
import '../services/sdk_initialization_service.dart';

class SessionGroupingScreen extends StatefulWidget {
  const SessionGroupingScreen({super.key});

  @override
  State<SessionGroupingScreen> createState() => _SessionGroupingScreenState();
}

class _SessionGroupingScreenState extends State<SessionGroupingScreen> {
  final TextEditingController _userController = TextEditingController(
    text: 'ANIK-OPERATOR-2026',
  );

  AppSessionGroupModel? _sessionData;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _triggerSdkInit();
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  void _triggerSdkInit() async {
    setState(() {
      _isInitializing = true;
    });

    final screenSize =
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
    final pixelRatio =
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    final width = (screenSize.width / pixelRatio).round();
    final height = (screenSize.height / pixelRatio).round();

    final result = await SdkInitializationService.initializeSdk(
      userIdentifier: _userController.text,
      screenResolution: '${width}x${height}dp',
    );

    if (mounted) {
      setState(() {
        _sessionData = result;
        _isInitializing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Session Grouping SDK'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: SingleChildScrollView(
        // REQUIREMENT: 16px Grid Margins on mobile viewports
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Single-Column Card Container
            Card.filled(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.hub_rounded,
                      color: Colors.indigo.shade800,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SDK Session Grouping Engine',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Binds telemetry metrics across background and foreground states.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'SDK Client Configuration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // INPUT FIELD: Operator Identifier (* mandatory red asterisk)
            _buildMandatoryLabel('Operator / User Identifier'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _userController,
              decoration: const InputDecoration(
                hintText: 'Enter operator ID',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ), // >=48px Touch Target
              ),
            ),

            const SizedBox(height: 20),

            // RE-INITIALIZE BUTTON (>=48px touch target height)
            SizedBox(
              width: double.infinity,
              height: 48, // REQUIREMENT: >=48px Touch Target
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isInitializing ? null : _triggerSdkInit,
                icon: _isInitializing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.sync_rounded),
                label: Text(
                  _isInitializing
                      ? 'Binding Group ID...'
                      : 'Re-Initialize SDK Session',
                ),
              ),
            ),

            const SizedBox(height: 24),

            // TELEMETRY SUMMARY DISPLAY CARD
            if (_sessionData != null) ...[
              const Text(
                'Initialized App Session Grouping Telemetry',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      _buildDataRow(
                        'App Session Grouping ID',
                        _sessionData!.sessionGroupingId,
                        isHighlight: true,
                      ),
                      const Divider(),
                      _buildDataRow(
                        'Mobile Platform',
                        _sessionData!.mobilePlatform,
                      ),
                      const Divider(),
                      _buildDataRow('OS Version', _sessionData!.osVersion),
                      const Divider(),
                      _buildDataRow('Device Type', _sessionData!.deviceType),
                      const Divider(),
                      _buildDataRow(
                        'Screen Dimensions',
                        _sessionData!.screenDimensions,
                      ),
                      const Divider(),
                      _buildDataRow(
                        'Mobile Configuration',
                        _sessionData!.mobileConfiguration,
                      ),
                      const Divider(),
                      _buildDataRow(
                        'Initialization Timestamp',
                        _sessionData!.timestamp.substring(11, 19),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // REQUIREMENT: Mark mandatory fields with a red asterisk (*)
  Widget _buildMandatoryLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        const SizedBox(width: 4),
        const Text(
          '*',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDataRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Colors.indigo.shade800 : Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
