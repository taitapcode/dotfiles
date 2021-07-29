/* Import */
#include <stddef.h>
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 25;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 25;       /* vert inner gap between windows */
static const unsigned int gappoh    = 25;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 25;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "FiraCode Nerd Font:size=12:antialias=true:autohint=true" };
static const char col_gray1[]       = "#0c1424";
static const char col_gray2[]       = "#222222";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_bg[]          = "#1b3aa1";
static const char col_border[]      = "#2156d1";
static const char *colors[][3]      = {
  /*               fg         bg         border   */
  [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
  [SchemeSel]  = { col_gray4, col_bg,  col_border  },
};

/* tagging */
/* static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }; */
/* static const char *tags[] = { "", "", "", "", "", "", "冷", "", "" }; */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
  /* xprop(1):
   *  WM_CLASS(STRING) = instance, class
   *  WM_NAME(STRING) = title
   */
  /* class              instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
  { "Gimp",             NULL,     NULL,           0,         1,          0,           0,        -1 },
  { "st-256color",      NULL,     NULL,           0,         0,          1,           0,        -1 },
  { NULL,               NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.5;  /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
  /* symbol   arrange function */
  { "Tiled",    tile },    /* first entry is default */
  { "Float",    NULL },    /* no layout function means floating behavior */
  { "Monocle",  monocle },
  { "Spiral",   spiral },
  { "[\\]",     dwindle },
  { "H[]",      deck },
  { "TTT",      bstack },
  { "===",      bstackhoriz },
  { "HHH",      grid },
  { "###",      nrowgrid },
  { "---",      horizgrid },
  { ":::",      gaplessgrid },
  { "|M|",      centeredmaster },
  { ">M>",      centeredfloatingmaster },
  { NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define CTRLKEY ControlMask
#define SHIFTKEY ShiftMask
#define TAGKEYS(KEY,TAG) \
  { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/bash", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_bg, "-sf", col_gray4, NULL };
static const char rofi_display_run[] =  "Run";
static const char *roficmd[] = { "rofi", "-show", "run", "-display-run", rofi_display_run, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browsercmd[]  = { "chromium", NULL };

#include "movestack.c"
static Key keys[] = {
  /* modifier                     key        function        argument */
  { MODKEY,                       XK_d,      spawn,          {.v = roficmd } },
  { MODKEY|SHIFTKEY,              XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_c,      spawn,          {.v = browsercmd } },
  { MODKEY|SHIFTKEY,              XK_f,      togglefullscr,  {0} },
  { MODKEY|SHIFTKEY,              XK_b,      togglebar,      {0} },
  { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
  { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
  { MODKEY,                       XK_p,      incnmaster,     {.i = -1 } },
  { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY|SHIFTKEY,              XK_j,      movestack,      {.i = +1 } },
  { MODKEY|SHIFTKEY,              XK_k,      movestack,      {.i = -1 } },
  { MODKEY,                       XK_Return, zoom,           {0} },
  { MODKEY|ALTKEY,                XK_u,      incrgaps,       {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_u,      incrgaps,       {.i = -1 } },
  { MODKEY|ALTKEY,                XK_i,      incrigaps,      {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_i,      incrigaps,      {.i = -1 } },
  { MODKEY|ALTKEY,                XK_o,      incrogaps,      {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_o,      incrogaps,      {.i = -1 } },
  { MODKEY|ALTKEY,                XK_6,      incrihgaps,     {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_6,      incrihgaps,     {.i = -1 } },
  { MODKEY|ALTKEY,                XK_7,      incrivgaps,     {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_7,      incrivgaps,     {.i = -1 } },
  { MODKEY|ALTKEY,                XK_8,      incrohgaps,     {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_8,      incrohgaps,     {.i = -1 } },
  { MODKEY|ALTKEY,                XK_9,      incrovgaps,     {.i = +1 } },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_9,      incrovgaps,     {.i = -1 } },
  { MODKEY|ALTKEY,                XK_0,      togglegaps,     {0} },
  { MODKEY|ALTKEY|SHIFTKEY,       XK_0,      defaultgaps,    {0} },
  { MODKEY,                       XK_Tab,    view,           {0} },
  { MODKEY|SHIFTKEY,              XK_c,      killclient,     {0} },
  { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_space,  setlayout,      {0} },
  { MODKEY|SHIFTKEY,              XK_space,  togglefloating, {0} },
  { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
  { MODKEY|SHIFTKEY,              XK_0,      tag,            {.ui = ~0 } },
  { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
  { MODKEY|SHIFTKEY,              XK_comma,  tagmon,         {.i = -1 } },
  { MODKEY|SHIFTKEY,              XK_period, tagmon,         {.i = +1 } },
  { MODKEY|SHIFTKEY,              XK_h,      setcfact,       {.f = +0.25} },
  { MODKEY|SHIFTKEY,              XK_l,      setcfact,       {.f = -0.25} },
  { MODKEY|SHIFTKEY,              XK_o,      setcfact,       {.f =  0.00} },
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
  { MODKEY|SHIFTKEY,              XK_q,      quit,           {0} },

  { MODKEY,                       XK_x,      spawn,          SHCMD("logout_menu") },

  { 0,          XF86XK_MonBrightnessUp,      spawn,          SHCMD("xbacklight -inc 10%") },
  { 0,          XF86XK_MonBrightnessDown,    spawn,          SHCMD("xbacklight -dec 10%") },

  { 0,          XF86XK_AudioRaiseVolume,     spawn,          SHCMD("amixer sset Master 5%+") },
  { 0,          XF86XK_AudioLowerVolume,     spawn,          SHCMD("amixer sset Master 5%-") },
  { 0,          XF86XK_AudioMute,            spawn,          SHCMD("amixer sset Master toggle") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
