export interface NotificationItem {
  id: string;
  title: string;
  body: string;
  timestamp: string;
  isRead: boolean;
}

export interface PaginatedNotificationResponse {
  data: NotificationItem[];
  nextCursor: string | null;
  hasMore: boolean;
  totalCount: number;
}
