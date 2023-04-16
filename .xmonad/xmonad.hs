-- Imports
import XMonad
import Data.Monoid
import System.Exit

import XMonad.Layout.Fullscreen ( fullscreenSupportBorder )
import XMonad.Hooks.ManageDocks ( avoidStruts, docks )
import XMonad.Hooks.ManageHelpers ( doCenterFloat )
import XMonad.Layout.Spacing ( spacingWithEdge )
import XMonad.Hooks.EwmhDesktops ( ewmh )
import XMonad.Util.SpawnOnce

import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- Defining applications
myTerminal      = "alacritty"

browser :: String
browser = "qutebrowser"

mPlayer :: String
mPlayer = "alacritty -e ncmpcpp"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myClickJustFocuses :: Bool
myClickJustFocuses = True

myBorderWidth   = 1

myModMask       = mod1Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8"]

myFocusedBorderColor  = "#fe8019"
myNormalBorderColor   = "#1B1D1E"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((controlMask,xK_space), spawn "rofi -terminal alacritty -show drun -icon-theme 'Papirus' -show-icons")

    -- launch music player
    , ((modm,xK_p), spawn (mPlayer))

    -- launch browser
    , ((modm,xK_b), spawn (browser))

    -- Brightness
    , ((controlMask.|.shiftMask,xK_Right), spawn "Brightness up")
    , ((controlMask.|.shiftMask,xK_Left),  spawn "Brightness down")

    -- Volume
    , ((controlMask.|.shiftMask,xK_Up),   spawn "$HOME/.local/bin/DunstVol up")
    , ((controlMask.|.shiftMask,xK_Down), spawn "$HOME/.local/bin/DunstVol down")
    , ((controlMask.|.shiftMask,xK_m),    spawn "$HOME/.local/bin/DunstVol mute")

    -- Dmenu Scripts
    , ((modm.|.shiftMask, xK_l), spawn"$HOME/.config/suckless/dmenu/scripts/dm-logout")
    , ((modm.|.shiftMask, xK_c), spawn"$HOME/.config/suckless/dmenu/scripts/dm-confedit")

    , ((0,xK_Print), spawn "scrot '%Y-%m-%d_%H-%M-%S.png' -e 'mv $f ~/Pictures/Screenshots/' -q 100")

    -- Toggle the polybar bar
     , ((modm.|.shiftMask, xK_b), spawn "polybar-msg cmd toggle ")

    -- close focused window
    , ((modm , xK_c), kill)

     -- Rotate through the available layout algorithms
    , ((modm,xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,xK_n), refresh)

    -- Move focus to the next window
    , ((modm,xK_h), windows W.focusDown)

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask,xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp)

    -- Shrink the master area
    , ((modm .|. shiftMask,xK_h), sendMessage Shrink)

    -- Expand the master area
    , ((modm .|. shiftMask,xK_t), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,xK_t), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm, xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")

    -- Moving between workspaces
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

-- MouseBindings
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w))
    -- , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w))
    ]

myLayout = avoidStruts(tiled) ||| Full
  where
     tiled   = spacingWithEdge 4 $ Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = composeAll
   [ className =? "Nm-applet"      --> doCenterFloat
    ,resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"      --> doIgnore ]

myEventHook = mempty

myLogHook = return ()

myStartupHook = do
  spawn     "~/.xmonad/polybar/launch.sh"
  spawnOnce "~/.fehbg &"
  spawnOnce "picom --vsync &"
  spawnOnce "nm-applet &"

main = xmonad $ docks .ewmh $ fullscreenSupportBorder $ def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
}
