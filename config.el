;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; 基础设置
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; 滚动设置
(setq scroll-conservatively 101
      scroll-margin 3
      scroll-step 1)

;; 终端鼠标支持
(unless (display-graphic-p)
  (xterm-mouse-mode 1))


;; 语法检查
(after! flycheck
  (global-flycheck-mode 1))
;; ========== C++ LSP Configuration ==========
(after! lsp-mode
  (setq lsp-clients-clangd-args
        '("--background-index"
          "--clang-tidy"
          "--header-insertion=never"
          "--completion-style=detailed"
          "--compile-commands-dir=build"
          "--query-driver=/usr/bin/g++"))
  (setq lsp-enable-symbol-highlighting t
        lsp-enable-snippet t
        lsp-auto-guess-root t
        lsp-idle-delay 0.1
        lsp-completion-provider :capf))

(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t)
  (add-to-list 'company-backends 'company-capf)
  (add-hook 'prog-mode-hook #'company-mode))

(after! (c++-mode lsp-mode)
  (add-hook 'c++-mode-hook #'lsp-deferred))

;; 格式化工具（可选）
(setq +format-with-lsp nil) ; 用 clang-format
(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-basic-offset 4)
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
