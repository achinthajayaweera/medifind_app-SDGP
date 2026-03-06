import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ── Demo pharmacy data ────────────────────────────────────────────────────────
class _Pharmacy {
  final String name;
  final String location;
  final String distance;
  final double price;
  final int available;
  final int total;
  final String notAvailable;
  final int accepted;
  final int cancelled;
  final double rating;
  final Color brandColor;
  final LatLng latLng;

  const _Pharmacy({
    required this.name,
    required this.location,
    required this.distance,
    required this.price,
    required this.available,
    required this.total,
    required this.notAvailable,
    required this.accepted,
    required this.cancelled,
    required this.rating,
    required this.brandColor,
    required this.latLng,
  });
}

const _pharmacies1km = [
  _Pharmacy(
      name: 'Union Chemists',
      location: 'Narahenpita',
      distance: '1km ahead',
      price: 4600,
      available: 4,
      total: 6,
      notAvailable: 'Lactaid, Simethicone',
      accepted: 56,
      cancelled: 4,
      rating: 4.8,
      brandColor: Color(0xFFD4A017),
      latLng: LatLng(6.9020, 79.8740)),
];

const _pharmacies5km = [
  _Pharmacy(
      name: 'Union Chemists',
      location: 'Narahenpita',
      distance: '1km ahead',
      price: 4600,
      available: 4,
      total: 6,
      notAvailable: 'Lactaid, Simethicone',
      accepted: 56,
      cancelled: 4,
      rating: 4.8,
      brandColor: Color(0xFFD4A017),
      latLng: LatLng(6.9020, 79.8740)),
  _Pharmacy(
      name: 'Healthguard',
      location: 'Colombo 5',
      distance: '1.5km ahead',
      price: 5200,
      available: 5,
      total: 6,
      notAvailable: 'Simethicone',
      accepted: 72,
      cancelled: 2,
      rating: 4.6,
      brandColor: Color(0xFF9B2AA0),
      latLng: LatLng(6.8980, 79.8680)),
  _Pharmacy(
      name: 'Osusala Pharmacy',
      location: 'Borella',
      distance: '3.2km ahead',
      price: 4350,
      available: 5,
      total: 6,
      notAvailable: 'Lactaid',
      accepted: 68,
      cancelled: 3,
      rating: 4.5,
      brandColor: Color(0xFF1565C0),
      latLng: LatLng(6.9150, 79.8760)),
];

const _pharmacies10km = [
  _Pharmacy(
      name: 'Union Chemists',
      location: 'Narahenpita',
      distance: '1km ahead',
      price: 4600,
      available: 4,
      total: 6,
      notAvailable: 'Lactaid, Simethicone',
      accepted: 56,
      cancelled: 4,
      rating: 4.8,
      brandColor: Color(0xFFD4A017),
      latLng: LatLng(6.9020, 79.8740)),
  _Pharmacy(
      name: 'Healthguard',
      location: 'Colombo 5',
      distance: '1.5km ahead',
      price: 5200,
      available: 5,
      total: 6,
      notAvailable: 'Simethicone',
      accepted: 72,
      cancelled: 2,
      rating: 4.6,
      brandColor: Color(0xFF9B2AA0),
      latLng: LatLng(6.8980, 79.8680)),
  _Pharmacy(
      name: 'Osusala Pharmacy',
      location: 'Borella',
      distance: '3.2km ahead',
      price: 4350,
      available: 5,
      total: 6,
      notAvailable: 'Lactaid',
      accepted: 68,
      cancelled: 3,
      rating: 4.5,
      brandColor: Color(0xFF1565C0),
      latLng: LatLng(6.9150, 79.8760)),
  _Pharmacy(
      name: 'Health Link',
      location: 'Maradana',
      distance: '4.5km ahead',
      price: 4900,
      available: 3,
      total: 6,
      notAvailable: 'Lactaid',
      accepted: 61,
      cancelled: 5,
      rating: 4.3,
      brandColor: Color(0xFF00897B),
      latLng: LatLng(6.9270, 79.8650)),
  _Pharmacy(
      name: 'Jeewaka Pharma',
      location: 'Wellawatte',
      distance: '5.8km ahead',
      price: 5100,
      available: 6,
      total: 6,
      notAvailable: '',
      accepted: 80,
      cancelled: 1,
      rating: 4.9,
      brandColor: Color(0xFFE53935),
      latLng: LatLng(6.8780, 79.8640)),
  _Pharmacy(
      name: 'Suncity Pharmacy',
      location: 'Dehiwala',
      distance: '7.1km ahead',
      price: 4750,
      available: 4,
      total: 6,
      notAvailable: 'Simethicone',
      accepted: 65,
      cancelled: 3,
      rating: 4.4,
      brandColor: Color(0xFFF57C00),
      latLng: LatLng(6.8560, 79.8660)),
  _Pharmacy(
      name: 'Ceylinco Medicare',
      location: 'Nugegoda',
      distance: '9.3km ahead',
      price: 5400,
      available: 5,
      total: 6,
      notAvailable: 'Lactaid',
      accepted: 74,
      cancelled: 2,
      rating: 4.7,
      brandColor: Color(0xFF6A1B9A),
      latLng: LatLng(6.8720, 79.8990)),
];

