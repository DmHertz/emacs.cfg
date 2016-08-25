;;(setq initial-frame-alist '((font . "Terminus-12")))
;;(setq default-frame-alist '((font . "Terminus-12")))

;; start

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;;(package-initialize)

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
      '(smex                ;;; |
        tramp               ;;; | connect to remote server via ssh
        dired+              ;;; | improved ancient file manager
        escreen             ;;; |
        edit-server         ;;; |
        dash                ;;; |
        lua-mode            ;;; | work with lua
        slime               ;;; | work with common lisp
        cider               ;;; | work with clojure
        cl-lib              ;;; | improve support CL features in .el
        neotree             ;;; | 
        solarized-emacs     ;;; | 
        smartparens         ;;; |
        switch-window       ;;; |
        emmet-mode          ;;; |
        company-mode        ;;; |
        company-statistics  ;;; |
        rainbow-delimiters  ;;; |
        websocket           ;;; | websocket support
        markdown-preview-mode ; | dynamic markdown 
        rainbow-mode        ;;; | colorize parens
        emacs-fish))        ;;; | fish shell support
;;; simple package names
(el-get-bundle pft/gimpmode)                ;;; script-fu support
(el-get-bundle clojure-emacs/inf-clojure)   ;;; inferior clojure
(el-get-bundle johnwalker/pixie-mode)       ;;; pixie-lang support
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
(require 'cl-lib) ;;; common lisp subset
(require 'dash)   ;;; clojure subset
;;; ----------------------------------------------------------------------------
(defun load-configs (lst)
  "Load configs recursively. To avoid conflicts between libraries and
configs names all config files must have «-cfg» suffix in it's own names."
  (when lst
    (-> lst car symbol-name (concat "-cfg") load-library) ;;; doesn't work without dash
;;;    (load-library (concat (symbol-name (car lst)) "-cfg"))
    (load-configs (cdr lst))))

;; load preferences
(add-to-list 'load-path "~/.emacs.d/conf/")
(load-configs
 '(global      ;;; some global setiings
   interface   ;;; iface settings, colour theme
   parens      ;;; smartparens, rainbow delimiters
   eshell      ;;; emacs shell 
   elisp       ;;; emacs lisp
   lisp        ;;; common lisp
   slime       ;;; slime and common lisp
;;;   clojure     ;;; clojure
   cider       ;;; cider and clojure
   racket      ;;; racket
   gimp        ;;; gimp-mode settings
   web         ;;; html5 and css settings
   fsharp      ;;; fsharp
   db          ;;; settings for access to databases
   keybindings ;;; global set keys for global cases
   custom      ;;; custom vars and faces
   backup      ;;; backup settings
   aliases))   ;;; short aliases of most often use commands


