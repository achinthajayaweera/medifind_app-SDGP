import 'package:flutter/material.dart';
import 'order_store.dart';

class PreviousOrdersPage extends StatefulWidget {
  const PreviousOrdersPage({super.key});

  @override
  State<PreviousOrdersPage> createState() => _PreviousOrdersPageState();
}

class _PreviousOrdersPageState extends State<PreviousOrdersPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerFade;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _headerFade =
        CurvedAnimation(parent: _headerController, curve: Curves.easeOut);
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  void _showOrderDetail(BuildContext context, OrderItem order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.92,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
              color: Color(0xFFF5F7FF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
            children: [
              // Handle
              Center(
                  child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                          color: const Color(0xFFCDD5E0),
                          borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),

              // Header row
              Row(children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      color: const Color(0xFF0796DE).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.local_pharmacy_rounded,
                      color: Color(0xFF0796DE), size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(order.pharmacyName,
                          style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700)),
                      Text(order.deliveredAt,
                          style: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                              fontFamily: 'Poppins')),
                    ])),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50), shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    const Text('Delivered',
                        style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600)),
                  ]),
                ),
              ]),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 16),

              // Order ID + amount
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Order ID',
                      style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 11,
                          fontFamily: 'Poppins')),
                  Text(order.orderId,
                      style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('Total Paid',
                      style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 11,
                          fontFamily: 'Poppins')),
                  Text(order.amount,
                      style: const TextStyle(
                          color: Color(0xFF0796DE),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700)),
                ]),
              ]),
              const SizedBox(height: 20),

              // Medicines section
              const Text('Items Ordered',
                  style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),

              if (order.medicines.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: const Text('No medicine details available.',
                      style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                          fontFamily: 'Poppins')),
                )
              else
                ...order.medicines.map((med) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xFF0796DE).withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ]),
                      child: Row(children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              color: const Color(0xFF0796DE).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.medication_rounded,
                              color: Color(0xFF0796DE), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(med.name,
                                  style: const TextStyle(
                                      color: Color(0xFF0F172A),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600)),
                              Text(med.category,
                                  style: const TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 12,
                                      fontFamily: 'Poppins')),
                            ])),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: const Color(0xFF0796DE).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('x${med.quantity}',
                              style: const TextStyle(
                                  color: Color(0xFF0796DE),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600)),
                        ),
                      ]),
                    )),

              const SizedBox(height: 20),

              // Reorder button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0796DE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      elevation: 0),
                  icon: const Icon(Icons.replay_rounded,
                      color: Colors.white, size: 18),
                  label: const Text('Reorder',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderStore.instance.orders;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFF0796DE), // matches header — no gap
      body: Column(
        children: [
          // ── Header — bleeds behind status bar ─────────────────────
          ClipRect(
            child: Container(
              color: const Color(0xFF0796DE),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // Decorative circles
                  Positioned(
                      right: -30,
                      top: -40,
                      child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 25,
                                  color: Colors.white.withOpacity(0.12))))),
                  Positioned(
                      left: -20,
                      bottom: -20,
                      child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.06)))),
                  // Content
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 20),
                    child: FadeTransition(
                      opacity: _headerFade,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.arrow_back,
                                          color: Colors.white, size: 24)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                        '${orders.length} order${orders.length != 1 ? 's' : ''}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ]),
                            const SizedBox(height: 4),
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Past Orders',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700)),
                                    Text('Your delivery history',
                                        style: TextStyle(
                                            color: Color(0xFFD0EEFF),
                                            fontSize: 13,
                                            fontFamily: 'Poppins')),
                                  ]),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28))),
              child: orders.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      itemCount: orders.length,
                      itemBuilder: (context, index) => _OrderCard(
                          order: orders[index],
                          index: index,
                          onTap: () =>
                              _showOrderDetail(context, orders[index])),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0796DE).withOpacity(0.08)),
          child: Icon(Icons.receipt_long_rounded,
              color: const Color(0xFF0796DE).withOpacity(0.4), size: 48),
        ),
        const SizedBox(height: 20),
        const Text('No orders yet',
            style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text('Your completed orders will appear here',
            style: TextStyle(
                color: const Color(0xFF64748B).withOpacity(0.8),
                fontSize: 13,
                fontFamily: 'Poppins')),
      ]),
    );
  }
}

// ── Order card ─────────────────────────────────────────────────────────────────
class _OrderCard extends StatefulWidget {
  final OrderItem order;
  final int index;
  final VoidCallback onTap;
  const _OrderCard(
      {required this.order, required this.index, required this.onTap});

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _slide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _fade = Tween<double>(begin: 0, end: 1).animate(_ctrl);
    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF0796DE).withOpacity(0.07),
                      blurRadius: 16,
                      offset: const Offset(0, 4))
                ]),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: const Color(0xFF0796DE).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.local_pharmacy_rounded,
                        color: Color(0xFF0796DE), size: 26),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(order.pharmacyName,
                            style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(order.deliveredAt,
                            style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 11,
                                fontFamily: 'Poppins')),
                      ])),
                  // Status badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle)),
                      const SizedBox(width: 5),
                      const Text('Delivered',
                          style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ]),
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.tag_rounded,
                            color: Color(0xFF94A3B8), size: 14),
                        const SizedBox(width: 4),
                        Text(order.orderId,
                            style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 12,
                                fontFamily: 'Poppins')),
                      ]),
                      Row(children: [
                        Text(order.amount,
                            style: const TextStyle(
                                color: Color(0xFF0796DE),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded,
                            color: Color(0xFF94A3B8), size: 18),
                      ]),
                    ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
