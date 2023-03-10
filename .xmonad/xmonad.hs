import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
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

-- Imports for polybar in XMonad
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

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
                , NS "vi" spawnVi findVi manageVi
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

    spawnVi  = myTerminal ++ " -t vi -e vi -X"
    findVi   = title =? "vi"
    manageVi = customFloating $ W.RationalRect l t w h
               where
                 h = 0.95
                 w = 0.987
                 t = 0.042
                 l = 0.008

myKeys = [
  ("M-<Return>", spawn(myTerminal))
 ,("M-e", namedScratchpadAction myScratchPads "lf")
 ,("M-p", namedScratchpadAction myScratchPads "ncmpcpp")
 ,("M-`", namedScratchpadAction myScratchPads "vi")
 ,("M-S-<Return>", windows W.swapMaster)
 ,("M-h", windows W.focusDown)

 ,("M-S-h", sendMessage Shrink)
 ,("M-S-t", sendMessage Expand)
 ]

myLayout = avoidStruts (tiled) ||| Full
  where
     tiled   = spacingWithEdge 4 $ Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Nm-applet"         --> doCenterFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]<+> namedScratchpadManageHook myScratchPads

myLogHook :: D.Client -> PP
myLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{B" ++ color03 ++ "}") "%{B-}"
    , ppVisible = wrap ("%{F" ++ color03 ++ "} ") " %{F-}"
    , ppHidden = wrap """"
    --, ppHiddenNoWindows = wrap ("%{F" ++ color15 ++ "} ") " %{F-}"
    , ppWsSep = " "
    , ppSep = " "
    , ppOrder = \(ws:l:ex) -> [ws]
    }
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawn     " sxhkd -m -1 -c ~/.xmonad/sxhkd/sxhkdrc"
  spawn     "~/.xmonad/polybar/launch.sh"
  spawnOnce "picom"
  -- spawnOnce "sleep 10 && dunst"
  spawnOnce "mpd"
  spawnOnce "~/.fehbg"
  spawn "nm-applet"

main = do
    dbus <- D.connectSession
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
    xmonad $ docks $ fullscreenSupport $ defaults { logHook = dynamicLogWithPP (myLogHook dbus) }`additionalKeysP` myKeys

defaults = def {
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
    }
