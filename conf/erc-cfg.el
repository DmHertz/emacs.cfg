;;; erc-cfg.el --- irc chatting support by erc       -*- lexical-binding: t; -*-

;; Copyright (C) 2016  

;; Author:  <hz@hz4530s.localdomain>
;; Keywords: comm

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;  Emacs IRC configuration

(require 'erc)
(require 'erc-log)
;;(require 'erc-spelling)
(require 'erc-autoaway)

(setq erc-user-full-name "Dmitry Buhaev"        ;; share my real name
      erc-server-coding-system '(utf-8 . utf-8) ;; utf-8 always and forever
      erc-autojoin-timing 'ident
      erc-autojoin-channels-alist (ercchannels "~/.erc/channels")      
      ;; Interpret mIRC-style color commands in IRC chats
      erc-interpret-mirc-color t
      ;; The following are commented out by default, but users of other
      ;; non-Emacs IRC clients might find them useful.
      ;; Kill buffers for channels after /part
      erc-kill-buffer-on-part t
      ;; Kill buffers for private queries after quitting the server
      erc-kill-queries-on-quit t
      ;; Kill buffers for server messages after quitting the server
      erc-kill-server-buffer-on-quit t
      ;; open query buffers in the current window
      erc-query-display 'buffer
      erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477")
      ;; logging:
      erc-log-enable t
      erc-log-file-coding-system 'utf-8
      erc-log-insert-log-on-open nil
      erc-log-channels t
      erc-log-channels-directory "~/.erc/logs/"
      erc-save-buffer-on-part t
      erc-hide-timestamps nil
      erc-save-buffer-on-part t

      ;; autoaway setup
      erc-auto-discard-away t
      erc-autoaway-idle-seconds 600
      erc-autoaway-use-emacs-idle t)

;; auto identify
(let ((ercpassfile "~/.ercpass"))
  (when (file-exists-p (expand-file-name ercpassfile))
    (load ercpassfile)
    (require 'erc-services)
    (erc-services-mode 1)
    (setq erc-prompt-for-nickserv-password nil
          erc-nickserv-passwords
          `((freenode (("MetaHertz" . ,freenode-metahertz)))))))

;; Join the a couple of interesting channels whenever connecting to Freenode.
(defun parse-channels-file (filepath)
  "read file, delete comments, add entries to list, remove empties"
  (split-string
   (replace-regexp-in-string
    ";[\#\-\;\sa-z]+\n" "" ;;; removes all entries which starts with ;
    (slurp filepath)) "\n" t))

(defmacro ercchannels (filepath)
  `'(,(parse-channels-file filepath)))
;; for test (parse-channels-file "~/.erc/channels")
;; for test (macroexpand-1 (ercchannels "~/.erc/channels"))

;; exclude boring stuff from tracking
(erc-track-mode t)

(if (not (file-exists-p erc-log-channels-directory))
    (mkdir erc-log-channels-directory t))

(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))

(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)

;; truncate long irc buffers
(erc-truncate-mode +1)

;; enable spell checking
;;(erc-spelling-mode 1)
;; set different dictionaries by different servers/channels
;;(setq erc-spelling-dictionaries '(("#emacs" "american")))

(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (when (y-or-n-p "Do you want to start IRC? ")
    (erc :server "irc.freenode.net" :port 6667 :nick "MetaHertz")))

(defun filter-server-buffers ()
  (delq nil
        (mapcar
         (lambda (x) (and (erc-server-buffer-p x) x))
         (buffer-list))))

(defun stop-irc ()
  "Disconnects from all irc servers"
  (interactive)
  (dolist (buffer (filter-server-buffers))
    (message "Server buffer: %s" (buffer-name buffer))
    (with-current-buffer buffer
      (erc-quit-server "Всем пока! // Goodbye everyone!"))))

(defun find-erc-channels-file ()
  "find and open ~/.erc/channels"
  (interactive)
  (find-file "~/.erc/channels"))

(provide 'erc-cfg)
;;; erc-cfg.el ends here
