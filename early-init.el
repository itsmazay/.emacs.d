;;; early-init.el --- Early initialization -*- lexical-binding: t; -*-
;;; Commentary:
;;
;; Runs before init.el, before the package system and GUI are initialized.
;; Move performance-critical settings here to avoid visual flash and speed up startup.
;;
;;; Code:

;; AGGRESSIVE GC optimization during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.8)

;; Reduce startup time by minimizing file handler checks
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Reset GC and file handlers after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (run-at-time 2 nil
                         (lambda ()
                           (setq gc-cons-threshold (* 64 1024 1024)  ; 64MB
                                 gc-cons-percentage 0.1)
                           (message "GC settings optimized for runtime")))
            (setq file-name-handler-alist file-name-handler-alist-original)
            (makunbound 'file-name-handler-alist-original)))

;; Reduce rendering during startup
(setq-default inhibit-redisplay t
              inhibit-message t)
(add-hook 'window-setup-hook
          (lambda ()
            (setq-default inhibit-redisplay nil
                          inhibit-message nil)
            (redisplay)))

;; Prevent package.el from initializing before init.el
(setq package-enable-at-startup nil)

;; Disable GUI elements before frame renders (prevents flash)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Prevent frame resizing during font/theme changes
(setq frame-inhibit-implied-resize t)

;; Inhibit startup messages early
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message "")

;;; early-init.el ends here
