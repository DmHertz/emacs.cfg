;;; el-get
;;; dependencies
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq debug-on-error t)
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
;;; recipes
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; Simple package names
;;(el-get-bundle yasnippet)
;;(el-get-bundle color-moccur)

;; Locally defined recipe
;; (el-get-bundle yaicomplete
;;   :url "https://github.com/tarao/elisp.git"
;;   :features yaicomplete)

(setq my:el-get-packages
      '(smex
        escreen
        dash
        slime
        cider
        cl-lib
        neotree
        solarized-emacs
        smartparens
        switch-window
        company-mode
        company-statistics
        rainbow-delimiters
        rainbow-mode
        emacs-fish))

(el-get-bundle pft/gimpmode)
(el-get-bundle clojure-emacs/inf-clojure)
(el-get-bundle johnwalker/pixie-mode)

;; parinfer
;;(el-get-bundle edpaget/parinfer-mode)

;; With initialization code
;;(el-get-bundle zenburn-theme
;;  :url "https://raw.githubusercontent.com/bbatsov/zenburn-emacs/master/zenburn-theme.el"
;;    (load-theme 'zenburn t))

;;; sync
(el-get 'sync my:el-get-packages)
