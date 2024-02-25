const hyprland = await Service.import('hyprland');
const audio = await Service.import('audio');
const systemtray = await Service.import('systemtray');

const date = Variable('', {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
});

const Workspaces = () => Widget.Box({
  class_name: 'workspaces',
  children: hyprland.bind('workspaces').as(ws => ws.map(
    ({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: hyprland.active.workspace.bind('id')
        .as(i => i === id ? 'focused' : ''),
    })
  )),
});

const ClientTitle = () => Widget.Label({
  class_name: 'client-title',
  label: hyprland.active.client.bind('title'),
});

const Clock = () => Widget.Label({
  class_name: 'clock',
  label: date.bind(),
});

const Volume = () => Widget.Box({
  class_name: 'volume',
  css: 'min-width: 80px',
  children: [
    Widget.Icon().hook(audio.speaker, self => {
      const category = {
        101: 'overamplified',
        67: 'high',
        34: 'medium',
        1: 'low',
        0: 'muted',
      };
      const icon = audio.speaker.is_muted
        ? 0
        : [101, 67, 34, 1, 0].find(threshold => Number(threshold) <= audio.speaker.volume * 100);
      self.icon = `audio-volume-${category[icon]}-symbolic`;
    }),
    Widget.Slider({
      hexpand: true,
      draw_value: false,
      on_change: ({ value }) => audio.speaker.volume = value,
      setup: self => self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
    }),
  ],
});

const SysTray = () => Widget.Box({
  children: systemtray.bind('items').as(items =>
    items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind('icon') }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind('tooltip_markup'),
    })),
  ),
});

const Bar = (monitor = 0) => Widget.Window({
  name: `bar-${monitor}`,
  class_name: 'bar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: Widget.Box({
      spacing: 8,
      children: [
        Workspaces(),
        ClientTitle(),
      ],
    }),
    center_widget: Widget.Box({
      spacing: 8,
      children: [
        Clock(),
      ],
    }),
    end_widget: Widget.Box({
      hpack: 'end',
      spacing: 8,
      children: [
        Volume(),
        SysTray(),
      ],
    }),
  }),
});

export default {
  style: './style.css',
  windows: [
    Bar(),
  ],
}

