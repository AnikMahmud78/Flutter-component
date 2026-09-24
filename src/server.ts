import { NotificationController } from './controllers/notification_controller';

const controller = new NotificationController();
const firstPage = controller.getNotifications('5');
console.log('--- Paginated Notification Delivery Endpoint ---');
console.log(JSON.stringify(firstPage, null, 2));
