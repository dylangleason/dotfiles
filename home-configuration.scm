;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (gnu home services)
             (gnu home services shells))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages (list "bat"
					   "cmake"
					   "coreutils"
					   "emacs"
					   "emacs-geiser"
					   "emacs-geiser-guile"
					   "emacs-guix"
					   "emacs-vterm"
					   "font-jetbrains-mono"
					   "gawk"
					   "gcc-toolchain"
					   "git"
					   "glibc-locales"
					   "go"
					   "grep"
					   "guile"
					   "guix"
					   "htop"
					   "ipcalc"
					   "jq"
					   "make"
					   "nss-certs"
					   "password-store"
					   "tmux")))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-zsh-service-type
                 (home-zsh-configuration
                  (zshenv (list (local-file "config/zshenv" "zshenv")))
                  (zshrc (list (local-file "config/zshrc" "zshrc")))))
	(service home-xdg-configuration-files-service-type
		 (list `("emacs" ,(local-file
				   "emacs"
				   "emacs"
				   #:recursive? #t))
		       `("gtk-3.0" ,(local-file
				     "gtk-3.0"
				     "gtk-3.0"
				     #:recursive? #t))
		       `("i3" ,(local-file
				"i3"
				"i3"
				#:recursive? #t))
		       `("i3status-rust" ,(local-file
					   "i3status-rust"
					   "i3status_rust"
					   #:recursive? #t))
		       `("tmux" ,(local-file
				  "tmux"
				  "tmux"
				  #:recursive? #t))
		       ))
	)))
