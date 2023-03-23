import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import Data.Maybe ( fromJust )
import XMonad.Util.Cursor ( setDefaultCursor )
import XMonad.Hooks.ManageHelpers ( doCenterFloat )
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig ( additionalKeysP )
import XMonad.Util.NamedScratchpad

import Colors.DoomOne

import qualified XMonad.StackSet as W
import qualified Data.Map as M

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myClickJustFocuses :: Bool
myClickJustFocuses = True

myBorderWidth   = 1

myFocusedBorderColor  = "#fe8019"
myNormalBorderColor   = "#1B1D1E"

myModMask       = mod1Mask

myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 "]

myTerminal :: String
myTerminal = "alacritty"

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "ncmpcpp" spawnNcmpcpp findNcmpcpp manageNcmpcpp
                , NS "lf" spawnLf findLf manageLf
                , NS "term" spawnTerm findTerm manageTerm
                ]
  where
    spawnNcmpcpp  = myTerminal ++ " -t ncmpcpp -e ncmpcpp"
    findNcmpcpp   = title =? "ncmpcpp"
    manageNcmpcpp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.7
                 w = 0.7
                 t = 0.15
                 l = 0.15

    spawnLf  = myTerminal ++ " -t lf -e lf"
    findLf   = title =? "lf"
    manageLf = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

    spawnTerm  = myTerminal ++ " -t tmuxTerm -e tmux -u"
    findTerm   = title =? "tmuxTerm"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.95
                 w = 0.987
                 t = 0.042
                 l = 0.008

myKeys = [
  ("M-<Return>", spawn(myTerminal))
 ,("M-e", namedScratchpadAction myScratchPads "lf")
 ,("M-p", namedScratchpadAction myScratchPads "ncmpcpp")
 ,("M-`", namedScratchpadAction myScratchPads "term")
 ,("M-S-<Return>", windows W.swapMaster)
 ,("M-h", windows W.focusDown)
 ,("M-t", windows W.focusUp)

 ,("M-S-h", sendMessage Shrink)
 ,("M-S-t", sendMessage Expand)
 ,("M-S-n", refresh )

 --,("M-l", spawn "tmux select-pane -R")
 ,("M-l", spawn "tmux select-pane -L")
 ,("M-k", spawn "tmux select-pane -U")
 --,("M-j", spawn "tmux select-pane -D")
 ]

myLayout = avoidStruts (tiled) ||| Full
  where
     tiled   = spacingWithEdge 4 $ Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Nm-applet"      --> doCenterFloat
    , className =? "Gimp"           --> doCenterFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]<+> namedScratchpadManageHook myScratchPads

myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn     " sxhkd -m -1 -c ~/.xmonad/sxhkd/sxhkdrc"
  spawn     "~/.xmonad/polybar/launch.sh"
  spawnOnce "picom --vsync"
  --spawnOnce "sleep 10 && dunst"
  -- spawnOnce "mpd"
  spawnOnce "~/.fehbg"
  spawnOnce "nm-applet"

main = do
    xmonad $ docks .ewmh $ fullscreenSupport $ def {
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        startupHook        = myStartupHook
    }  `additionalKeysP` myKeys
