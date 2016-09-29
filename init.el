(package-initialize)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get") ;;; | load el-get
(setq debug-on-error nil)                           ;;; | 
;;; use el-get and download it if not found
;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; using el-get via melpa
(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))
;;; recipes 
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; Locally defined recipe
;; (el-get-bundle yaicomplete
;;   :url "https://github.com/tarao/elisp.git"
;;   :features yaicomplete)

(setq my:el-get-packages
      '(smex                ;;; | autocomplete an emacs commands in M-x menu
        pdf-tools           ;;; | provides fast rendering a pdf docs
        tramp               ;;; | connect to remote server via ssh
        dired+              ;;; | improved ancient file manager
        image-dired+        ;;; | create an image and image thumbnail viewer
        dired-k             ;;; | highlighting dired buffer like k
        edit-server         ;;; | editing textareas in Chromium
        emacs-jabber        ;;; | emacs jabber support
        dash                ;;; | clojure subset in elisp
        lua-mode            ;;; | work with lua
        slime               ;;; | work with common lisp
        cider               ;;; | work with clojure
        cl-lib              ;;; | improve support CL features in .el
        emacs-neotree       ;;; | view directory tree of the current project
        solarized-emacs     ;;; | my favorite color theme for Emacs
        smartparens         ;;; | better support for operations on parens
        switch-window       ;;; | Offer a *visual* way to choose a window to switch to
        systemd-mode        ;;; | systemd units syntax support
        emmet-mode          ;;; | producing HTML from CSS-like selectors
        company-mode        ;;; | a text completion framework
        company-statistics  ;;; | company text completion statistics
        rainbow-delimiters  ;;; | makes color difference between parens
        websocket           ;;; | websocket support
        markdown-preview-mode ; | dynamic markdown 
        rainbow-mode        ;;; | colorize parens
        emacs-fish))        ;;; | fish shell support
;;; simple package names
;;; (el-get-bundle pft/gimpmode)                ;;; | script-fu support
;;; (el-get-bundle johnwalker/pixie-mode)       ;;; | pixie-lang support
(el-get-bundle clojure-emacs/inf-clojure)   ;;; | inferior clojure
(el-get-bundle greghendershott/racket-mode) ;;; | racket-lang support
;;;(el-get-bundle cask/cask)                   ;;; | project management tool for emacs
;;;(el-get-bundle skeeto/emacsql)

;; parinfer
;;(el-get-bundle edpaget/parinfer-mode)   ;;; I don't understood how it use

;; With initialization code
;;(el-get-bundle zenburn-theme
;;  :url "https://raw.githubusercontent.com/bbatsov/zenburn-emacs/master/zenburn-theme.el"
;;    (load-theme 'zenburn t))

;;; sync
(el-get 'sync my:el-get-packages)
;;; ----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/conf/")
;;"Load configs. To avoid conflicts between libraries and
;; configs names all config files must have «-cfg» suffix in it's own names."
(defvar conf-list
  (append
   '(cl-lib          ;;; | common lisp subset
     dash)           ;;; | clojure subset)
   (mapcar
       (lambda (s) (intern (concat (symbol-name s) "-cfg")))
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
;;;         gimp        ;;; | gimp-mode settings
;;;         fsharp      ;;; | fsharp
         db          ;;; | settings for access to databases
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-generic))
 '(cider-cljs-lein-repl
   "(do (require 'weasel.repl.websocket) 
    (cemerick.piggieback/cljs-repl
      (weasel.repl.websocket/repl-env :ip \"127.0.0.1\" :port 9001)))" t)
 '(markdown-command "multimarkdown")
 '(package-selected-packages (quote (rainbow-mode queue)))
 '(racket-images-inline t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-delimiter-face ((t (:foreground "#222222" :slant normal))))
 '(linum ((t (:background "#000000" :foreground "#003366"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#FF4C00"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#FFFF00"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#FF0000"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#00FF00"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#EEEEEE"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#0066FF"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#9900FF"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#00FFFF"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#00CC33")))))
