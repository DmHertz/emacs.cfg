;;; for correct interactive mode
(setq inferior-fsharp-program
      (case system-type
        ('gnu/linux "/usr/bin/fsharpi --readline-")
        ('windows-nt "\"C:/Program Files (x86)/Microsoft SDKs/F#/4.0/Framework/v4.0/fsi.exe\"")))

(setq fsharp-compiler
      (case system-type
        ('gnu/linux "/usr/bin/fsharpc")
        ('windows-nt "\"C:/Program Files (x86)/Microsoft SDKs/F#/4.0/Framework/v4.0/fsc.exe\"")))

;;; msvs keybindings
(add-hook 'fsharp-mode-hook
          (lambda ()
            (define-key fsharp-mode-map (kbd "M-RET") #'fsharp-eval-region)
            (define-key fsharp-mode-map (kbd "C-SPC") #'fsharp-ac/complete-at-point)))
