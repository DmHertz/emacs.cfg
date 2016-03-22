;; start
(require 'cl-lib)  ;;; common lisp subset

(defun load-configs (lst)
  "Load configs recursively. To avoid conflicts between libraries and
configs names all config files must have «-cfg» suffix in it's own names."
  (when lst
;;;    (-> lst car symbol-name (concat "-cfg") load-library) ;;; doesn't work without dash
    (load-library (concat (symbol-name (car lst)) "-cfg"))
    (load-configs (cdr lst))))

;; load preferences
(add-to-list 'load-path "~/.emacs.d/conf/")
(load-configs
 '(el-get      ;;; best package manager, must to be init first
   global      ;;; some global setiings
   interface   ;;; iface settings, colour theme
   parens      ;;; smartparens, rainbow delimiters
   eshell      ;;; emacs shell 
   elisp       ;;; emacs lisp
   lisp        ;;; common lisp
   slime       ;;; slime and common lisp
   clojure     ;;; clojure
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
