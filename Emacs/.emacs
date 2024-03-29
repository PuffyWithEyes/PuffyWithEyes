(defun copy-line (arg)
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  (kill-append "\n" nil)
  (beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

;; DIRED
(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (or (equal major-mode 'dired-sidebar-mode) (equal major-mode 'dired-mode))
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
		(progn
	      (set (make-local-variable 'dired-dotfiles-show-p) nil)
	      (message "h")
	      (dired-mark-files-regexp "^\\\.")
	      (dired-do-kill-lines))
	  (progn (revert-buffer) ; otherwise just revert to re-show
			 (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(defvar my-keys-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Using jkl; as <^v>
    (define-key map (kbd "M-j")     'backward-char)
    (define-key map (kbd "M-о")     'backward-char)
    (define-key map (kbd "M-;")     'forward-char)
    (define-key map (kbd "M-ж")     'forward-char)
    (define-key map (kbd "M-l")     'previous-line)
    (define-key map (kbd "M-д")     'previous-line)
    (define-key map (kbd "M-k")     'next-line)
    (define-key map (kbd "M-л")     'next-line)
    (define-key map (kbd "M-J")     'backward-word)
    (define-key map (kbd "M-О")     'backward-word)
    (define-key map (kbd "M-:")     'forward-word)
    (define-key map (kbd "M-K")     'beginning-of-line)
    (define-key map (kbd "M-Л")     'beginning-of-line)
    (define-key map (kbd "M-L")     'end-of-line)
    (define-key map (kbd "M-Д")     'end-of-line)
    (define-key map (kbd "M-]")     'forward-paragraph)
    (define-key map (kbd "M-[")     'backward-paragraph)
    (define-key map (kbd "C-z")     'undo)
    (define-key map (kbd "C-я")     'undo)
    (define-key map (kbd "M-o")     (lambda () (interactive) (beginning-of-line) (newline-and-indent) (previous-line)))
    (define-key map (kbd "M-щ")     (lambda () (interactive) (beginning-of-line) (newline-and-indent) (previous-line)))
    (define-key map (kbd "C-o")     (lambda () (interactive) (beginning-of-line) (next-line) (newline-and-indent) (previous-line)))
    (define-key map (kbd "C-щ")     (lambda () (interactive) (beginning-of-line) (next-line) (newline-and-indent) (previous-line)))
    (define-key map (kbd "C-/")     'comment-line)
	(define-key map (kbd "C-r")     'replace-regexp)
	(define-key map (kbd "C-к")     'replace-regexp)
    (define-key map (kbd "C-h")     'backward-kill-word)
    (define-key map (kbd "C-р")     'backward-kill-word)
    (define-key map (kbd "C-y y")   'copy-line)
    (define-key map (kbd "C-н н")   'copy-line)
    (define-key map (kbd "C-y Y")   (lambda () (interactive) (copy-line 1) (yank)))
    (define-key map (kbd "C-н Н")   (lambda () (interactive) (copy-line 1) (yank)))
    (define-key map (kbd "C-c c")   'kill-ring-save)
    (define-key map (kbd "C-c с")   'kill-ring-save)
    (define-key map (kbd "C-v")     'yank)
    (define-key map (kbd "C-м")     'yank)
    (define-key map (kbd "C-d d")   'kill-region)
    (define-key map (kbd "C-в в")   'kill-region)
    (define-key map (kbd "C-d C-d") 'kill-whole-line)
    (define-key map (kbd "C-в C-в") 'kill-whole-line)
	(define-key map (kbd "C-a")     'mark-whole-buffer)
	(define-key map (kbd "C-ф")     'mark-whole-buffer)
    (define-key map (kbd "C-w v")   'split-window-horizontally)
    (define-key map (kbd "C-ц с")   'split-window-horizontally)
    (define-key map (kbd "C-w s")   'split-window-vertically)
    (define-key map (kbd "C-ц ы")   'split-window-vertically)
	(define-key map (kbd "C-w C-c") 'delete-window)
	(define-key map (kbd "C-ц C-с") 'delete-window)
	(define-key map (kbd "C-w n")   'make-frame)
	(define-key map (kbd "C-ц т")   'make-frame)
    (define-key map (kbd "C-L")     'windmove-up)
    (define-key map (kbd "C-д")     'windmove-up)
    (define-key map (kbd "C-J")     'windmove-left)
    (define-key map (kbd "C-о")     'windmove-left)
    (define-key map (kbd "C-:")     'windmove-right)
    (define-key map (kbd "C-ж")     'windmove-right)
	(define-key map (kbd "C-K")     'windmove-down)
    (define-key map (kbd "C-л")     'windmove-down)
	(define-key map (kbd "C-x t")   'term)
	(define-key map (kbd "C-ч е")   'term)
	(define-key map (kbd "<f4>")    'ff-find-other-file)
	(define-key map (kbd "<f9>")    'dired-dotfiles-toggle)
	(define-key map (kbd "M-RET")   'delete-frame)
	(define-key map (kbd "C-п")     'quit-process)
	(define-key map (kbd "C-ч C-ы") 'save-buffer)
	(define-key map (kbd "C-ч C-с") 'save-buffers-kill-terminal)
	(define-key map (kbd "<f5>")    (lambda () (interactive) (projectile-compile-project 'compilation-read-command) (projectile-run-project 'compilation-read-command)))
	(define-key map (kbd "C-b")     (lambda () (interactive) (projectile-compile-project 'compilation-read-command)))
	(define-key map (kbd "C-и")     (lambda () (interactive) (projectile-compile-project 'compilation-read-command)))
    map))

(define-minor-mode my-keys-mode
  "Minor mode with the keys I use."
  :global t
  :init-value t
  :keymap my-keys-mode-map)

(setq show-paren-style 'expression)
(show-paren-mode 2)

(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode -10)

;; Uncomment to set window size 160x60
;; (when window-system (set-frame-size (selected-frame) 160 60))
(set-default 'truncate-lines t)

(setq make-backup-files         nil)
(setq auto-save-list-file-name  nil)
(setq auto-save-default         nil)

(setq show-trailing-whitespace t)
(save-place-mode 1)

(setq ring-bell-function 'ignore)

(setq-default c-default-style "bsd"
	      c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)

;; (add-hook 'c-mode-common-hook '(lambda () (c-toggle-hungry-state 1)))

(add-to-list 'load-path "~/.emacs.d/plugins")

;; USE PACKAGE
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/plugins/use-package")
  (require 'use-package))

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-display-line-numbers-mode)

;; IDO
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; BS
(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last))) 
(global-set-key (kbd "<f2>") 'bs-show)

;; SRSPEEDBAR
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

;; PROJECTILE
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
			  ("C-c p" . projectile-command-map)))

;; COMPANY
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1
	  company-idle-delay 0.02)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-k") #'company-select-next)
  (define-key company-active-map (kbd "M-l") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-complete-common))

(require 'yasnippet)
(yas-global-mode 1)

;; AUTOPAIR
(require 'autopair)
(autopair-global-mode)

;; DIRED-SIDEBAR
(use-package dired-sidebar
  :bind (("<f8>" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
	    (lambda ()
	      (unless (file-remote-p default-directory)
			(auto-revert-mode))))
  :config
  (setq dired-sidebar-use-term-integration t))

;; TELEPHONE LINE
(telephone-line-mode 1)

;; DASHBOARD
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; LSP MODE
(use-package lsp-mode
  :hook ((c++-mode c-mode python-mode rust-mode java-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-keymap-prefix "C-c l"))

(setq
 gc-cons-threshold (* 100 1024 1024)
 read-process-output-max (* 1024 1024)
 company-idle-delay 0.0
 company-minimum-prefix-length 1
 lsp-idle-delay 0.1)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
		 (lambda () (require 'ccls) (lsp))))

(defvar lsp-languages-id-configuration
  '(
	(python-mode . "python")
	(c++-mode . "c++")
	(c-mode . "c")
	(racket-mode . "racket")))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
		lsp-lens-enable nil
		lsp-ui-sideline-enable t
		lsp-ui-sideline-show-diagnostics t
		lsp-ui-sideline-show-code-actions nil
		lsp-ui-sideline-show-hover t
		lsp-headerline-breadcrumb-enable nil
		lsp-modeline-code-actions-enable t
		lsp-diagnostic-clean-after-change nil
		lsp-completion-show-detail t
		lsp-completion-show-kind t))

(use-package lsp-pylsp
  :config
  (setq lsp-pylsp-plugins-flake8-enabled t
		lsp-pylsp-plugins-pycodestyle-enabled nil
		lsp-pylsp-plugins-pydocstyle-enabled nil))

(set-background-color "#0E0E0E")


;; INDENT
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode) 


;;THEME
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type 'bar)
 '(highlight-indent-guides-method 'bitmap)
 '(package-selected-packages
   '(linum-relative highlight-indent-guides all-the-icons-ibuffer ## yasnippet use-package telephone-line sr-speedbar rust-mode racket-mode projectile page-break-lines monokai-pro-theme lsp-ui lsp-java json-mode javap-mode impatient-mode go-mode glsl-mode flycheck dired-sidebar dashboard company cmake-mode ccls all-the-icons-ivy all-the-icons-gnus all-the-icons-dired all-the-icons-completion)))

(use-package monokai-pro-theme
  :ensure t
  :config
  (load-theme 'monokai-pro  t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#2d2a2e" :foreground "#fcfcfa" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "SRC" :family "Hack")))))

;; (use-package all-the-icons-ibuffer
;;   :ensure t
;;   :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq ns-use-native-fullscreen t)
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(put 'dired-find-alternate-file 'disabled nil)
