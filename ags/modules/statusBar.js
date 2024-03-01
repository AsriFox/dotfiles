import hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import systemtray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import { exec } from 'resource:///com/github/Aylur/ags/utils.js';

const date = Variable('', {
  poll: [1000, 'date "+%H:%M:%S"'],
});
const Clock = Widget.Label({
  class_name: 'clock',
  label: date.bind(),
});

const Workspaces = Widget.Box({
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

/*
const ClientTitle = Widget.Label({
  class_name: 'client-title',
  label: hyprland.active.client.bind('title'),
});
*/

const KbLayout = Widget.Label({
  class_name: 'keyboard-layout',
  setup: self => self.hook(
    hyprland,
    (self, _, layout) => {
      if (!layout) {
        const kb = JSON.parse(exec('hyprctl devices -j')).keyboards;
        layout = kb.length ? kb[0].active_keymap : '??';
      }
      self.label = layout.slice(0, 2).toUpperCase();
    },
    'keyboard-layout'),
});

const cpu = Variable(0, {
  poll: [
    2000,
    'top -b -p 1 -n 1',
    out => {
      return out
        .split('\n')
        .find(line => line.includes('Cpu(s)'))
        .split(/\s+/)[1];
    }
  ],
});
const CpuUsage = Widget.Label({
  label: cpu.bind().as(usage => ` ${Math.round(usage)}%`),
});

const ram = Variable(0, {
  poll: [
    2000,
    'free',
    out => {
      const mem = out
        .split('\n')
        .find(line => line.startsWith('Mem:'))
        .split(/\s+/);
      return 100 * mem[2] / mem[1];
    }
  ]
});
const RamUsage = Widget.Label({
  label: ram.bind().as(usage => `󰘚 ${Math.round(usage)}%`),
});

const volumeStep = 0.05;
const Volume = Widget.EventBox({
  child: Widget.Box({
    class_name: 'volume',
    spacing: 4,
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
      Widget.Label().hook(audio.speaker, self => {
        const volume = Math.round(audio.speaker.volume * 100);
        self.label = `${volume}%`;
      }),
    ],
  }),
  onScrollUp: () => audio.speaker.volume += volumeStep,
  onScrollDown: () => audio.speaker.volume -= volumeStep,
  onPrimaryClick: () => audio.speaker.is_muted = !audio.speaker.is_muted,
  onSecondaryClick: () => audio.speaker.volume = 1.0,
});

const SysTray = Widget.Box({
  children: systemtray.bind('items').as(items =>
    items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind('icon') }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind('tooltip_markup'),
    })),
  ),
});

export const StatusBar = (monitor = 0) => Widget.Window({
  name: `statusbar-${monitor}`,
  class_name: 'statusbar',
  monitor,
  anchor: ['top', 'left', 'right'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    start_widget: Widget.Box({
      class_name: 'statusbar-left',
      hpack: 'start',
      spacing: 20,
      children: [
        Workspaces,
        // ClientTitle,
      ],
    }),
    center_widget: Widget.Box({
      class_name: 'statusbar-center',
      spacing: 20,
      children: [
        Clock,
      ],
    }),
    end_widget: Widget.Box({
      class_name: 'statusbar-right',
      hpack: 'end',
      spacing: 20,
      children: [
        KbLayout,
        CpuUsage,
        RamUsage,
        Volume,
        SysTray,
      ],
    }),
  }),
});
