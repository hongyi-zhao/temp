;https://github.com/rofl0r/proxychains-ng/issues/375
;Revert to the proxychains-ng based method.
;https://github.com/tumashu/posframe/issues/97#issuecomment-819595652
;.local/bin/emacs

;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-a%3Ar-5804144073566404076&simpl=msg-a%3Ar-5804144073566404076

;https://www.gnu.org/software/emacs/manual/html_node/epa/Caching-Passphrases.html#Caching-Passphrases
;https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html#Invoking-GPG_002dAGENT

;https://emacs.stackexchange.com/questions/45497/emacs-not-prompting-for-password-when-opening-gpg-file


;For gpg version < 2, caching can be from emacs or the gpg-agent

;To disable caching from emacs, set epa-file-cache-passphrase-for-symmetric-encryption to nil if it is not nil in emacs config file

;(setq epa-file-cache-passphrase-for-symmetric-encryption nil)

;To disable caching by gpg-agent, add default-cache-ttl 0 to gpg config file located at ~/.gnupg/gpg-agent.conf

;For gpg version >= 2, disabling gpg-agent cache would suffice. So just add default-cache-ttl 0 to gpg config file located at ~/.gnupg/gpg-agent.conf


;https://www.masteringemacs.org/article/keeping-secrets-in-emacs-gnupg-auth-sources
;sudo apt-get install gnupg2
; Based on my tries, there is no need to set the following:
;(setq epg-gpg-program "gpg2")

;Creating a key

;To get started you must first generate the key pair with gpg:

;$ gpg --gen-key

;Follow the prompts to generate your key. I highly recommend you pick a pass phrase!

;You can verify it is loaded into your system’s keychain by running:

;M-x epa-list-secret-keys in Emacs;

;or gpg --list-secret-keys on your command line


;Exporting and Re-Importing a Key

;Next, export the secret key to a file mykey.asc to gpg (using the key holder’s name, email or key ID):

;$ gpg --armor --export-secret-keys Cosmo Kramer > mykey.asc

;You can now, on a different machine, re-import the key, but you will also have to trust it again. You can pass the full name in quotes or the e-mail to gpg and it will pick the right one. Here I edit a key based on the full name of the key holder and GPG is smart enough to figure out which one it is:

;$ gpg --import mykey.asc
;$ gpg --edit-key "Cosmo Kramer"
;gpg> trust
;Your decision? 5
;Do you really want to set this key to ultimate trust? (y/N) y
;gpg> quit

;At this point you have a key and a way of exporting and re-importing it between computers; useful, if you use more than one, but optional. It goes without saying that if you lose your key you lose your encrypted data!


;Debugging Authentication Issues

;The first thing I want to mention is the debug variable. Debugging authentication problems is hard enough without adding another layer inbetween. To enable debug information set the auth-source-debug to t to enable or nil to disable:

;(setq auth-source-debug t)

;This will echo a lot of additional, helpful, information to the *Messages* buffer. Be sure to turn it off when you are done.

;Another useful function to call is M-x auth-source-forget-all-cached. Auth source will cache your credentials in Emacs; use this command to forget all the cached details.

;https://emacs.stackexchange.com/questions/59003/separate-auth-sources-for-tramp-and-gnus-or-disable-auth-sources-for-tramp
;You can either use this (I base mine on the command-line arguments):

