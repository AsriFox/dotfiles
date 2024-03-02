import { timeout } from 'resource:///com/github/Aylur/ags/utils.js';
import notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
notifications.popupTimeout = 5000;

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
const NotificationIcon = ({ app_entry, app_icon, image }) => {
  if (image) {
    return Widget.Box({
      css: `
        background-image: url("${image}");
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
      `,
    });
  }

  let icon = 'dialog-information-symbolic';
  if (app_entry && Utils.lookUpIcon(app_entry))
    icon = app_entry;
  else if (Utils.lookUpIcon(app_icon))
    icon = app_icon;
  return Widget.Icon(icon);
}

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
export const Notification = n => {
  const icon = Widget.Box({
    vpack: 'start',
    class_name: 'icon',
    child: NotificationIcon(n),
  });

  const title = Widget.Label({
    class_name: 'title',
    xalign: 0,
    justification: 'left',
    hexpand: true,
    max_width_chars: 24,
    truncate: 'end',
    wrap: true,
    label: n.summary,
    use_markup: true,
  });

  const body = Widget.Label({
    class_name: 'body',
    xalign: 0,
    justification: 'left',
    hexpand: true,
    wrap: true,
    label: n.body,
    use_markup: true,
  });

  const actions = Widget.Box({
    class_name: 'actions',
    children: n.actions.map(({ id, label }) => Widget.Button({
      class_name: 'action-button',
      on_clicked: () => n.invoke(id),
      hexpand: true,
      child: Widget.Label(label),
    })),
  });

  return Widget.EventBox({
    on_primary_click: () => n.dismiss(),
    child: Widget.Box({
      class_name: `notification ${n.urgency}`,
      vertical: true,
      children: [
        Widget.Box({
          children: [
            icon,
            Widget.Box({
              vertical: true,
              children: [
                title,
                body,
              ],
            }),
            Widget.Button({
              hpack: 'start',
              vpack: 'start',
              class_name: 'close-button',
              child: Widget.Icon('window-close'),
              on_clicked: () => n.close(),
            }),
          ],
        }),
        actions,
      ],
    }),
  });
};

const notificationListVisible = Variable(false);
globalThis.toggleNotificationsList = () => notificationListVisible.value = !notificationListVisible.value;

export const NotificationPopups = (monitor = 0) => Widget.Window({
  name: 'notifications',
  anchor: ['top', 'right'],
  layer: 'overlay',
  monitor,
  visible: notificationListVisible.bind().as(value => !value),
  child: Widget.Box({
    class_name: 'notifications',
    vertical: true,
    children: notifications.bind('popups')
      .as(popups => popups.map(Notification)),
  }),
});

const NotificationsListBox = () => Widget.Box({
  vertical: true,
  setup: box => timeout(1000, () => {
    notifications.notifications.forEach(notif => {
      box.attribute.onAdded(box, notif.id);
    });
  }),
  attribute: {
    notifications: new Map(),
    onAdded: (box, id) => {
      const notif = notifications.getNotification(id);
      if (!notif) return;
      const replace = box.attribute.notifications.get(id);
      if (replace) replace.destroy();
      const notification = Notification(notif, !!replace);
      box.attribute.notifications.set(id, notification);
      box.add(notification);
      box.show_all();
    },
    onRemoved: (box, id) => {
      const notif = box.attribute.notifications.get(id);
      if (!notif) return;
      notif.destroy();
      box.attribute.notifications.delete(id);
    },
  },
})
  .hook(notifications, (box, id) => box.attribute.onAdded(box, id), 'notified')
  .hook(notifications, (box, id) => box.attribute.onRemoved(box, id), 'closed');

export const NotificationsList = (monitor = 0) => Widget.Window({
  name: 'notifications-list',
  anchor: ['top', 'bottom', 'right'],
  layer: 'overlay',
  monitor,
  visible: notificationListVisible.bind(),
  child: Widget.Box({
    class_name: 'notifications-list',
    vertical: true,
    children: [
      Widget.Box({
        css: 'padding: 6px;',
        spacing: 6,
        hpack: 'end',
        children: [
          Widget.Button({
            css: `
              padding: 6px;
              font-size: 14px;
            `,
            child: Widget.Box({
              spacing: 6,
              children: [
                Widget.Label({
                  label: notifications.bind('dnd')
                    .as(dnd => dnd
                      ? 'Silent'
                      : 'Enabled'),
                }),
                Widget.Icon({
                  icon: notifications.bind('dnd')
                    .as(dnd => dnd
                      ? 'notifications-disabled'
                      : 'notifications'),
                }),
              ],
            }),
            on_clicked: () => notifications.dnd = !notifications.dnd,
          }),
          Widget.Button({
            css: `
              padding: 6px;
              font-size: 14px;
            `,
            child: Widget.Box({
              spacing: 6,
              children: [
                Widget.Icon('user-trash-symbolic'),
                Widget.Label('Clear'),
              ],
            }),
            on_clicked: () => notifications.clear(),
          }),
        ],
      }),
      Widget.Scrollable({
        vexpand: true,
        hscroll: 'never',
        vscroll: 'always',
        child: NotificationsListBox(),
      }),
    ],
  }),
});
