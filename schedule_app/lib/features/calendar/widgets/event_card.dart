import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String timeRange;
  final String? note;
  final bool isDone;
  final Color indicatorColor;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleDone;

  const EventCard({
    super.key,
    required this.title,
    required this.timeRange,
    this.note,
    this.isDone = false,
    this.indicatorColor = Colors.blue,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? onToggleDone,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Vạch màu chỉ thị trạng thái / phân loại
              Container(
                width: 6.0,
                color: isDone ? Colors.grey : indicatorColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Khung giờ
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: isDone ? Colors.grey : theme.primaryColor,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            timeRange,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDone ? Colors.grey : theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      // Tiêu đề sự kiện
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration:
                              isDone ? TextDecoration.lineThrough : null,
                          color: isDone
                              ? Colors.grey.shade600
                              : Colors.black87,
                        ),
                      ),
                      // Ghi chú ngắn (nếu có)
                      if (note != null && note!.isNotEmpty) ...[
                        const SizedBox(height: 4.0),
                        Text(
                          note!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDone
                                ? Colors.grey.shade500
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Nút hoàn thành + Menu Tùy chọn (Sửa / Xóa)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Biểu tượng trạng thái hoàn thành (có thể ấn vào để toggle)
                  IconButton(
                    onPressed: onToggleDone,
                    tooltip: isDone ? 'Chưa hoàn thành' : 'Đã hoàn thành',
                    icon: Icon(
                      isDone
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: isDone ? Colors.green : Colors.grey.shade400,
                      size: 24,
                    ),
                  ),
                  // Menu lựa chọn Sửa / Xóa
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit?.call();
                      } else if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            const Icon(Icons.edit_outlined, size: 18, color: Colors.blue),
                            const SizedBox(width: 8.0),
                            Text(l10n.edit),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.red),
                            const SizedBox(width: 8.0),
                            Text(
                              l10n.delete,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