;(setq tzz-gnus-running-p (member "gnus" command-line-args))
;(setq auth-sources (if tzz-gnus-running-p
;                       '("~/.gnus.json.gpg")
;                       '("~/.authinfo.json.gpg")))

;or customize tramp-completion-use-auth-sources:

;tramp-completion-use-auth-sources is a variable defined in ‘tramp.el’.
;Its value is t
;...
;Whether to use ‘auth-source-search’ for completion of user and host names.

;When you don't know how to set the following file, 
;you can set one with any content, then observe the error messages given by emacs. 
;Thus we can think and find ideas based on these error messages.
(setq auth-sources
    '((:source "~/.emacs.d/epg/news.rusnet.ru.gpg")))


;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1689160610271328582&simpl=msg-f%3A1689160610271328582
;https://www.emacswiki.org/emacs/BookmarkPlus
;https://www.emacswiki.org/emacs/BookmarkPlus#DesktopBookmarks


;https://mail.google.com/mail/u/0/?tab=wm&ogbl#sent/QgrcJHsNlSKlKWXPbFfhsSkbBjWTksCQzqg  
;Eww can't display Chinese characters correctly.
(setq url-user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36")

;https://emacs.stackexchange.com/questions/278/how-do-i-display-line-numbers-in-emacs-not-in-the-mode-line
;http://ergoemacs.org/emacs/emacs_line_number_mode.html
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
    
;; https://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
;; https://melpa.org/#/getting-started
(require 'package)

;https://github.com/magnars/dash.el/issues/360#issuecomment-754363969
;M-x version RET C-h v package-archives RET
;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;http://elpa.emacs-china.org/     
;https://mirrors.tuna.tsinghua.edu.cn/help/elpa/
;上游

;本镜像的上游为 http://elpa.emacs-china.org/，本文档也参考了emacs-china提供的帮助。
;URL Bug

;各个仓库的URL末尾一定要加/，否则会无法拉取，提示Failed to download melpa archive。

;事实上，末尾没有/的话，emacs会去尝试取以下链接:

;    http://mirrors.tuna.tsinghua.edu.cn/elpa/melpaarchive-contents

;而正常的链接应该是

;    http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/archive-contents

;这个是emacs自己的bug。在 https://github.com/melpa/melpa/issues/2139 中有描述。 
; 


(setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

;; https://github.com/jwiegley/use-package
;; Getting started
;; Here is the simplest use-package declaration:
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; $ git clone https://github.com/jwiegley/use-package.git ~/Public/repo/github.com/jwiegley/use-package.git 
  (add-to-list 'load-path "~/Public/repo/github.com/jwiegley/use-package.git")
  (require 'use-package))
  ;; https://github.com/jwiegley/use-package#use-packageel-is-no-longer-needed-at-runtime
  ;(require 'diminish)                ;; if you use :diminish
  (require 'bind-key)                ;; if you use any :bind variant


;; https://github.com/jwiegley/use-package#package-installation
;;Enable use-package-always-ensure if you wish this behavior to be global for all packages:
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;NOTE: :ensure will install a package if it is not already installed, but it does not keep it up-to-date. 
;;If you want to keep your packages updated automatically, one option is to use auto-package-update, like
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;https://github.com/jwiegley/use-package/issues/256#issuecomment-263313693
(defun my-package-install-refresh-contents (&rest args)
  (package-refresh-contents)
  (advice-remove 'package-install 'my-package-install-refresh-contents))

(advice-add 'package-install :before 'my-package-install-refresh-contents)


;; https://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
;https://github.com/bbatsov/prelude/blob/aaedc8537c04e4af7a53690b8bbb8522d5a35b9d/core/prelude-packages.el#L56
(defvar prelude-packages
  ;; https://github.com/magnars/s.el#installation
  '(
    ;https://github.com/magnars/dash.el/issues/360#issuecomment-754377853
    dash flycheck posframe
    s ein
    ;https://github.com/kenkangxgwe/lsp-wl/issues/48#issuecomment-847646104
    projectile keycast
    lsp-mode company company-box dap-mode
    ;https://iloveemacs.wordpress.com/2014/09/10/emacs-as-an-advanced-terminal-multiplexer/comment-page-1/
    multi-term 
    ;https://github.com/manateelazycat/aweshell/issues/63
    ;aweshell
    
    ;ace-jump-mode key-chord yasnippet
    w3m
    ;https://github.com/Fuco1/smartparens
    smartparens
    valign
   )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  "Check if all packages in `prelude-packages' are installed."
  (cl-every #'package-installed-p prelude-packages))

(defun prelude-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package prelude-packages)
    (add-to-list 'prelude-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun prelude-require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'prelude-require-package packages))

(defun prelude-install-packages ()
  "Install all packages listed in `prelude-packages'."
  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (prelude-require-packages prelude-packages)))

;; run package installation
(prelude-install-packages)


;https://github.com/raxod502/straight.el/issues/786
;https://github.com/raxod502/straight.el#getting-started
(setq package-enable-at-startup nil)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))



;https://github.com/DvdMgr/screen2latex.el
;(load-file "~/Public/repo/github.com/DvdMgr/screen2latex.el.git/screen2latex.el")
 

;Open multiple separate terminal buffers with multi-term in Emacs.
;https://github.com/manateelazycat/aweshell

;https://stackoverflow.com/questions/2785950/more-than-one-emacs-terminal

;I modified the accepted answer by Harpo so that it starts a new shell without prompting, shells will be named in the form *shell-1*,*shell-2*,*shell-3* etc.:

;(setq bash-counter 1)
;(defun bash ()
;  "Start a bash shell"
;  (interactive)
;  (setq bash-counter (+ bash-counter 1))
;  (let
;    ((explicit-shell-file-name "/bin/bash"))
;    (shell (concat "*shell-" (number-to-string bash-counter) "*"))
;    ))


;Here's a super lightweight little function that you can call to automatically rename the term you're on, and then start a new term:
(defun new-ansi-term ()
  (interactive)
  (if (string= "*ansi-term*" (buffer-name))
      (rename-uniquely))
  (ansi-term "/bin/bash"))

;Then to bind that within ansi-term, I found this works:

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          '(lambda ()
             (define-key term-raw-map (kbd "C-t") 'new-ansi-term)))
(defadvice ansi-term (after ansi-term-after-advice (org))
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

;If you then also bind new-ansi-term to C-t in the normal way, you'll find that when you're not looking at an ansi-term, C-t will focus the ansi-term buffer, and then if you are looking at an ansi-term, C-t will rename it to some unique name, and then open a new ansi-term for you. This works really well in combination with tabbar, which will show you all your opened ansi-terms just above the first line of the buffer. Easy to switch between them ;-)



;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1701438233311838541&simpl=msg-f%3A1701438233311838541
;The description of the multi-term package (see <https://melpa.org/#/multi-term>)
;says that you can create a new term buffer with `M-x multi-term`, which you have
;bound to `C-c T`. So press it once to create one terminal, press it again to
;create a second one. If you want to see both terminals at once, open one
;terminal, split the window (C-x 2 or C-x 3) and then open a new terminal in the
;second window.


;https://unix.stackexchange.com/questions/148581/in-emacs-term-mode-what-is-char-mode-and-line-mode-how-do-they-differ
;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1701363295459552878&simpl=msg-f%3A1701363295459552878
;Not quite. In *term*, one can switch `modes' between char and line entry. One lets
;you interact with the terminal as if in a *shell* buffer. This is super
;handy.
;https://iloveemacs.wordpress.com/2014/09/10/emacs-as-an-advanced-terminal-multiplexer/comment-page-1/

;Emacs as an advanced terminal multiplexer

;I really enjoy using Tmux and I love zsh, but I am missing something like ace-jump-mode to quickly jump to a line in my terminal and I would like to have snippets for everyday tasks like a for loop so some day I thought why not try using zsh in Emacs? And voila here is the config that let you jump around in your terminal by pressing “jj” and a head character as well as write you Yasnippets.
;To use it you have to install multi-term, ace-jump-mode, key-chord and yasnippet.


;(require 'multi-term)
;(require 'ace-jump-mode)
;(require 'key-chord)
;(require 'yasnippet)

;(key-chord-mode 1)
;(setq key-chord-one-key-delay 0.15)
;(key-chord-define-global "jj" 'ace-jump-mode)

;(add-hook 'term-mode-hook (lambda ()
;(setq yas/dont-activate nil)
;(yas/minor-mode-on)
;(add-to-list 'term-bind-key-alist '("C-c C-n" . multi-term-next))
;(add-to-list 'term-bind-key-alist '("C-c C-p" . multi-term-prev))
;(add-to-list 'term-bind-key-alist '("C-c C-j" . term-line-mode))
;(add-to-list 'term-bind-key-alist '("C-c C-k" . term-char-mode))
;))

;(global-set-key (kbd "C-c t") 'multi-term-next)
;(global-set-key (kbd "C-c T") 'multi-term)

;Now you can open a new terminal by pressing C-c T, switch between them with C-c C-n and C-c C-p and if you would like to copy some text in the middle of your screen first press C-c C-j to enable line-mode than jj to jump. The same applies for yasnippets first switch from char to line-mode (it makes your terminal a normal emacs buffer), type your keyword and expand it with tab. Here’s an example


;# key: for
;# --
;for X in $1; do $0; done




;https://github.com/emacs-w3m/emacs-w3m
;4.1. Essential Configuration
;     Put this line into your Emacs' init file (i.e., ~/.emacs, etc.):
;         (require 'w3m-load)
(require 'w3m-load)


;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1700842044000203971&dsqt=1&simpl=msg-f%3A1700842044000203971
;(use-package lsp-mode
;  :config
;  (lsp))

;(require 'lsp-mode
;  (lsp))
(require 'lsp-mode)
  
                  
;https://github.com/emacs-lsp/lsp-mode/#presentationsdemos              
;https://www.youtube.com/playlist?list=PLEoMzSkcN8oNvsrtk_iZSb94krGRofFjN
;https://github.com/sebastiencs/company-box/#installation

;; With use-package:
(use-package company-box
  :hook (company-mode . company-box-mode))

;; Or:
;(require 'company-box)
;(add-hook 'company-mode-hook 'company-box-mode)

;https://emacs-lsp.github.io/lsp-mode/page/main-features/
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0) ;; default is 0.2

;https://metaredux.com/posts/2019/12/07/dead-simple-emacs-screencasts.html
;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1700835500762566268&simpl=msg-f%3A1700835500762566268

(require 'keycast
;  (keycast-mode)
)
;or
;(use-package keycast
;  :config
;  (keycast-mode))


;https://docs.projectile.mx/projectile/index.html
;https://github.com/bbatsov/projectile#installation  
(projectile-mode +1)
;; Recommended keymap prefix on macOS
;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)  
  
  
  
;https://emacs-lsp.github.io/dap-mode/page/configuration/
;Configuration#
;DAP mode configuration#

;For an auto-configuration enable the dap-auto-configure-mode. You can configure which features from dap-mode do you want with dap-auto-configure-features:

;;; Enabling only some features
;(setq dap-auto-configure-features '(sessions locals controls tooltip))

;Or if you want to enable only specific modes instead:

(dap-mode 1)
;; The modes below are optional
(dap-ui-mode 1)
;; enables mouse hover support
(dap-tooltip-mode 1)
;; use tooltips for mouse hover
;; if it is not enabled `dap-mode' will use the minibuffer.
(tooltip-mode 1)
;; displays floating panel with debug buttons
;; requies emacs 26+
(dap-ui-controls-mode 1)

;After enabling DAP mode on emacs side follow the language specific settings.



;; https://github.com/raxod502/straight.el
;; https://github.com/raxod502/straight.el/issues/648#issuecomment-748562964


;https://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=recursively+load-path&submit=Search%21&idxname=help-gnu-emacs&max=100&result=normal&sort=score


;https://github.com/Fuco1/smartparens#getting-started
;https://github.com/Fuco1/smartparens/wiki
;http://ebzzry.io/en/emacs-pairs/
(use-package smartparens-config
  :ensure smartparens
  :config (progn (show-smartparens-global-mode t))
  ;https://github.com/Fuco1/smartparens/issues/1070#issuecomment-761817551
  :config (progn (smartparens-global-strict-mode t)))

;https://github.com/Fuco1/smartparens/issues/1069#issuecomment-761220669
(setq sp-navigate-close-if-unbalanced t)



;https://www.emacswiki.org/emacs/EmacsKeyNotation

;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1687248836604357163&simpl=msg-f%3A1687248836604357163
;BTW, you can also install the latest code from Git via package.el:

;    M-x url-handler-mode RET       ;; Assuming it's not already enabled
;    C-x C-f https://elpa.gnu.org/devel/org.tar RET
;    M-x package-install-from-buffer RET

;https://www.python-excel.org/

;https://orgmode.org/manual/Installation.html
;Using Org’s git repository
;$ git clone https://code.orgmode.org/bzg/org-mode.git Public/repo/code.orgmode.org/bzg/org-mode.git
;$ cd code.orgmode.org/bzg/org-mode.git
;$ make autoloads
(add-to-list 'load-path "~/Public/repo/code.orgmode.org/bzg/org-mode.git/lisp")
(add-to-list 'load-path "~/Public/repo/code.orgmode.org/bzg/org-mode.git/contrib/lisp" t)
(require 'org)


;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-a%3Ar537895350402768317&simpl=msg-a%3Ar537895350402768317
;Pixel-perfect visual alignment for Org and Markdown tables. 
;https://github.com/casouri/valign#valignel
(add-hook 'org-mode-hook #'valign-mode)

;https://github.com/magnars/dash.el
;https://github.com/magnars/dash.el/issues/360
;git clone https://github.com/magnars/dash.el.git magnars/dash.el.git
;(add-to-list 'load-path "~/Public/repo/github.com/magnars/dash.el.git")
;(require 'dash)
;(require 'dash-functional)


;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1687354298920363156&simpl=msg-f%3A1687354298920363156
;Microsoft Excel spreadsheet editing directly from within emacs.
;Uwe Brauer <oub@mat.ucm.es>	Tue, Dec 29, 2020 at 4:12 AM
;Reply-To: emacs-orgmode@gnu.org
;To: emacs-orgmode@gnu.org
;Cc: help-gnu-emacs@gnu.org
;>>> "HZ" == Hongyi Zhao <hongyi.zhao@gmail.com> writes:

;> Is it possible for me to edit Microsoft Excel spreadsheet directly
;> from within emacs, especially utilizing the powerful capabilities of
;> orgmode?


;You can export and import them to org files, without the excel formula
;of course

;(defun org-table-import-xlsx-to-csv-org ()
;  (interactive)
;  (let* ((source-file  (file-name-sans-extension (buffer-file-name (current-buffer))))
;         (xlsx-file (concat source-file ".xlsx"))
;         (csv-file (concat source-file ".csv")))
;    (org-odt-convert xlsx-file "csv")
;    (org-table-import csv-file  nil)))

;(defun org-table-export-to-xlsx ()
;  (interactive)
;  (let* ((source-file  (file-name-sans-extension (buffer-file-name (current-buffer))))
;         (csv-file (concat source-file ".csv")))
;    (save-excursion
;      (org-table-export csv-file "orgtbl-to-csv")
;      (org-odt-convert csv-file "xlsx"))))


;https://emacs.stackexchange.com/questions/30221/wrap-lines-at-80-characters
(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'auto-fill-mode)


;https://mail.google.com/mail/u/0?ik=7b73d6af10&view=pt&search=all&permmsgid=msg-f%3A1696965744868539083&simpl=msg-f%3A1696965744868539083
;>> Do you use Emacs in the terminal?
;>
;> May or may not.

;In that case I also think the keys I mentioned are the best.  Those are
;* C-;
;* C-,
;* C-'
;* C-=
;* C-+

;Here is why....  Those keys don't work on terminal emulators, at least
;not without significant configuration of the emulator.  So, not only
;does Emacs not use them, it's unlikely that the Emacs developers will
;start using them for new features.

;For example you could map C-; to switch windows in your windowing system
;and map C-, to your input method program.

;Another poster mentioned the possibility of using both shift keys
;pressed together.  I think that's a good idea too since Emacs doesn't
;use the binding or differentiate between left and right shift.  (Not by
;default, I think it can).

;Someone also mentioned the possibility of repurposing M-s.  Now I agree
;that there isn't that much useful on M-s.  Personally I use occur (M-s
;o) and isearch-forward-symbol (M-s _).  But remember that other things
;could be added in the future and you'd be missing out on them.  Of
;course, you could move the M-s keymap elsewhere so you can retain those
;features but that's extra work.

;BR,
;Robert Thorpe



;https://github.com/DogLooksGood/emacs-rime#%E6%9C%80%E5%B0%8F%E9%85%8D%E7%BD%AE 
(use-package rime
  ; https://emacs-china.org/t/emacs-rime/12048/551
  ; https://github.com/DogLooksGood/emacs-rime/blob/master/README_EN.org#open-rime-menu
  :bind
  (:map rime-mode-map
         ("C-`" . 'rime-send-keybinding))
  :custom
  (default-input-method "rime")
  ;https://github.com/DogLooksGood/emacs-rime/issues/133
  (rime-share-data-dir "~/.local/share/fcitx5/rime")
  (rime-show-candidate 'posframe))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(w3m dash rime use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVuSansMono Nerd Font Mono" :foundry "PfEd" :slant normal :weight normal :height 151 :width normal)))))
