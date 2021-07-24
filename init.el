;; -*- lexical-binding: t; -*-
(package-initialize)
(setq debug-on-error nil)

(defconst confdir (expand-file-name (concat user-emacs-directory "conf/")))
(defconst custom-file (concat confdir "custom-cfg.el")
  "custom-file, if set then customizations will be saved where it's set,
otherwise customizations will be saved to the end of init.el")
;; list of confings located at (concat user-emacs-directory "conf/")
(defvar conf-list)
;; list of required built-in or self-defined libraries
(defvar lib-list)
;; list of external libraries taken by el-get using predefined recipes
(defvar my:el-get-packages)
;; list of external libraries taken by el-get using self-defined recipes
(defvar el-get-gh-packages)
;; ----------------------------------------------------------------------------+
(defmacro slurp (fpath &optional fn)
  "opens a file and reads all its content, then returns it as a string"
  `(with-temp-buffer
     (insert-file-contents-literally ,fpath)
     ,(if fn
          `(funcall ,fn (buffer-string))
        `(buffer-string))))

(defun shortest-emacsdir-path (fpath)
  "returns the shortest filename at the user's emacs directory using wildcard"
  (car
   (sort (file-expand-wildcards
          (expand-file-name (concat user-emacs-directory fpath)))
         'string-greaterp)))

(defun exclude-entries (src-list exc-list)
  (if (null exc-list)
      src-list
    (exclude-entries (remove (car exc-list) src-list)
                     (cdr exc-list))))
;; set varialbes by filtered out lists of configs and external packages
(let ((cfg-pkg-list (read (slurp (shortest-emacsdir-path "list/conf.el"))))
      (exclusion-list (read (slurp (shortest-emacsdir-path "list/exclusions*.el")))))
  (condition-case err
      (let ((cfg-pkg-var-list (mapcar #'car cfg-pkg-list))
            (exclusion-var-list (mapcar #'car exclusion-list)))
        (if (equal cfg-pkg-var-list exclusion-var-list)
            (mapc (lambda (x)
                    (set x
                         (exclude-entries (cdr (assoc x cfg-pkg-list))
                                          (cdr (assoc x exclusion-list)))))
                  cfg-pkg-var-list)
          (error "%s and %s must have the same key values" 'cfg-pkg-list 'exclusion-list)))
    (error err)))

(defun read-lines (path)
  "reads a file's content, splits on \n then returns lines"
  (slurp path (lambda (str) (split-string str "\n" t))))
;; set exec-path by using exec-path*.txt values
(mapc (lambda (path) (add-to-list 'exec-path path))
      (read-lines (shortest-emacsdir-path "exec-path*.txt")))
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
