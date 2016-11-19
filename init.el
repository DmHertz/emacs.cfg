(package-initialize)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get") ;;; | load el-get
(setq debug-on-error nil)                           ;;; | 
;;; use el-get and download it if not found
(unless (require 'el-get nil 'noerror)
 (with-current-buffer
  (url-retrieve-synchronously
   "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
  (goto-char (point-max))
  (eval-print-last-sexp)))
;;; recipes 
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; a small helper
(defmacro el-get-bundles-from-github (&rest egdb)
  "generates a list of calls (el-get-bundle author/package)"
  (cons 'progn
        (mapcar (lambda (p) `(el-get-bundle ,p)) egdb)))
;; list of required packages
(setq my:el-get-packages     ;; +----------------------------------------------+
      '(f                    ;; | modern API for working with files and dirs   |
        smex                 ;; | autocomplete an emacs commands in M-x menu   |
        magit                ;; | an interface to git                          |
        pdf-tools            ;; | provides fast rendering a pdf docs           |
        dired+               ;; | improved ancient file manager                |
        image-dired+         ;; | create an image and image thumbnail viewer   |
        dired-k              ;; | highlighting dired buffer like k             |
        edit-server          ;; | editing textareas in Chromium                |
        emacs-jabber         ;; | emacs jabber support                         |
        dash                 ;; | clojure subset in elisp                      |
        lua-mode             ;; | work with lua                                |
        rust-mode            ;; | work with rust                               |
        cargo                ;; | allows rust package manager commands         |
;;      slime                ;; | work with common lisp                        |
        cider                ;; | work with clojure                            |
        cl-lib               ;; | improve support CL features in .el           |
        emacs-neotree        ;; | view directory tree of the current project   |
        solarized-emacs      ;; | my favorite color theme for Emacs            |
        smartparens          ;; | better support for operations on parens      |
        switch-window        ;; | Offer a *visual* way to switch window        |
        systemd-mode         ;; | systemd units syntax support                 |
        emmet-mode           ;; | producing HTML from CSS-like selectors       |
        company-mode         ;; | a text completion framework                  |
;;      company-statistics   ;; | company text completion statistics           |
        slime-company        ;; | company completion for slime                 |
        rainbow-delimiters   ;; | makes color difference between parens        |
        websocket            ;; | websocket support                            |
        htmlize              ;; | Convert buffer text and decorations to HTML  |
        markdown-preview-mode ; | dynamic markdown                             |
        rainbow-mode         ;; | colorize parens                              |
        emacs-fish))         ;; | fish shell support                           |       
(el-get-bundles-from-github  ;; +----------------------------------------------+
 clojure-emacs/inf-clojure   ;; | inferior clojure                             |
 greghendershott/racket-mode ;; | racket-lang support                          |
 ptrv/company-lua            ;; | completion backend for Lua                   |
 ;; edpaget/parinfer-mode    ;; | improved parens support                      |
 ;; pft/gimpmode             ;; | script-fu support                            |
 spline1986/fb2-mode)        ;; | fb2 support                                  |
;; synchronize packages      ;; +----------------------------------------------+
(el-get 'sync my:el-get-packages)
;;; set confdir and add it to load-path
(setq confdir "~/.emacs.d/conf/")
(add-to-list 'load-path confdir)
;;; custom-file, if set then customizations will be
;;; saved where it's set, otherwise its will be saved
;;; to the end of init.el
(setq custom-file (concat confdir "custom-cfg.el"))
;; useful util
(defun append-sym-postfix (sym postfix-str)
  "append postfix to symbol"
  (intern (concat (symbol-name sym) postfix-str)))
;;"Load configs. To avoid conflicts between libraries and
;; configs names all config files must have «-cfg» suffix in it's own names."
(defvar conf-list
  (append
   '(cl-lib       ;;; | common lisp subset
     dash)        ;;; | clojure subset
   (mapcar
    (lambda (s)
      "append -cfg postfix to symbol"
      (append-sym-postfix s "-cfg"))
    '(global      ;;; | some global setiings
      interface   ;;; | iface settings, colour theme
      erc         ;;; | IRC settings
      dired       ;;; | dired customizations
      eww         ;;; | eww settings
      parens      ;;; | smartparens, rainbow delimiters
      eshell      ;;; | emacs shell 
      elisp       ;;; | emacs lisp
      slime       ;;; | slime and common lisp
      cider       ;;; | cider and clojure
      racket      ;;; | racket
      web         ;;; | html5 and css settings
;;    gimp        ;;; | gimp-mode settings
;;    fsharp      ;;; | fsharp
      db          ;;; | settings for access to databases
      org         ;;; | org-mode settings
      keybindings ;;; | global set keys for global cases
      custom      ;;; | custom vars and faces
      backup      ;;; | backup settings
      aliases)))) ;;; | short aliases of most often use commands

;; requires
(defun require-config (config)
  (message "Loading %s..." config)
  (require config)
  (message "Loaded %s." config))
;; require all the configs automatically
(seq-doseq (cfg conf-list)
  (require-config cfg))

(load-library "erc-channels-mode")
(require 'erc-channels-mode)
