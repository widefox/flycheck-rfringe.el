;;; flycheck-rfringe.el --- RFringe for Flycheck     -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Sebastian Wiesner <swiesner@lunaryorn.com>

;; Author: Sebastian Wiesner <swiesner@lunaryorn.com>
;; Keywords: convenience, frames, tools
;; Version: 0.1
;; Package-Requires: ((emacs "24") (flycheck "0.23") (rfringe "0"))

;; This file is not part of GNU Emacs.

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

;; Provides `flycheck-rfringe-mode' which creates relative fringe indicators for
;; Flycheck errors.
;;
;; To enable, add the following to your init file:
;;
;;     (add-hook 'flycheck-mode-hook #'flycheck-rfringe-mode)

;;; Code:

(require 'flycheck)
(require 'rfringe)

(defun flycheck-rfringe-add-indicators ()
  "Add rfringe indicators for current Flycheck errors."
  (flycheck-rfringe-remove-indicators)
  (dolist (err flycheck-current-errors)
    (let ((pos (flycheck-error-pos err)))
      (rfringe-create-relative-indicator pos))))

(defun flycheck-rfringe-remove-indicators ()
  "Remove rfringe indicators for Flycheck."
  (rfringe-remove-managed-indicators))

(define-minor-mode flycheck-rfringe-mode
  "Minor mode to show relative fringe indicators for Flycheck.

When called interactively, toggle `flycheck-rfringe-mode'.  With
prefix ARG, enable `flycheck-rfringe-mode' if ARG is positive,
otherwise disable it.

When called from Lisp, enable `flycheck-rfringe-mode' if ARG is
omitted, nil or positive.  If ARG is `toggle', toggle
`flycheck-rfringe-mode'.  Otherwise behave as if called
interactively.

In `flycheck-rfringe-mode' show relative fringe indicators for
Flycheck errors."
  :init-value nil
  :lighter nil
  (cond
   (flycheck-rfringe-mode
    (add-hook 'flycheck-after-syntax-check-hook
              #'flycheck-rfinge-add-indicators
              nil 'local)
    (flycheck-rfringe-add-indicators))
   (t
    (remove-hook 'flycheck-after-syntax-check-hook
                 #'flycheck-rfringe-add-indicators
                 'local)
    (flycheck-rfringe-remove-indicators))))

(provide 'flycheck-rfringe)
;;; flycheck-rfringe.el ends here
