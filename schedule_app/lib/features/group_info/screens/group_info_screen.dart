import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key});

  // Danh sách đúng 30 Widgets thực tế được sử dụng trong Đồ Án
  final List<Map<String, String>> _widgetInventory = const [
    {'name': 'MaterialApp', 'category': 'Core', 'desc': 'Cấu hình khung nền ứng dụng chuẩn Material Design'},
    {'name': 'Scaffold', 'category': 'Cấu trúc', 'desc': 'Khung giao diện chính chuẩn với AppBar, Drawer, Body'},
    {'name': 'AppBar', 'category': 'Cấu trúc', 'desc': 'Thanh tiêu đề điều hướng và nút thao tác'},
    {'name': 'Drawer', 'category': 'Điều hướng', 'desc': 'Thanh menu cạnh bên chuyển đổi màn hình'},
    {'name': 'UserAccountsDrawerHeader', 'category': 'Điều hướng', 'desc': 'Header hiển thị thông tin nhóm trong Drawer'},
    {'name': 'TableCalendar', 'category': 'Lịch', 'desc': 'Hiển thị và tương tác chọn lịch theo ngày/tuần/tháng'},
    {'name': 'Card', 'category': 'Container', 'desc': 'Thẻ chứa thông tin bo góc có đổ bóng nhẹ'},
    {'name': 'Container', 'category': 'Container', 'desc': 'Đóng gói style, margin, padding, màu nền'},
    {'name': 'Padding & SizedBox', 'category': 'Bố cục', 'desc': 'Tạo khoảng cách padding và margin tĩnh'},
    {'name': 'Column & Row', 'category': 'Bố cục', 'desc': 'Sắp xếp phần tử theo chiều dọc và chiều ngang'},
    {'name': 'Stack & Positioned', 'category': 'Bố cục', 'desc': 'Xếp chồng các lớp giao diện và định vị phần tử'},
    {'name': 'Wrap & Chip', 'category': 'Bố cục', 'desc': 'Tự động xuống dòng danh sách nhãn/thẻ công nghệ'},
    {'name': 'Expanded', 'category': 'Bố cục', 'desc': 'Tự động mở rộng chiếm khoảng trống khả dụng'},
    {'name': 'Divider', 'category': 'Bố cục', 'desc': 'Đường kẻ vạch phân cách giữa các phần tử'},
    {'name': 'SingleChildScrollView', 'category': 'Cuộn', 'desc': 'Cho phép cuộn trang khi nội dung tràn màn hình'},
    {'name': 'ListView.builder', 'category': 'Danh sách', 'desc': 'Danh sách cuộn tối ưu hiệu năng động'},
    {'name': 'ListTile', 'category': 'Danh sách', 'desc': 'Hàng danh sách chuẩn gồm Icon, Title, Subtitle'},
    {'name': 'ExpansionTile', 'category': 'Danh sách', 'desc': 'Danh sách mở rộng có thể đóng/mở nội dung'},
    {'name': 'DataTable', 'category': 'Bảng', 'desc': 'Bảng hiển thị thông tin phân công dạng lưới'},
    {'name': 'Text & RichText', 'category': 'Văn bản', 'desc': 'Hiển thị văn bản đơn và định dạng nâng cao'},
    {'name': 'Icon & CircleAvatar', 'category': 'Hiển thị', 'desc': 'Icon hệ thống và ảnh đại diện hình tròn'},
    {'name': 'Badge', 'category': 'Hiển thị', 'desc': 'Huy hiệu thông báo số lượng sự kiện/thành viên'},
    {'name': 'LinearProgressIndicator', 'category': 'Tiến độ', 'desc': 'Thanh hiển thị tiến trình công việc'},
    {'name': 'Form & TextFormField', 'category': 'Nhập liệu', 'desc': 'Khung Form và ô nhập liệu kiểm tra hợp lệ'},
    {'name': 'SwitchListTile', 'category': 'Tương tác', 'desc': 'Công tắc bật/tắt nhận thông báo nhắc hẹn'},
    {'name': 'Checkbox', 'category': 'Tương tác', 'desc': 'Ô tích chọn trạng thái hoàn thành sự kiện'},
    {'name': 'ElevatedButton & TextButton', 'category': 'Nút nhấn', 'desc': 'Các nút nhấn tương tác chính và phụ'},
    {'name': 'IconButton & FloatingActionButton', 'category': 'Nút nhấn', 'desc': 'Nút bấm Icon và nút nổi thêm mới sự kiện'},
    {'name': 'AlertDialog & showDatePicker', 'category': 'Hộp thoại', 'desc': 'Hộp thoại xác nhận xóa & chọn ngày tháng'},
    {'name': 'SnackBar', 'category': 'Thông báo', 'desc': 'Thanh thông báo phản hồi thao tác tức thì'},
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = Theme.of(context).primaryColor;

    final List<Map<String, String>> members = const [
      {
        'studentId': '24100462',
        'name': 'Tưởng Văn Tuyên',
        'role': 'Trưởng Nhóm',
        'tasks': 'Màn hình Thêm/Sửa/Xóa sự kiện (AddEventScreen), Cơ sở dữ liệu Offline (Isar NoSQL), Thông báo nhắc hẹn (Local Notifications), Giao diện EventCard',
        'tech': 'Flutter, Isar NoSQL, Local Notifications',
      },
      {
        'studentId': '24100350',
        'name': 'Nguyễn Thành Vinh',
        'role': 'Thành Viên',
        'tasks': 'Kiến trúc ứng dụng (BLoC/Cubit), Màn hình Lịch cá nhân (TableCalendar), Hỗ trợ đa ngôn ngữ Việt-Anh (i18n), Báo cáo đồ án',
        'tech': 'Flutter, Dart, TableCalendar, i18n',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.groupInfoTitle),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CARD TỔNG QUAN THÔNG TIN ĐỒ ÁN
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'NHÓM 06 - LỚP N01',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'LTTBDD',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Ứng Dụng Lập Lịch Cá Nhân (Schedule App)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 24),
                    _buildMetaRow('Môn học:', 'Lập trình thiết bị di động'),
                    _buildMetaRow('Lớp học phần:', 'N01'),
                    _buildMetaRow('Số lượng thành viên:', '2 sinh viên'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: [
                        _buildBadgeChip('Flutter 3.x'),
                        _buildBadgeChip('Dart SDK'),
                        _buildBadgeChip('Isar NoSQL'),
                        _buildBadgeChip('Local Notifications'),
                        _buildBadgeChip('BLoC / Cubit'),
                        _buildBadgeChip('TableCalendar'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DANH SÁCH THÀNH VIÊN
            Text(
              l10n.teamMembers,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...members.map((m) {
              final isLeader = m['role'] == 'Trưởng Nhóm';
              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: primaryColor.withAlpha(25),
                        child: Text(
                          m['name']!.split(' ').last[0],
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  m['name']!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: isLeader ? primaryColor.withAlpha(20) : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: isLeader ? primaryColor.withAlpha(50) : Colors.grey.shade300),
                                  ),
                                  child: Text(
                                    m['role']!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: isLeader ? primaryColor : Colors.grey.shade800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'MSSV: ${m['studentId']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Nhiệm vụ: ${m['tasks']}',
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 12),

            // BẢNG PHÂN CÔNG NHIỆM VỤ
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bảng Phân Công Nhiệm Vụ',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowHeight: 40,
                        dataRowMinHeight: 44,
                        dataRowMaxHeight: 64,
                        columnSpacing: 20,
                        columns: const [
                          DataColumn(label: Text('MSSV', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Họ và tên', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Vai trò', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Nhiệm vụ chính trong đồ án', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: members.map((m) {
                          return DataRow(cells: [
                            DataCell(Text(m['studentId']!)),
                            DataCell(Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.w600))),
                            DataCell(Text(m['role']!)),
                            DataCell(Text(m['tasks']!)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // DANH SÁCH WIDGET SỬ DỤNG TRONG ỨNG DỤNG
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: ExpansionTile(
                title: Text(
                  l10n.widgetShowcase,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Tổng số đúng ${_widgetInventory.length} Widgets Flutter được tích hợp trong đồ án',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _widgetInventory.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final w = _widgetInventory[index];
                        return ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          title: Text(
                            w['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          subtitle: Text(w['desc']!, style: const TextStyle(fontSize: 12)),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              w['category']!,
                              style: const TextStyle(fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // FOOTER
            Center(
              child: Text(
                'Nhóm 06 - Lớp N01 | Đồ án Lập trình thiết bị di động',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeChip(String label) {
    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: Colors.grey.shade100,
      side: BorderSide(color: Colors.grey.shade300),
      label: Text(
        label,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
