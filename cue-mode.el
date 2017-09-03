;;; cue-mode.el ---   -*- lexical-binding: t; coding: utf-8 -*-

;; Copyright (C)  3 September 2017
;;

;; Author: Sébastien Le Maguer <slemaguer@coli.uni-saarland.de>

;; Package-Requires: ((emacs "25.2"))
;; Keywords:
;; Homepage: https://github.com/seblemaguer/cue-mode

;; cue-mode is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; cue-mode is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with cue-mode.  If not, see http://www.gnu.org/licenses.

;;; Commentary:


;;; Code:

(provide 'cue-mode)
(eval-when-compile
  (require 'cl))



(defvar cue-constants
  '("WAVE" "AUDIO" "MP3"))

(defvar cue-main-commands
  '("FILE" "TRACK" "INDEX" "PREGAP" "POSTGAP"))

(defvar cue-cd-metacommands
  '("CDTEXTFILE" "FLAGS" "CATALOG" "OSRC" "TITLE" "PERFORMER" "SONGWRITER"))

;; I'd probably put in a default that you want, as opposed to nil
(defvar cue-tab-width 2
  "Width of a tab for CUE mode")

;; Two small edits.
;; First is to put an extra set of parens () around the list
;; which is the format that font-lock-defaults wants
;; Second, you used ' (quote) at the outermost level where you wanted ` (backquote)
;; you were very close
(defvar cue-font-lock-defaults
  `((
     ("^[ \t]*REM .*" .font-lock-comment-face)

     ;; stuff between double quotes
     ("\"\\.\\*\\?" . font-lock-string-face)
     ;; ; : , ; { } =>  @ $ = are all special elements
     ;; (":\\|,\\|;\\|{\\|}\\|=>\\|@\\|$\\|=" . font-lock-keyword-face)
     ( ,(regexp-opt cue-main-commands 'words) . font-lock-keyword-face)
     ( ,(regexp-opt cue-cd-metacommands 'words) . font-lock-keyword-face)
     ( ,(regexp-opt cue-constants 'words) . font-lock-builtin-face)
     )))


(define-derived-mode cue-mode fundamental-mode "CUE sheet"
  "CUE mode is a major mode for editing CUE files"
  (defgroup cue-mode nil
    "Derived mode for CUE Files" :group 'languages)

  (defvar cue-mode-hook nil "Hook for cue-mode")

  (make-local-variable 'cue-font-lock-defaults)
  (make-local-variable 'comment-start)
  (make-local-variable 'comment-end)
  (make-local-variable 'comment-start-skip)
  (make-local-variable 'comment-column)
  (make-local-variable 'comment-multi-line)
  (make-local-variable 'comment-indent-function)

  (setq font-lock-defaults cue-font-lock-defaults
        comment-start           "REM "
        comment-end             ""
        comment-column          60
        comment-multi-line      nil
        comment-indent-function 'java-comment-indent
        indent-tabs-mode        t
  )
 (run-hooks 'cue-mode-hook)
)




;;; cue-mode.el ends here
