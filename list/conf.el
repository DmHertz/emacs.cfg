((conf-list   ;; |                                                 |                                                    
  global      ;; | some global settings                            |
  interface   ;; | interface settings, colour theme                |
  tex         ;; | AUCTeX                                          |
  erc         ;; | IRC settings                                    |
  dired       ;; | dired customizations                            |
  eww         ;; | eww settings                                    |
  parens      ;; | parentheses, rainbow delimiters                 |
  eshell      ;; | emacs shell                                     |
  elisp       ;; | emacs lisp                                      |
  slime       ;; | slime and common lisp                           |
  cider       ;; | cider and clojure                               |
  racket      ;; | racket                                          |
  rust        ;; | rust                                            |
  caml        ;; | ocaml                                           |
  c           ;; | c and cpp                                       |
  d           ;; | d language                                      |
  web         ;; | html5 and css settings                          |
  gimp        ;; | gimp-mode settings                              |
  fsharp      ;; | fsharp                                          |
  db          ;; | settings for access to databases                |
  org         ;; | org-mode settings                               |
  keybindings ;; | global set keys for global cases                |
  custom      ;; | custom vars and faces                           |
  backup      ;; | backup settings                                 |
  aliases)    ;; | short aliases of most often use commands        |
 ;; -------------+-------------------------------------------------+
 (lib-list           ; |                                           |
  cl-lib             ; | common lisp subset                        |
  dash               ; | clojure subset                            |
  erc-channels-mode) ; | erc-channels syntax highlighting          |
 ;; -------------------+-------------------------------------------+---------+
 (my:el-get-packages    ;; |                                                 |
  f                     ;; | modern API for working with files and dirs      |
  smex                  ;; | autocomplete an emacs commands in M-x menu      |
  magit                 ;; | an interface to git                             |
  ebuild-mode           ;; | Gentoo/Funtoo ebuild highlight                  |
  services-mode         ;; | An Emacs UI for managing init system services   |
  auctex                ;; | advanced TeX                                    |
  pdf-tools             ;; | provides fast rendering a pdf docs              |
  csv-mode              ;; | editing comma separated value files             |
  dired+                ;; | improved ancient file manager                   |
  image-dired+          ;; | create an image and image thumbnail viewer      |
  dired-k               ;; | highlighting dired buffer like k                |
  edit-server           ;; | editing textareas in Chromium                   |
  emacs-async           ;; | asynchronous processing in Emacs                |
  pos-tip               ;; | provides displaying a tooltip at mouse position |
  dash                  ;; | clojure subset in elisp                         |
  lua-mode              ;; | work with lua                                   |
  toml-mode             ;; | work with toml                                  |
  rust-mode             ;; | work with rust                                  |
  cargo                 ;; | allows rust package manager commands            |
  emacs-racer           ;; | rust autocompletion                             |
  flycheck-rust         ;; | rust fly syntax checking                        |
  haskell-mode          ;; | a mode for editing, debugging and developing hs |
  tuareg-mode           ;; | an emacs ocaml mode                             |
  d-mode                ;; | work with dlang                                 |
  irony-mode            ;; | a c and cpp minor mode powered by libclang      |
  irony-eldoc           ;; | integration with eldoc-mode                     |
  company-irony         ;; | company-mode's backend                          |
  flycheck              ;; | syntax checking                                 |
  flycheck-irony        ;; | flycheck's checker                              |
  geiser                ;; | emacs and scheme talk to each other             |
  cider                 ;; | work with clojure                               |
  cl-lib                ;; | improve support CL features in .el              |
  emacs-neotree         ;; | view directory tree of the current project      |
  solarized-emacs       ;; | my favorite color theme for Emacs               |
  smartparens           ;; | better support for operations on parens         |
  lispy                 ;; | a package which is used as a parinfer extension |
  paredit               ;; | a package which is used as a parinfer extension |
  switch-window         ;; | Offer a *visual* way to switch window           |
  systemd-mode          ;; | systemd units syntax support                    |
  emmet-mode            ;; | producing HTML from CSS-like selectors          |
  company-mode          ;; | a text completion framework                     |
  yasnippet             ;; | snippets support                                |
  popwin                ;; | Popup Window Manager for Emacs                  |
  swiper                ;; | compl. frontend, isearch with an overview       |
  company-statistics    ;; | company text completion statistics              |
  rainbow-delimiters    ;; | makes color difference between parens           |
  highlight-parentheses ;; | highlight surrounding parentheses               |
  websocket             ;; | websocket support                               |
  htmlize               ;; | Convert buffer text and decorations to HTML     |
  markdown-preview-mode ;; | dynamic markdown                                |
  rainbow-mode          ;; | colorize color names and buffers                |
  xterm-color           ;; | ANSI & xterm-256 color text property translator |
  dockerfile-mode       ;; | .Dockerfile support                             |
  yaml-mode             ;; | yaml config support                             |
  emacs-fish)           ;; | fish shell support                              |
 ;; -----------------------+-------------------------------------------------+
 (el-get-gh-packages          ;; |                                           |
  Wilfred/helpful             ;; | a better Emacs *help* buffer              |
  rukano/emacs-faust-mode     ;; | a major mode for editing faust code (dsp) |
  emacsmirror/rmsbolt         ;; | a compiler output viewer                  |
  clojure-emacs/inf-clojure   ;; | inferior clojure                          |
  greghendershott/racket-mode ;; | racket-lang support                       |
  emacs-pe/scribble-mode      ;; | scribble documents support                |
  emacs-lsp/lsp-mode          ;; | a client for the language server protocol |
  tsukimizake/company-dcd     ;; | company backend for DCD                   |
  atilaneves/flycheck-dmd-dub ;; | flycheck for d-mode                       |
  mrc/el-csv                  ;; | parse CSV data in elisp                   |
  ptrv/company-lua            ;; | completion backend for Lua                |
  DogLooksGood/parinfer-mode  ;; | improved parens support                   |
  pft/gimpmode                ;; | script-fu support                         |
  calancha/Gited              ;; | operate on Git branches like dired        |
  bcbcarl/emacs-wttrin        ;; | emacs frontend for a weather web service  |
  spline1986/fb2-mode))       ;; | fb2 support                               |
;; ------------------------------+-------------------------------------------+
