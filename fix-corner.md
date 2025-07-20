### fix corners with below code
- Add below to file using `vi ~/.themes/WhiteSur-Dark/gnome-shell/gnome-shell.css`

```css
.quick-settings,
.quick-toggle,
.popup-menu,
.popup-menu-boxpointer,
.popup-menu-content,
.slider,
.button,
.modal-dialog,
.calendar,
.calendar-box,
.notification-banner,
.message-dialog,
.menu,
.menu-boxpointer,
.network-dialog,
.bluetooth-dialog,
.aggregate-menu,
.system-menu,
.panel-button,
.osd-window,
.background,
.menu-button,
.toggle-button,
.dialog,
.top-bar,
.panel {
    border-radius: 6px !important;  /* Or 0px for full square */
}

```
