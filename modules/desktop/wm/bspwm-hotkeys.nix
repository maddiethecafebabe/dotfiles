{
  "super + alt + {q,r}" = {
    cmd = "bspc {quit,wm -r}";
    comment = "quit/restart bspwm";
  };

  "super + {_,shift + }w" = {
    cmd = "bspc node -{c,k}";
    comment = "close and kill";
  };

  "super + m" = {
    cmd = "bspc desktop -l next";
    comment = "alternate between the tiled and monocle layout";
  };

  "super + y" = {
    cmd = "bspc node newest.marked.local -n newest.!automatic.local";
    comment = "send the newest marked node to the newest preselected node";
  };

  "super + g" = {
    cmd = "bspc node -s biggest.window";
    comment = "swap the current node and the biggest window";
  };

  # state/flags

  "super + {t,shift + t,s,f}" = {
    cmd = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
    comment = "set the window state";
  };

  "super + ctrl + {m,x,y,z}" = {
    cmd = "bspc node -g {marked,locked,sticky,private}";
    comment = "set the node flags";
  };

  # focus/swap

  "super + {_,shift + }{h,j,k,l}" = {
    cmd = "bspc node -{f,s} {west,south,north,east}";
    comment = "focus the node in the given direction";
  };

  "super + {p,b,comma,period}" = {
    cmd = "bspc node -f @{parent,brother,first,second}";
    comment = "focus the node for the given path jump";
  };

  "super + {_,shift + }c" = {
    cmd = "bspc node -f {next,prev}.local.!hidden.window";
    comment = "focus the next/previous window in the current desktop";
  };

  "super + bracket{left,right}" = {
    cmd = "bspc desktop -f {prev,next}.local";
    comment = "focus the next/previous desktop in the current monitor";
  };

  "super + {grave,Tab}" = {
    cmd = "bspc {node,desktop} -f last";
    comment = "focus the last node/desktop";
  };

  "super + {o,i}" = {
    cmd = ''      bspc wm -h off; \
      	bspc node {older,newer} -f; \
      	bspc wm -h on'';
    comment = "focus the older or newer node in the focus history";
  };

  "super + {_,shift + }{1-9,0}" = {
    cmd = "bspc {desktop -f,node -d} '^{1-9,10}'";
    comment = "focus or send to the given desktop";
  };

  # preselect

  "super + ctrl + {h,j,k,l}" = {
    cmd = "bspc node -p {west,south,north,east}";
    comment = "preselect the direction";
  };

  "super + ctrl + {1-9}" = {
    cmd = "bspc node -o 0.{1-9}";
    comment = "preselect the ratio";
  };

  "super + ctrl + space" = {
    cmd = "bspc node -p cancel";
    comment = "cancel the preselection for the focused node";
  };

  "super + ctrl + shift + space" = {
    cmd = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
    comment = "cancel the preselection for the focused desktop";
  };

  # move/resize

  "super + ctrl + alt + {Left,Down,Up,Right}" = {
    cmd = ''      n=10; \
        { d1=left;   d2=right;  dx=-$n; dy=0;   \
        , d1=bottom; d2=top;    dx=0;   dy=$n;  \
        , d1=top;    d2=bottom; dx=0;   dy=-$n; \
        , d1=right;  d2=left;   dx=$n;  dy=0;   \
        } \
        bspc node --resize $d1 $dx $dy || bspc node --resize $d2 $dx $dy'';
    comment = "Smart resize, will grow or shrink depending on location.";
  };

  "super + {Left,Down,Up,Right}" = {
    cmd = "bspc node -v {-20 0,0 20,0 -20,20 0}";
    comment = "move a floating window";
  };
}
