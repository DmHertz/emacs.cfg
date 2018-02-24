;; -*- lexical-binding: t; -*-
;; (package-initialize)
(setq
 debug-on-error nil
 confdir (expand-file-name (concat user-emacs-directory "conf/"))
 ;;; custom-file, if set then customizations will be
 ;;; saved where it's set, otherwise customizations
 ;;; will be saved to the end of init.el
 custom-file (concat confdir "custom-cfg.el")
 ;; cfg, lib, el-get pkgs   +-------------------------------------------------+
 conf-list '(global      ;; | some global settings                            |
             interface   ;; | interface settings, colour theme                |
             erc         ;; | IRC settings                                    |
             dired       ;; | dired customizations                            |
             eww         ;; | eww settings                                    |
             parens      ;; | smartparens, rainbow delimiters                 |
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
 lib-list                ;; +-------------------------------------------------+
 '(cl-lib                ;; | common lisp subset                              |
   dash                  ;; | clojure subset                                  |
   erc-channels-mode)    ;; | erc-channels syntax highlighting                |
 my:el-get-packages      ;; +-------------------------------------------------+
 '(f                     ;; | modern API for working with files and dirs      |
   smex                  ;; | autocomplete an emacs commands in M-x menu      |
   magit                 ;; | an interface to git                             |
   services-mode         ;; | An Emacs UI for managing init system services   |
   pdf-tools             ;; | provides fast rendering a pdf docs              |
   csv-mode              ;; | editing comma separated value files             |
   dired+                ;; | improved ancient file manager                   |
   image-dired+          ;; | create an image and image thumbnail viewer      |
   dired-k               ;; | highlighting dired buffer like k                |
   edit-server           ;; | editing textareas in Chromium                   |
   emacs-async           ;; | asynchronous processing in Emacs                |
   emacs-jabber          ;; | emacs jabber support                            |
   dash                  ;; | clojure subset in elisp                         |
   lua-mode              ;; | work with lua                                   |
   toml-mode             ;; | work with toml                                  |
   rust-mode             ;; | work with rust                                  |
   cargo                 ;; | allows rust package manager commands            |
   emacs-racer           ;; | rust autocompletion                             |
   flycheck-rust         ;; | rust fly syntax checking                        |
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
   switch-window         ;; | Offer a *visual* way to switch window           |
   systemd-mode          ;; | systemd units syntax support                    |
   emmet-mode            ;; | producing HTML from CSS-like selectors          |
   company-mode          ;; | a text completion framework                     |
   yasnippet             ;; | snippets support                                |
   popwin                ;; | Popup Window Manager for Emacs                  |
   swiper                ;; | compl. frontend, isearch with an overview       |
   company-statistics    ;; | company text completion statistics              |
   rainbow-delimiters    ;; | makes color difference between parens           |
   websocket             ;; | websocket support                               |
   htmlize               ;; | Convert buffer text and decorations to HTML     |
   markdown-preview-mode ;; | dynamic markdown                                |
   rainbow-mode          ;; | colorize color names and buffers                |
   xterm-color           ;; | ANSI & xterm-256 color text property translator |
   emacs-fish)           ;; | fish shell support                              |
 el-get-gh-packages      ;; +-----+-------------------------------------------+
'(Wilfred/helpful              ;; | a better Emacs *help* buffer              |
  clojure-emacs/inf-clojure    ;; | inferior clojure                          |
  greghendershott/racket-mode  ;; | racket-lang support                       |
  emacs-lsp/lsp-mode           ;; | a client for the language server protocol |
  tsukimizake/company-dcd      ;; | company backend for DCD                   |
  atilaneves/flycheck-dmd-dub  ;; | flycheck for d-mode                       |
  mrc/el-csv                   ;; | parse CSV data in elisp                   |
  ptrv/company-lua             ;; | completion backend for Lua                |
  edpaget/parinfer-mode        ;; | improved parens support                   |
  pft/gimpmode                 ;; | script-fu support                         |
  calancha/Gited               ;; | operate on Git branches like dired        |
  bcbcarl/emacs-wttrin         ;; | emacs frontend for a weather web service  |
  spline1986/fb2-mode))        ;; | fb2 support                               |
;; --------------------------- ;; +-------------------------------------------+
(defmacro slurp (fpath &optional fn)
  "opens a file and reads all its content, then returns it as a string"
  `(with-temp-buffer
     (insert-file-contents ,fpath)
     ,(if fn
          `(funcall ,fn (buffer-string))
        `(buffer-string))))

(defun shortest-filename (fpath)
  "returns the shortest filename using wildcard"
  (car
   (sort (file-expand-wildcards
          (expand-file-name (concat user-emacs-directory fpath)))
         'string-greaterp)))

;; exclude packages and configs mentioned in exclusions.el
(let ((exclusion-list
       (read (slurp (shortest-filename "exclusions*.el")))))
  (mapc (lambda (seq)
          (let ((var (car seq)))
            (mapc (lambda (key)
                    ;;(set var (delete key (symbol-value var)))
                    (delete key (symbol-value var)))
                  (cdr seq))))
        exclusion-list))

(defun read-lines (path)
  "reads a file's content, splits on \n then returns lines"
  (slurp path (lambda (str) (split-string str "\n" t))))
;; set exec-path by using exec-path*.txt values
(mapc (lambda (path) (add-to-list 'exec-path path))
        (read-lines (shortest-filename "exec-path*.txt")))
;; try to init and launch el-get
(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))
;;; use el-get and download it if not found
(unless (require 'el-get nil 'noerror)
 (with-current-buffer
  (url-retrieve-synchronously
   "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
  (goto-char (point-max))
  (eval-print-last-sexp)))
;;; el-get recipes
(add-to-list 'el-get-recipe-path
             (expand-file-name (concat user-emacs-directory
                                       "el-get-user/recipes")))
;; a small helper
(defmacro el-get-bundles-from-github ()
  "generates a list of calls (el-get-bundle author/package)"
  `(progn
     ,@(mapcar (lambda (p) `(el-get-bundle ,p)) el-get-gh-packages)))
;; synchronize packages
(el-get 'sync my:el-get-packages)
;; from github directly
(el-get-bundles-from-github)
;; requires
(defun require-config (config)
  (message "Loading %s..." config)
  (require config)
  (message "Loaded %s." config))
;;; add confdir to load-path
(add-to-list 'load-path confdir)
;; suffix-appending
(defun append-sym-postfix (sym postfix-str)
  "append postfix to symbol"
  (intern (concat (symbol-name sym) postfix-str)))
;; require all the configs automatically
(seq-doseq (lib (append lib-list
                        ;; define the config names: to avoid potential conflicts
                        ;; between libraries and the config names
                        ;; all the latest have «-cfg» suffix
                        (mapcar (lambda (sym)
                                  "append -cfg postfix to symbol"
                                  (append-sym-postfix sym "-cfg"))
                                conf-list)))
  (require-config lib))
