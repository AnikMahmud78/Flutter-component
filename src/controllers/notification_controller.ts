import { NotificationItem, PaginatedNotificationResponse } from '../models/notification_model';

// English Code (EC): Fetch-Paginated-Notification-List
export class NotificationController {
  private mockNotifications: NotificationItem[] = Array.from({ length: 50 }, (_, i) => ({
    id: `NOTIF-${1000 + i}`,
    title: `System Alert ${i + 1}`,
    body: `Engineering status parameter update verified cleanly at sequence ${i + 1}.`,
    timestamp: new Date(Date.now() - i * 3600000).toISOString(),
    isRead: i > 5,
  }));

  public getNotifications(limitStr?: string, cursor?: string): PaginatedNotificationResponse {
    const limit = parseInt(limitStr || '10', 10);
    let startIndex = 0;

    if (cursor) {
      const foundIdx = this.mockNotifications.findIndex(n => n.id === cursor);
      if (foundIdx !== -1) {
        startIndex = foundIdx + 1;
      }
    }

    const items = this.mockNotifications.slice(startIndex, startIndex + limit);
    const nextCursor = items.length > 0 ? items[items.length - 1].id : null;
    const hasMore = startIndex + limit < this.mockNotifications.length;

    return {
      data: items,
      nextCursor: hasMore ? nextCursor : null,
      hasMore,
      totalCount: this.mockNotifications.length,
    };
  }
}
