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

;; 

;;; Code:

;;; Emacs IRC configuration
;;; This file is part of the Emacs Dev Kit

(require 'erc)
(require 'erc-log)
(require 'erc-spelling)
(require 'erc-autoaway)

;; Join the a couple of interesting channels whenever connecting to Freenode.
(setq erc-autojoin-channels-alist '(("freenode.net"
                                     ;; "#archlinux"
                                     ;; "##british"
                                     ;; "#ccl"
                                     ;; "#deadbeefplayer"
                                     ;; "#deadbeef-ru"
                                     ;; "#emacs-es"
                                     ;; "##English"
                                     ;; "##espanol"
                                     ;; "##francais"
                                     ;; "##italiano"
                                     ;; "##libertarian"
                                     ;; "#libertarians"
                                     ;; "#libervis"
                                     ;; "#linuxchixar"
                                     ;; "##portuguese"
                                     ;; "##russia"
                                     ;; "##russian"
                                     ;; "##russkij"
                                     ;; "#sanluix"
                                     ;; "##vahvuus"
                                     ;; "#emacs"
                                     ;; "#clojure"
                                     ;; "#lisp"
                                     "#lor")))

;; Interpret mIRC-style color commands in IRC chats
(setq erc-interpret-mirc-color t)

;; The following are commented out by default, but users of other
;; non-Emacs IRC clients might find them useful.
;; Kill buffers for channels after /part
(setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
(setq erc-kill-queries-on-quit t)
;; Kill buffers for server messages after quitting the server
(setq erc-kill-server-buffer-on-quit t)

;; open query buffers in the current window
(setq erc-query-display 'buffer)

;; exclude boring stuff from tracking
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

;; logging
(setq erc-log-channels-directory "~/.erc/logs/")

(if (not (file-exists-p erc-log-channels-directory))
    (mkdir erc-log-channels-directory t))

(setq erc-save-buffer-on-part t)
(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))

;; truncate long irc buffers
(erc-truncate-mode +1)

;; share my real name
(setq erc-user-full-name "Dmitry Buhaev")

;; enable spell checking
(erc-spelling-mode 1)
;; set different dictionaries by different servers/channels
;;(setq erc-spelling-dictionaries '(("#emacs" "american")))

;; autoaway setup
(setq erc-auto-discard-away t)
(setq erc-autoaway-idle-seconds 600)
(setq erc-autoaway-use-emacs-idle t)

;; auto identify
(when (file-exists-p (expand-file-name "~/.ercpass"))
  (load "~/.ercpass")
  (require 'erc-services)
  (erc-services-mode 1)
  (setq erc-prompt-for-nickserv-password nil)
  (setq erc-nickserv-passwords
        `((freenode (("MetaHertz" . ,freenode-metahertz)))))
)

;; utf-8 always and forever
(setq erc-server-coding-system '(utf-8 . utf-8))

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
      (erc-quit-server "hasta la vista"))))

(provide 'erc-cfg)
;;; erc-cfg.el ends here
