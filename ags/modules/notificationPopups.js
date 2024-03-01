import notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
const popups = notifications.bind('popups');

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
          ],
        }),
        actions,
      ],
    }),
  });
};

export const NotificationPopups = (monitor = 0) => Widget.Window({
  name: 'notifications',
  anchor: ['top', 'right'],
  layer: 'overlay',
  monitor,
  child: Widget.Box({
    class_name: 'notifications',
    css: 'padding: 1px;',
    vertical: true,
    children: popups.as(popups => popups.map(Notification)),
  }),
});
