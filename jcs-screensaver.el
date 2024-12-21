;;; jcs-screensaver.el --- A screensaver for jcs-emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/jcs-emacs/jcs-screensaver
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.3") (snow "0.1") (zoom-window "0.06"))
;; Keywords: tools

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; A screensaver for jcs-emacs.
;;

;;; Code:

(require 'snow)
(require 'zoom-window)

(defgroup jcs-screensaver nil
  "A screensaver for jcs-emacs."
  :prefix "jcs-screensaver-"
  :group 'tools
  :link '(url-link :tag "Github" "https://github.com/jcs-emacs/jcs-screensaver"))

(defun jcs-screensaver--turn-off ()
  "Turn off screensaver."
  (unless (equal this-command #'jcs-screensaver)
    (remove-hook 'pre-command-hook #'jcs-screensaver--turn-off)
    (kill-buffer (get-buffer "*snow*"))
    (when (zoom-window--enable-p)
      (zoom-window-zoom))))

(defun jcs-screensaver--turn-on ()
  "Turn on screensaver."
  (snow)
  (unless (zoom-window--enable-p)
    (zoom-window-zoom))
  (add-hook 'pre-command-hook #'jcs-screensaver--turn-off))

;;;###autoload
(defun jcs-screensaver (&rest _)
  "Toggle screen saver."
  (interactive)
  (let ((buf (get-buffer "*snow*")))
    (cond (buf
           (jcs-screensaver--turn-off))
          (t
           (jcs-screensaver--turn-on)))))

(provide 'jcs-screensaver)
;;; jcs-screensaver.el ends here
