import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Settings toggles
  bool _orderUpdates = true;
  bool _reminderAlerts = true;
  bool _promotions = false;
  bool _appUpdates = true;
  bool _emailNotifs = false;
  bool _smsNotifs = true;

  // Fake notification list
  final List<_Notif> _notifs = [
    _Notif(
        icon: Icons.local_pharmacy_rounded,
        color: Color(0xFF0796DE),
        title: 'Order Delivered!',
        body: 'Your order from Health Link has been delivered successfully.',
        time: '2 min ago',
        unread: true),
    _Notif(
        icon: Icons.payment_rounded,
        color: Color(0xFF4CAF50),
        title: 'Payment Confirmed',
        body: 'RS.5150 payment for Asiri Hospital was successful.',
        time: '1 hr ago',
        unread: true),
    _Notif(
        icon: Icons.alarm_rounded,
        color: Color(0xFFFF9800),
        title: 'Medicine Reminder',
        body: 'Time to take your Paracetamol 500mg.',
        time: '3 hr ago',
        unread: false),
    _Notif(
        icon: Icons.local_offer_rounded,
        color: Color(0xFF9C27B0),
        title: 'Special Offer',
        body: 'Get 10% off on your next order from Union Chemists.',
        time: 'Yesterday',
        unread: false),
    _Notif(
        icon: Icons.delivery_dining_rounded,
        color: Color(0xFF0796DE),
        title: 'Order Shipped',
        body: 'Your order #MF391977 is on the way.',
        time: 'Yesterday',
        unread: false),
    _Notif(
        icon: Icons.alarm_rounded,
        color: Color(0xFFFF9800),
        title: 'Medicine Reminder',
        body: 'Time to take your Amoxicillin 250mg.',
        time: '2 days ago',
        unread: false),
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final unreadCount = _notifs.where((n) => n.unread).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0796DE),
      body: Column(children: [
        // ── Header ────────────────────────────────────────────────
        ClipRect(
          child: Container(
            color: const Color(0xFF0796DE),
            child: Stack(clipBehavior: Clip.hardEdge, children: [
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
              Padding(
                padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white, size: 24)),
                            if (unreadCount > 0)
                              TextButton(
                                onPressed: () => setState(() {
                                  for (var n in _notifs) n.unread = false;
                                }),
                                child: const Text('Mark all read',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500)),
                              )
                            else
                              const SizedBox(width: 48),
                          ]),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Text('Notifications',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700)),
                                if (unreadCount > 0) ...[
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFEB3636),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text('$unreadCount new',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ]),
                              const Text('Stay up to date with your orders',
                                  style: TextStyle(
                                      color: Color(0xFFD0EEFF),
                                      fontSize: 13,
                                      fontFamily: 'Poppins')),
                            ]),
                      ),
                    ]),
              ),
            ]),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Notification preferences ───────────────────────
                    const Text('Notification Preferences',
                        style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xFF0796DE).withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 3))
                          ]),
                      child: Column(children: [
                        _toggle(
                            'Order Updates',
                            'Delivery status & confirmations',
                            Icons.local_shipping_rounded,
                            _orderUpdates,
                            (v) => setState(() => _orderUpdates = v)),
                        _divider(),
                        _toggle(
                            'Medicine Reminders',
                            'Daily medicine alerts',
                            Icons.alarm_rounded,
                            _reminderAlerts,
                            (v) => setState(() => _reminderAlerts = v)),
                        _divider(),
                        _toggle(
                            'Promotions & Offers',
                            'Discounts from pharmacies',
                            Icons.local_offer_rounded,
                            _promotions,
                            (v) => setState(() => _promotions = v)),
                        _divider(),
                        _toggle(
                            'App Updates',
                            'New features & improvements',
                            Icons.system_update_rounded,
                            _appUpdates,
                            (v) => setState(() => _appUpdates = v)),
                        _divider(),
                        _toggle(
                            'Email Notifications',
                            'Receive alerts via email',
                            Icons.email_rounded,
                            _emailNotifs,
                            (v) => setState(() => _emailNotifs = v)),
                        _divider(),
                        _toggle(
                            'SMS Notifications',
                            'Receive alerts via SMS',
                            Icons.sms_rounded,
                            _smsNotifs,
                            (v) => setState(() => _smsNotifs = v)),
                      ]),
                    ),

                    const SizedBox(height: 28),

                    // ── Recent notifications ───────────────────────────
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Recent',
                              style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700)),
                          if (_notifs.isNotEmpty)
                            GestureDetector(
                              onTap: () => setState(() => _notifs.clear()),
                              child: const Text('Clear all',
                                  style: TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 13,
                                      fontFamily: 'Poppins')),
                            ),
                        ]),
                    const SizedBox(height: 12),

                    if (_notifs.isEmpty)
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(children: [
                          Icon(Icons.notifications_off_rounded,
                              color: const Color(0xFF0796DE).withOpacity(0.3),
                              size: 56),
                          const SizedBox(height: 12),
                          const Text('No notifications',
                              style: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500)),
                        ]),
                      ))
                    else
                      ...List.generate(_notifs.length, (i) {
                        final n = _notifs[i];
                        return Dismissible(
                          key: Key('notif_$i'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                color: const Color(0xFFEF5350),
                                borderRadius: BorderRadius.circular(16)),
                            child: const Icon(Icons.delete_rounded,
                                color: Colors.white),
                          ),
                          onDismissed: (_) =>
                              setState(() => _notifs.removeAt(i)),
                          child: GestureDetector(
                            onTap: () => setState(() => n.unread = false),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: n.unread
                                      ? const Color(0xFF0796DE)
                                          .withOpacity(0.05)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: n.unread
                                          ? const Color(0xFF0796DE)
                                              .withOpacity(0.2)
                                          : Colors.transparent),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2))
                                  ]),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                          color: n.color.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Icon(n.icon,
                                          color: n.color, size: 22),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Text(n.title,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFF0F172A),
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight: n.unread
                                                                ? FontWeight
                                                                    .w700
                                                                : FontWeight
                                                                    .w600))),
                                                Text(n.time,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF94A3B8),
                                                        fontSize: 11,
                                                        fontFamily: 'Poppins')),
                                              ]),
                                          const SizedBox(height: 3),
                                          Text(n.body,
                                              style: const TextStyle(
                                                  color: Color(0xFF64748B),
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  height: 1.4)),
                                        ])),
                                    if (n.unread) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF0796DE),
                                              shape: BoxShape.circle)),
                                    ],
                                  ]),
                            ),
                          ),
                        );
                      }),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _toggle(String title, String sub, IconData icon, bool val,
      ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: const Color(0xFF0796DE).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF0796DE), size: 20)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
          Text(sub,
              style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11,
                  fontFamily: 'Poppins')),
        ])),
        Switch(
            value: val,
            onChanged: onChanged,
            activeColor: const Color(0xFF0796DE)),
      ]),
    );
  }

  Widget _divider() => const Divider(
      height: 1, indent: 16, endIndent: 16, color: Color(0xFFF1F5F9));
}

class _Notif {
  final IconData icon;
  final Color color;
  final String title, body, time;
  bool unread;
  _Notif(
      {required this.icon,
      required this.color,
      required this.title,
      required this.body,
      required this.time,
      required this.unread});
}
