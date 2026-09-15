// CUITC-012-A10 — Corporate Tax Liability Dashboard with Lazy-Loading Viewport Cards.
// Responsive M3 dashboard skeleton with swipeable regional views, stream-bound summary cards and viewport-only lazy loading.
import 'dart:async';
import 'package:flutter/material.dart';

/// Window size classes aligned to Material Design 3 canonical breakpoints.
/// Floor: 0-599dp = Compact | Optimal: 600-839dp = Medium | Ceiling: >=840dp = Expanded.
enum Cuitc012A10WindowClass { compact, medium, expanded }

Cuitc012A10WindowClass cuitc012A10WindowClassForWidth(double width) {
  if (width >= 840) return Cuitc012A10WindowClass.expanded;
  if (width >= 600) return Cuitc012A10WindowClass.medium;
  return Cuitc012A10WindowClass.compact;
}

/// Atomic-level region performance model (mirrors Firebase node shape).
@immutable
class Cuitc012A10RegionPerformance {
  final String regionId;
  final String regionName;
  final double liabilityTotal;
  final double changePct;
  final List<double> trend;
  const Cuitc012A10RegionPerformance({
    required this.regionId,
    required this.regionName,
    required this.liabilityTotal,
    required this.changePct,
    required this.trend,
  });
}

/// Sample stream data for test devices / Storybook.
List<Cuitc012A10RegionPerformance> cuitc012A10SampleRegions() => const [
  Cuitc012A10RegionPerformance(regionId: 'na', regionName: 'North America', liabilityTotal: 4825000, changePct: 2.4, trend: [3, 5, 4, 7, 6, 9, 8]),
  Cuitc012A10RegionPerformance(regionId: 'emea', regionName: 'EMEA', liabilityTotal: 3910000, changePct: -1.2, trend: [8, 7, 6, 6, 5, 4, 4]),
  Cuitc012A10RegionPerformance(regionId: 'apac', regionName: 'APAC', liabilityTotal: 2750000, changePct: 4.8, trend: [2, 3, 5, 5, 7, 8, 10]),
];

/// CUITC-012-A10 dashboard component.
///
/// - 8dp grid, M3 cards + color tokens, >=48x48 touch targets.
/// - Lazy-loading: [PageView.builder] + [GridView.builder] render only visible viewport cards.
/// - Stream-bound: connects to Firebase/PubSub stream via [regionsStream].
/// - Fallback states on error/empty/offline instead of breaking.
class CorporateTaxDashboardCuitc012A10 extends StatefulWidget {
  final Stream<List<Cuitc012A10RegionPerformance>>? regionsStream;
  final List<Cuitc012A10RegionPerformance>? initialRegions;
  final ValueChanged<int>? onRegionChanged;
  const CorporateTaxDashboardCuitc012A10({super.key, this.regionsStream, this.initialRegions, this.onRegionChanged});

  @override
  State<CorporateTaxDashboardCuitc012A10> createState() => _CorporateTaxDashboardCuitc012A10State();
}

class _CorporateTaxDashboardCuitc012A10State extends State<CorporateTaxDashboardCuitc012A10> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index, int count) {
    if (index < 0 || index >= count) return;
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final fallback = widget.initialRegions ?? cuitc012A10SampleRegions();
    if (widget.regionsStream == null) {
      return _DashboardBody(regions: fallback, currentIndex: _currentIndex, pageController: _pageController, onPageChanged: _onPageChanged, onDotTap: _goTo);
    }
    return StreamBuilder<List<Cuitc012A10RegionPerformance>>(
      stream: widget.regionsStream,
      initialData: fallback,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _FallbackCard(message: 'Dashboard offline. Showing last known values.', regions: fallback, pageController: _pageController, currentIndex: _currentIndex, onPageChanged: _onPageChanged, onDotTap: _goTo);
        }
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          return const _SkeletonBody();
        }
        final regions = (snapshot.data == null || snapshot.data!.isEmpty) ? fallback : snapshot.data!;
        if (snapshot.data != null && snapshot.data!.isEmpty) {
          return _EmptyBody(onRetry: () => setState(() {}));
        }
        return _DashboardBody(regions: regions, currentIndex: _currentIndex.clamp(0, regions.length - 1), pageController: _pageController, onPageChanged: _onPageChanged, onDotTap: _goTo);
      },
    );
  }

  void _onPageChanged(int i) {
    setState(() => _currentIndex = i);
    widget.onRegionChanged?.call(i);
  }
}

