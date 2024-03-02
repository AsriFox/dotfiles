import { StatusBar } from './modules/statusBar.js';
import { NotificationPopups, NotificationsList } from './modules/notifications.js';
import { MonitorRoundedCorners } from './modules/roundedCorners.js';

export default {
  style: './style.css',
  windows: [
    StatusBar(1),
    NotificationPopups(),
    NotificationsList(),
    ...MonitorRoundedCorners(),
  ],
}