// ── Page ──────────────────────────────────────────────────────────────────────
class NearbyPharmacyPage extends StatefulWidget {
  const NearbyPharmacyPage({super.key});
  @override
  State<NearbyPharmacyPage> createState() => _NearbyPharmacyPageState();
}

class _NearbyPharmacyPageState extends State<NearbyPharmacyPage>
    with TickerProviderStateMixin {
  int _stage = 0;
  bool _scanning = true;
  bool _showMarkers = false;
  _Pharmacy? _selected;

  final _mapController = MapController();

  static const _userLat = 6.8935;
  static const _userLng = 79.8740;
  static const _userPos = LatLng(_userLat, _userLng);
  static const _zoomLevels = [14.0, 12.5, 11.0];

  late AnimationController _breatheCtrl;
  late Animation<double> _breatheAnim;
  late AnimationController _labelCtrl;
  late Animation<double> _labelAnim;
  String _currentLabel = '1km';
  String _nextLabel = '1km';
  double _radarScale = 1.0;
  late AnimationController _zoomCtrl;
  late Animation<double> _zoomAnim;

  static const _stageLabels = ['1km', '5km', '10km'];

  @override
  void initState() {
    super.initState();

    _breatheCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600))
      ..repeat(reverse: true);
    _breatheAnim = Tween<double>(begin: 0.93, end: 1.07).animate(
        CurvedAnimation(parent: _breatheCtrl, curve: Curves.easeInOut));

    _labelCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _labelAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _labelCtrl, curve: Curves.easeInOut));

    _zoomCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _zoomAnim = const AlwaysStoppedAnimation(1.0);

    _runScanSequence();
  }

  void _runScanSequence() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;
    _advanceStage(1);
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;
    _advanceStage(2);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    _finishScan();
  }

  void _advanceStage(int next) {
    setState(() {
      _nextLabel = _stageLabels[next];
      _stage = next;
    });
    _currentLabel = _stageLabels[next - 1];

    // Animate map zoom
    _mapController.move(_userPos, _zoomLevels[next]);

    // Radar scale tween
    final fromScale = _radarScale;
    final toScale = next == 1 ? 0.80 : 0.62;
    _zoomAnim = Tween<double>(begin: fromScale, end: toScale)
        .animate(CurvedAnimation(parent: _zoomCtrl, curve: Curves.easeInOut));
    _zoomCtrl.forward(from: 0).then((_) => _radarScale = toScale);

    // Label morph
    _labelCtrl.forward(from: 0).then((_) {
      setState(() => _currentLabel = _nextLabel);
      _labelCtrl.reset();
    });
  }

  void _finishScan() {
    setState(() {
      _scanning = false;
      _showMarkers = true;
    });
    // Keep breathing animation running on results screen too
  }

  @override
  void dispose() {
    _breatheCtrl.dispose();
    _labelCtrl.dispose();
    _zoomCtrl.dispose();
    super.dispose();
  }

  List<_Pharmacy> get _currentPharmacies => _stage == 0
      ? _pharmacies1km
      : _stage == 1
          ? _pharmacies5km
          : _pharmacies10km;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Map + overlay area ────────────────────────────────────
          Expanded(
            flex: 45,
            child: Stack(
              children: [
                // ── flutter_map base — clean tile from Stadia Maps (no API key needed) ──
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _userPos,
                    initialZoom: _zoomLevels[0],
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,
                    ),
                  ),
                  children: [
                    // CartoDB Positron — ultra-clean minimal white/grey tiles
                    TileLayer(
                      urlTemplate:
                          'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c', 'd'],
                      userAgentPackageName: 'com.medifind.app',
                    ),
                    // Strong brand-blue colour wash — turns the white map blue
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF0796DE).withOpacity(0.72),
                        BlendMode.srcATop,
                      ),
                      child: Container(
                        color: const Color(0xFF0796DE),
                      ),
                    ),
                  ],
                ),

                // ── Breathing radar rings (animated overlay) ──────────
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_breatheAnim, _zoomAnim]),
                      builder: (_, __) => CustomPaint(
                        painter: _RadarPainter(
                          breatheScale: _breatheAnim.value,
                          ringScale: _zoomAnim is AlwaysStoppedAnimation
                              ? _radarScale
                              : (_zoomAnim as Animation<double>).value,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Pharmacy markers (after scan) ─────────────────────
                if (_showMarkers)
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: false,
                      child: LayoutBuilder(builder: (_, constraints) {
                        final w = constraints.maxWidth;
                        final h = constraints.maxHeight;
                        // Fixed screen positions — all on land (east side, away from coast)
                        const positions = [
                          Offset(0.72, 0.38), // Union Chemists — inland east
                          Offset(0.58, 0.52), // Healthguard — centre
                          Offset(0.65, 0.25), // Osusala — north east
                          Offset(0.80, 0.58), // Health Link — east
                          Offset(0.55, 0.70), // Jeewaka — south centre
                          Offset(0.70, 0.72), // Suncity — south east
                          Offset(0.85, 0.44), // Ceylinco — far east
                        ];
                        return Stack(
                            children: List.generate(
                                min(positions.length, _pharmacies10km.length),
                                (i) {
                          final p = _pharmacies10km[i];
                          final x = positions[i].dx * w;
                          final y = positions[i].dy * h;
                          return Positioned(
                            left: x - 22,
                            top: y - 46,
                            child: GestureDetector(
                              onTap: () => setState(() => _selected = p),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2))
                                        ],
                                      ),
                                      child: const Icon(Icons.add,
                                          color: Color(0xFF0796DE), size: 22),
                                    ),
                                    const SizedBox(height: 2),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.88),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(p.name,
                                          style: const TextStyle(
                                              color: Color(0xFF0067A5),
                                              fontSize: 9,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ]),
                            ),
                          );
                        }));
                      }),
                    ),
                  ),

                // ── Top gradient — stronger so text always readable ───
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 160,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF0796DE),
                          const Color(0xFF0796DE).withOpacity(0.0),
                        ],
                        stops: const [0.55, 1.0],
                      ),
                    ),
                  ),
                ),

                // ── Top bar ───────────────────────────────────────────
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(children: [
                      Text(
                        _scanning
                            ? 'Searching nearby\nPhamacies'
                            : 'Nearby\nPhamacies',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          shadows: [
                            Shadow(color: Colors.black26, blurRadius: 6)
                          ],
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.location_on,
                            color: Colors.white, size: 13),
                        const Text('Send to ',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontFamily: 'Poppins')),
                        const Text('My Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600)),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 15),
                      ]),
                    ]),
                  ),
                ),

                // ── Centre dot (user location) ────────────────────────
                Center(
                  child: AnimatedBuilder(
                    animation: _breatheAnim,
                    builder: (_, __) => Transform.scale(
                      scale: _breatheAnim.value,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xFF0796DE), width: 3),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xFF0796DE).withOpacity(0.55),
                                blurRadius: 12,
                                spreadRadius: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── White bottom sheet ────────────────────────────────────
          Expanded(
            flex: 55,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Center(
                      child: Container(
                    margin: const EdgeInsets.only(top: 14, bottom: 8),
                    width: 36,
                    height: 5,
                    decoration: BoxDecoration(
                        color: const Color(0xFFDDDDDD),
                        borderRadius: BorderRadius.circular(3)),
                  )),
                  if (_scanning)
                    _buildScanningState()
                  else
                    _buildResultsState(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanningState() => Expanded(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _labelAnim,
              builder: (_, __) => Stack(alignment: Alignment.center, children: [
                Opacity(
                    opacity: (1 - _labelAnim.value).clamp(0.0, 1.0),
                    child: Transform.translate(
                        offset: Offset(0, -22 * _labelAnim.value),
                        child: Text(_currentLabel,
                            style: const TextStyle(
                                color: Color(0xFF0796DE),
                                fontSize: 44,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800)))),
                Opacity(
                    opacity: _labelAnim.value,
                    child: Transform.translate(
                        offset: Offset(0, 22 * (1 - _labelAnim.value)),
                        child: Text(_nextLabel,
                            style: const TextStyle(
                                color: Color(0xFF0796DE),
                                fontSize: 44,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800)))),
              ]),
            ),
            const Text('Radius',
                style: TextStyle(
                    color: Color(0xFF9F9EA5),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 14),
            const Text('Scanning for pharmacies...',
                style: TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 13,
                    fontFamily: 'Poppins')),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _stage >= i ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: _stage >= i
                                  ? const Color(0xFF0796DE)
                                  : const Color(0xFFDDDDDD),
                              borderRadius: BorderRadius.circular(4)),
                        ))),
          ],
        )),
      );

  Widget _buildResultsState() {
    final pharmacies = _currentPharmacies;
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(_selected != null ? _selected!.name : 'Nearby Pharmacies',
                style: const TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700)),
            if (_selected != null)
              GestureDetector(
                  onTap: () => setState(() => _selected = null),
                  child: const Text('Show all',
                      style: TextStyle(
                          color: Color(0xFF0796DE),
                          fontSize: 12,
                          fontFamily: 'Poppins'))),
          ]),
        ),
        if (_selected != null)
          _buildSelectedCard(_selected!)
        else
          Expanded(
              child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82),
            itemCount: pharmacies.length,
            itemBuilder: (_, i) => _buildPharmacyCard(pharmacies[i]),
          )),
      ]),
    );
  }

  Widget _buildSelectedCard(_Pharmacy p) => Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                      color: p.brandColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(p.name[0],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)))),
              const SizedBox(width: 14),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(p.name,
                        style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    Text('${p.available}/${p.total} Available',
                        style: const TextStyle(
                            color: Color(0xFF9F9EA5),
                            fontSize: 12,
                            fontFamily: 'Poppins')),
                    Text(p.location,
                        style: const TextStyle(
                            color: Color(0xFF9F9EA5),
                            fontSize: 12,
                            fontFamily: 'Poppins')),
                  ])),
            ]),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              if (p.notAvailable.isNotEmpty)
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Text('Not Available',
                          style: TextStyle(
                              color: Color(0xFF9F9EA5),
                              fontSize: 11,
                              fontFamily: 'Poppins')),
                      Text(p.notAvailable,
                          style: const TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500)),
                      Text('${((p.available / p.total) * 100).round()}%+',
                          style: const TextStyle(
                              color: Color(0xFF0796DE),
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600)),
                    ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('Total',
                    style: TextStyle(
                        color: Color(0xFF9F9EA5),
                        fontSize: 11,
                        fontFamily: 'Poppins')),
                Text('RS.${p.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                        color: Color(0xFF0796DE),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800)),
              ]),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              _statChip('Accepted', '${p.accepted}%'),
              const SizedBox(width: 8),
              _statChip('Cancelled', '${p.cancelled}%'),
              const SizedBox(width: 8),
              _statChip('Rating', '${p.rating}'),
            ]),
            const SizedBox(height: 14),
            SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Order confirmed!'),
                          backgroundColor: Color(0xFF0796DE))),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0796DE),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text('Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600)),
                )),
          ]),
        ),
      );

  Widget _statChip(String label, String value) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xFF0796DE),
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontFamily: 'Poppins')),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700)),
          ]),
        ),
      );

  Widget _buildPharmacyCard(_Pharmacy p) => GestureDetector(
        onTap: () => setState(() => _selected = p),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 55,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: p.brandColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Center(
                      child: Text(p.name[0],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 52,
                              fontWeight: FontWeight.w800))),
                )),
            Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        CircleAvatar(
                            radius: 11,
                            backgroundColor: p.brandColor,
                            child: Text(p.name[0],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(p.name,
                                style: const TextStyle(
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis)),
                      ]),
                      Text(p.distance,
                          style: const TextStyle(
                              color: Color(0xFF697282),
                              fontSize: 12,
                              fontFamily: 'Poppins')),
                      Text('RS.${p.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Color(0xFF0796DE),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                )),
          ]),
        ),
      );
}

// ── Radar rings painter ───────────────────────────────────────────────────────
class _RadarPainter extends CustomPainter {
  final double breatheScale;
  final double ringScale;
  _RadarPainter({required this.breatheScale, required this.ringScale});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final maxR = min(cx, cy) * 0.82 * ringScale * breatheScale;

    for (int i = 0; i < 5; i++) {
      final r = maxR * ((i + 1) / 5);
      // Filled rings — visible white glow
      canvas.drawCircle(
          Offset(cx, cy),
          r,
          Paint()
            ..color = Colors.white.withOpacity(0.08 + i * 0.04)
            ..style = PaintingStyle.fill);
      // Ring border — crisp white stroke
      canvas.drawCircle(
          Offset(cx, cy),
          r,
          Paint()
            ..color = Colors.white.withOpacity(0.65)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8);
    }
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.breatheScale != breatheScale || old.ringScale != ringScale;
}
