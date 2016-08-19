(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

; enables ido-mode - change buffers with crtl-b
(require 'ido)
(ido-mode t)

; enables ispell for text 
(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
; disable ispell for log and edit mode
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))

; show paths
(add-to-list 'exec-path "~/Development/bin/ghc/bin")


; Make Emacs look in Cabal directory for binaries
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

; HASKELL-MODE
; ------------

; Choose indentation mode
;; Use haskell-mode indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; Use hi2
;(require 'hi2)
;(add-hook 'haskell-mode-hook 'turn-on-hi2)
;; Use structured-haskell-mode
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)

; Add F8 key combination for going to imports block
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(company-ghc-show-info t)
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "7dd0db710296c4cec57c39068bfffa63861bf919fb6be1971012ca42346a417f" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "c0dd5017b9f1928f1f337110c2da10a20f76da0a5b14bb1fec0f243c4eb224d4" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(org-agenda-files (quote ("~/workspace/geoinfoBuch/erstesTreffen.org" "~/ownCloud/gtd/management.org" "~/ownCloud/gtd/Realisierung2016.org")))
 '(org-combined-agenda-icalendar-file "~/ownCloud/gtd/agenda.ics")
 '(org-icalendar-combined-agenda-file "~/ownCloud/gtd/agenda.ics")
 '(org-mobile-directory "~/ownCloud/gtd/")
 '(org-mobile-encryption-password "bobsofa4619")
 '(rainbow-identifiers-cie-l*a*b*-lightness 70)
 '(rainbow-identifiers-cie-l*a*b*-saturation 20)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

; Add key combinations for interactive haskell-mode
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))
  
; GHC-MOD
; -------

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

; COMPANY-GHC
; -----------

; Enable company-mode
(require 'company)
; Use company in Haskell buffers
; (add-hook 'haskell-mode-hook 'company-mode)
; Use company in all buffers
(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'company-backends 'company-ghc)


; Rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)

; set time zone of exported ical file
(setq org-icalendar-timezone "Europe/Berlin")
