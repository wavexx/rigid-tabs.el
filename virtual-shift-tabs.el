;;; virtual-shift-tabs.el --- Adjust the visual alignment of TABs in unified diffs

;; Author: Yuri D'Elia <wavexx@thregr.org>
;; Version: 1.0
;; URL: https://github.com/wavexx/virtual-shift-tabs.el
;; Package-Requires: ()
;; Keywords: diff, tabs, version control

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; The function `virtual-shift-tabs' adjusts the visual alignment of TABs in
;; major modes displaying unified diffs (such as `diff-mode', `magit-diff',
;; etc) to compensate for the initial +/- prefix.
;;
;; To enable in the various magit modes, use the following:
;;
;; (add-hook 'magit-refresh-buffer-hook
;;           (lambda ()
;;             (when (member major-mode '(magit-diff-mode magit-revision-mode))
;;               (virtual-shift-tabs))))

;;; Code:

;;;###autoload
(defun virtual-shift-tabs (&optional chars)
  "Adjust the visual alignment of TABs by 'chars spaces forward"
  (save-excursion
    (goto-char (point-min))
    (let (last-line last-point current-column)
      (while (re-search-forward "\t+" nil t)
	(goto-char (match-beginning 0))
	(let ((current-line (line-number-at-pos)))
	  (if (eq last-line current-line)
	      (setq current-column (+ (- (point) last-point) current-column))
	      (setq current-column (current-column)))
	  (let* ((column (- current-column (or chars 1)))
		 (target (+ (* (/ column tab-width) tab-width) tab-width))
		 (xstops (1- (- (match-end 0) (match-beginning 0))))
		 (spaces (+ (- target column) (* xstops tab-width))))
	    (goto-char (match-end 0))
	    (setq current-column (+ current-column spaces)
		  last-line current-line
		  last-point (point))
	    (overlay-put (make-overlay (match-beginning 0) (point))
			 'display (make-string spaces ?\s))))))))

(provide 'virtual-shift-tabs)

;;; virtual-shift-tabs.el ends here
