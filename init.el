;;; init.el --- Where all the magic begins -*- lexical-binding: t; -*-
;;; Commentary:
;;;
;;; This file allows Emacs to initialize my customizations
;;; in Emacs lisp embedded in *one* literate Org-mode file.
;;; Code:

;; Initialize package system (early-init.el prevents auto-init)
(require 'package)
(package-initialize)

;; Tangle and load the literate configuration
(require 'org)
(org-babel-load-file "~/.emacs.d/emacs.org")

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here