class _DashboardBody extends StatelessWidget {
  final List<Cuitc012A10RegionPerformance> regions;
  final int currentIndex;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final void Function(int, int) onDotTap;
  const _DashboardBody({required this.regions, required this.currentIndex, required this.pageController, required this.onPageChanged, required this.onDotTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final wc = cuitc012A10WindowClassForWidth(constraints.maxWidth);
        final int crossAxisCount = switch (wc) { Cuitc012A10WindowClass.compact => 1, Cuitc012A10WindowClass.medium => 2, Cuitc012A10WindowClass.expanded => 3 };
        final double hPad = wc == Cuitc012A10WindowClass.compact ? 8 : 16;
        return Padding(
          padding: EdgeInsets.all(hPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeaderCard(count: regions.length, current: currentIndex, colorScheme: cs),
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: regions.length,
                  onPageChanged: onPageChanged,
                  allowImplicitScrolling: false,
                  itemBuilder: (context, pageIndex) {
                    final region = regions[pageIndex];
                    return RepaintBoundary(
                      child: _RegionPage(region: region, crossAxisCount: crossAxisCount),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              _PageDots(count: regions.length, current: currentIndex, onTap: (i) => onDotTap(i, regions.length)),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final int count;
  final int current;
  final ColorScheme colorScheme;
  const _HeaderCard({required this.count, required this.current, required this.colorScheme});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorScheme.surfaceContainerHigh,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Corporate tax liability', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('Real-time trends • Region ${current + 1} of $count', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: FilledButton.tonal(onPressed: () {}, child: const Text('Export')),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegionPage extends StatelessWidget {
  final Cuitc012A10RegionPerformance region;
  final int crossAxisCount;
  const _RegionPage({required this.region, required this.crossAxisCount});

  List<_CardDatum> _cards() => [
    _CardDatum('Total liability', '\$${(region.liabilityTotal / 1000000).toStringAsFixed(2)}M', region.changePct),
    _CardDatum('Forecast (30d)', '\$${(region.liabilityTotal * 1.03 / 1000000).toStringAsFixed(2)}M', 3.0),
    _CardDatum('Effective rate', '21.4%', 0.4),
    _CardDatum('Filings due', '12', 0),
    _CardDatum('Risk flags', '2', -0.5),
    _CardDatum('YoY delta', '${region.changePct.toStringAsFixed(1)}%', region.changePct),
  ];

  @override
  Widget build(BuildContext context) {
    final cards = _cards();
    return Column(
      children: [
        _TrendCard(region: region),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 128),
            itemCount: cards.length,
            cacheExtent: 200,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true,
            addSemanticIndexes: false,
            findChildIndexCallback: (key) {
              final v = (key as ValueKey).value;
              final i = cards.indexWhere((e) => e.title == v);
              return i < 0 ? null : i;
            },
            itemBuilder: (context, i) {
              final c = cards[i];
              return RepaintBoundary(
                child: _SummaryCard(key: ValueKey(c.title), datum: c),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CardDatum {
  final String title;
  final String value;
  final double delta;
  const _CardDatum(this.title, this.value, this.delta);
}

class _TrendCard extends StatelessWidget {
  final Cuitc012A10RegionPerformance region;
  const _TrendCard({required this.region});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final up = region.changePct >= 0;
    return Card(
      margin: EdgeInsets.zero,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(region.regionName, style: Theme.of(context).textTheme.titleSmall)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: (up ? cs.primary : cs.error).withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
                  child: Text('${up ? '+' : ''}${region.changePct.toStringAsFixed(1)}%', style: TextStyle(color: up ? cs.primary : cs.error)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(height: 64, child: CustomPaint(painter: _TrendPainter(points: region.trend, color: cs.primary), size: Size.infinite)),
          ],
        ),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  final List<double> points;
  final Color color;
  const _TrendPainter({required this.points, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;
    final max = points.reduce((a, b) => a > b ? a : b);
    final min = points.reduce((a, b) => a < b ? a : b);
    final span = (max - min) == 0 ? 1 : (max - min);
    final dx = points.length == 1 ? 0 : size.width / (points.length - 1);
    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = dx * i;
      final y = size.height - ((points[i] - min) / span) * size.height;
      if (i == 0) { path.moveTo(x, y); } else { path.lineTo(x, y); }
    }
    canvas.drawPath(path, Paint()..color = color..strokeWidth = 2.5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
  }
  @override
  bool shouldRepaint(covariant _TrendPainter old) => old.points != points || old.color != color;
}

class _SummaryCard extends StatelessWidget {
  final _CardDatum datum;
  const _SummaryCard({super.key, required this.datum});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: cs.surfaceContainerHighest,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(datum.title, style: Theme.of(context).textTheme.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(datum.value, style: Theme.of(context).textTheme.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  final int count;
  final int current;
  final ValueChanged<int> onTap;
  const _PageDots({required this.count, required this.current, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final selected = i == current;
        return Semantics(
          button: true,
          selected: selected,
          label: 'Region ${i + 1}',
          child: GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selected ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outlineVariant, borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _SkeletonBody extends StatelessWidget {
  const _SkeletonBody();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(4, (i) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Container(height: 96, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6), borderRadius: BorderRadius.circular(12))))),
      ),
    );
  }
}

class _EmptyBody extends StatelessWidget {
  final VoidCallback onRetry;
  const _EmptyBody({required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 48),
            const SizedBox(height: 8),
            const Text('No tax regions yet'),
            const SizedBox(height: 8),
            ConstrainedBox(constraints: const BoxConstraints(minWidth: 48, minHeight: 48), child: FilledButton(onPressed: onRetry, child: const Text('Retry'))),
          ],
        ),
      ),
    );
  }
}

class _FallbackCard extends StatelessWidget {
  final String message;
  final List<Cuitc012A10RegionPerformance> regions;
  final PageController pageController;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final void Function(int, int) onDotTap;
  const _FallbackCard({required this.message, required this.regions, required this.pageController, required this.currentIndex, required this.onPageChanged, required this.onDotTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.fromLTRB(8, 8, 8, 0), child: Card(child: ListTile(leading: const Icon(Icons.cloud_off_outlined), title: Text(message, style: Theme.of(context).textTheme.bodySmall)))),
        Expanded(child: _DashboardBody(regions: regions, currentIndex: currentIndex, pageController: pageController, onPageChanged: onPageChanged, onDotTap: onDotTap)),
      ],
    );
  }
}
