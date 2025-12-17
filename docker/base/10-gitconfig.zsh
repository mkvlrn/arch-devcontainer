# .gitconfig
SSH_KEY=/home/dev/.ssh/devpod
rm -f ~/.gitconfig
touch ~/.gitconfig
chmod 444 ~/.gitconfig
git config --global user.name ${GIT_NAME}
git config --global user.email ${GIT_EMAIL}
git config --global user.signingkey ${SSH_KEY}
git config --global core.sshCommand "ssh -i $SSH_KEY -o IdentitiesOnly=yes -F /dev/null"
git config --global core.autocrlf false
git config --global core.safecrlf false
git config --global core.eol lf
git config --global push.followTags true
git config --global pull.rebase false
git config --global gpg.format ssh
git config --global commit.gpgsign true
