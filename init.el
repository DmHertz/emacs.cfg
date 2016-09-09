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

;; Locally defined recipe
;; (el-get-bundle yaicomplete
;;   :url "https://github.com/tarao/elisp.git"
;;   :features yaicomplete)

(setq my:el-get-packages
      '(smex                ;;; | autocomplete an emacs commands in M-x menu
        tramp               ;;; | connect to remote server via ssh
        dired+              ;;; | improved ancient file manager
        escreen             ;;; |
        edit-server         ;;; |
        emacs-jabber        ;;; | emacs jabber support
        dash                ;;; | clojure subset in elisp
        lua-mode            ;;; | work with lua
        slime               ;;; | work with common lisp
        cider               ;;; | work with clojure
        cl-lib              ;;; | improve support CL features in .el
        neotree             ;;; | view directory tree of the current project
        solarized-emacs     ;;; | my favorite color theme for Emacs
        smartparens         ;;; | better support for operations on parens
        switch-window       ;;; |
        emmet-mode          ;;; |
        company-mode        ;;; |
        company-statistics  ;;; |
        rainbow-delimiters  ;;; | makes color difference between parens
        websocket           ;;; | websocket support
        markdown-preview-mode ; | dynamic markdown 
        rainbow-mode        ;;; | colorize parens
        emacs-fish))        ;;; | fish shell support
;;; simple package names
;;; (el-get-bundle pft/gimpmode)                ;;; script-fu support
(el-get-bundle clojure-emacs/inf-clojure)   ;;; inferior clojure
;;; (el-get-bundle johnwalker/pixie-mode)       ;;; pixie-lang support
(el-get-bundle greghendershott/racket-mode) ;;; racket-lang support

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
      (mapcar
       (lambda (s) (intern (concat (symbol-name s) "-cfg")))
       '(global      ;;; some global setiings
         interface   ;;; iface settings, colour theme
         erc         ;;; IRC settings
         parens      ;;; smartparens, rainbow delimiters
         eshell      ;;; emacs shell 
         elisp       ;;; emacs lisp
         slime       ;;; slime and common lisp
         cider       ;;; cider and clojure
         racket      ;;; racket
         gimp        ;;; gimp-mode settings
         web         ;;; html5 and css settings
         fsharp      ;;; fsharp
         db          ;;; settings for access to databases
         keybindings ;;; global set keys for global cases
         custom      ;;; custom vars and faces
         backup      ;;; backup settings
         aliases)))  ;;; short aliases of most often use commands

;; requires
(defun require-config (config)
  (message "Loading %s..." config)
  (require config)
  (message "Loaded %s." config))
;;; load configs
(dolist (cfg conf-list)
  (load-library (symbol-name cfg)))
;; require all the configs automatically
(dolist (cfg (append '(cl-lib ;;; common lisp subset
                       dash)  ;;; clojure subset
                     conf-list))
  (require-config cfg))
