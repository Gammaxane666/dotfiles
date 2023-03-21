from libqtile import bar, layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
import os
import subprocess
from libqtile import hook, bar
from libqtile.dgroups import simple_key_binder

mod = "mod1"

keys = [
    Key([mod], "h", lazy.layout.next(),desc="Switch focus"),
    Key([mod, "shift"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "t", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "q", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "e", lazy.group['scratchpad'].dropdown_toggle('lf')),
    Key([mod], "p", lazy.group['scratchpad'].dropdown_toggle('ncmpcpp')),
    Key([mod], "v", lazy.group['scratchpad'].dropdown_toggle('vi')),
]

groups = [Group("1", layout='MonadTall'),
          Group("2", layout='MonadTall'),
          Group("3", layout='MonadTall'),
          Group("4", layout='MonadTall'),
          Group("5", layout='MonadTall'),
          Group("6", layout='MonadTall'),
          Group("7", layout='MonadTall'),
          Group("8", layout='MonadTall'),
          Group("9", layout='MonadTall')]

dgroups_key_binder = simple_key_binder(mod)

groups.append(ScratchPad('scratchpad', [
    DropDown('lf', 'alacritty -e lf', width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
    DropDown('ncmpcpp', 'alacritty -e ncmpcpp', width=0.75, height=0.75, x=0.13, y=0.1, opacity=0.9),
    DropDown('vi', 'alacritty -e vi', width=0.98, height=0.98, x=0.01, y=0.01, opacity=0.9),
]))

layouts = [
    layout.MonadTall(
        margin = 9,
        border_width = 1,
        border_focus = "#fe8019",
        border_normal = "#000000"
    ),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Gap(30)
        )
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width = 1,
    border_focus = "#fe8019",
    border_normal = "#000000",
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
# focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wl_input_rules = None

@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

wmname = "LG3D"
