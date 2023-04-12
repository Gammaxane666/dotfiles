from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, DropDown
from libqtile.lazy import lazy
import os
import subprocess
from libqtile import hook, bar
from libqtile.dgroups import simple_key_binder
import colors
colors, backgroundColor, foregroundColor, workspaceColor, chordColor = colors.gruvbox()


mod = "mod1"

keys = [
    Key([mod], "h", lazy.layout.next(), desc="Switch focus"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "q", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    # Key([mod], "e", lazy.group['scratchpad'].dropdown_toggle('lf')),
    # Key([mod], "p", lazy.group['scratchpad'].dropdown_toggle('ncmpcpp')),
    # Key([mod], "v", lazy.group['scratchpad'].dropdown_toggle('vi')),
]

groups = [Group("1", layout='MonadTall'),
          Group("2", layout='MonadTall'),
          Group("3", layout='MonadTall'),
          Group("4", layout='MonadTall'),
          Group("5", layout='MonadTall'),
          Group("6", layout='MonadTall'),
          Group("7", layout='MonadTall'),
          Group("8", layout='MonadTall')]

dgroups_key_binder = simple_key_binder(mod)

# groups.append(ScratchPad('scratchpad', [
#     DropDown('lf', 'alacritty -e lf', width=0.8, height=0.8, x=0.1, y=0.1, opacity=0.9),
#     DropDown('ncmpcpp', 'alacritty -e ncmpcpp', width=0.75, height=0.75, x=0.13, y=0.1, opacity=0.9),
#     DropDown('vi', 'alacritty -e vi', width=0.98, height=0.98, x=0.01, y=0.01, opacity=0.9),
# ]))

layouts = [
    layout.MonadTall(
        margin=8,
        border_width=1,
        border_focus="#fe8019",
        border_normal="#000000"
    ),
    layout.Max()
]

widget_defaults = dict(
    font="JetBrains Mono Nerd Font",
    fontsize=14,
    padding=5,
    background="#1d2021"
)


def init_widgets_list(monitor_num):
    widgets_list = [
        widget.GroupBox(
            font="JetBrainsMono Nerd Font",
            fontsize=14,
            margin_y=2,
            margin_x=4,
            padding_y=6,
            padding_x=6,
            borderwidth=2,
            disable_drag=True,
            active=colors[2],
            inactive=colors[1],
            hide_unused=False,
            rounded=False,
            highlight_method="line",
            highlight_color=[backgroundColor, backgroundColor],
            this_current_screen_border=colors[10],
            this_screen_border=colors[7],
            other_screen_border=colors[6],
            other_current_screen_border=colors[6],
            urgent_alert_method="line",
            urgent_border=colors[9],
            urgent_text=colors[1],
            foreground=foregroundColor,
            background=colors[0],
            use_mouse_wheel=False
        ),

        widget.Sep(linewidth=0, padding=760,
                   foreground=colors[5], background=colors[0]),

        widget.TextBox(text=" ", fontsize=16,
                       font="Font Awesome 6 Free Solid", padding=0, foreground=colors[7]),

        widget.CPU(
            font="JetBrainsMono Nerd Font",
            update_interval=2,
            format='{load_percent}%',
            foreground=foregroundColor,
            padding=5
        ),

        widget.Sep(linewidth=0, padding=15),

        widget.TextBox(text="", padding=0, fontsize=16,
                       font="Font Awesome 6 Free Solid", foreground=colors[3]),

        widget.Memory(
            font="JetBrainsMonoNerdFont",
            foreground=foregroundColor,
            format='{MemUsed: .0f}{mm}',
            measure_mem='M',
            padding=0,
            update_interval=2
        ),
        widget.Sep(linewidth=0, padding=20),

        widget.TextBox(text="", fontsize=18, padding=0,
                       font="Font Awesome 6 Free Solid", foreground=colors[11]),

        widget.Battery(
            format='{percent:2.0%} {char}',
            font="JetBrainsMono Nerd Font",
            padding=10,
            foreground=foregroundColor,
            full_char='(o)',
            charge_char='(+)',
            discharge_char='(-)',
            unknown_char='(?)',
            update_interval=2
        ),

        widget.Sep(linewidth=0, padding=10),

        widget.TextBox(text="", fontsize=16, padding=0,
                       font="Font Awesome 6 Free Solid", foreground=colors[10]),

        widget.Clock(format='%I:%M %p', font="JetBrainsMono Nerd Font",
                     padding=10, foreground=foregroundColor),

        widget.Systray(background=backgroundColor, icon_size=30, padding=0),
        widget.Sep(linewidth = 1, padding = 5, foreground = colors[0], background = backgroundColor),
        # widget.CurrentLayoutIcon(scale = 0.5, foreground = colors[6], background = colors[6]),
    ]

    return widgets_list


extension_defaults = widget_defaults.copy()

widgets_list = init_widgets_list("1")
screens = [
    Screen(top=bar.Bar(widgets=widgets_list, size=28,
           background=backgroundColor, margin=0, opacity=1),),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=1,
    border_focus="#fe8019",
    border_normal="#000000",
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
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None


@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])


wmname = "Qtile"
