import Gtk from "gi://Gtk?version=3.0";

export const RoundedCorner = (anchor, r = 25) => {
  const isTop = anchor.includes('top');
  const isLeft = anchor.includes('left');
  return Widget.DrawingArea({
    class_name: 'corner',
    hpack: isTop ? 'start' : 'end',
    vpack: isLeft ? 'start' : 'end',
    setup: self => {
      self.set_size_request(r, r);
      self.on('draw', (self, cr) => {
        const c = self.get_style_context().get_property('background-color', Gtk.StateFlags.NORMAL);
        const r = self.get_style_context().get_property('border-radius', Gtk.StateFlags.NORMAL);
        self.set_size_request(r, r);

        if (isTop) {
          if (isLeft) {
            cr.arc(r, r, r, Math.PI, Math.PI * 1.5);
            cr.lineTo(0, 0);
          } else {
            cr.arc(0, r, r, Math.PI * 1.5, Math.PI * 2);
            cr.lineTo(r, 0);
          }
        } else {
          if (isLeft) {
            cr.arc(r, 0, r, Math.PI * 0.5, Math.PI);
            cr.lineTo(0, r);
          } else {
            cr.arc(0, 0, r, 0, Math.PI * 0.5);
            cr.lineTo(r, r);
          }
        }

        cr.closePath();
        cr.setSourceRGBA(c.red, c.green, c.blue, c.alpha);
        cr.fill();
      });
    }
  });
}

export const MonitorRoundedCorner = (monitor, anchor) => Widget.Window({
  name: `corner-${anchor.join('-')}-${monitor}`,
  css: 'background-color: transparent',
  layer: 'top',
  monitor,
  anchor,
  exclusivity: 'normal',
  visible: true,
  child: RoundedCorner(anchor),
});

export const MonitorRoundedCorners = (monitor = 0) => [
  MonitorRoundedCorner(monitor, ['top', 'left']),
  MonitorRoundedCorner(monitor, ['top', 'right']),
  MonitorRoundedCorner(monitor, ['bottom', 'left']),
  MonitorRoundedCorner(monitor, ['bottom', 'right']),
];

export default MonitorRoundedCorner;
