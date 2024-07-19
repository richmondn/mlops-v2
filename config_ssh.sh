ssh-keygen -t ed25519 -C "richmondnj@outlook.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

gh auth login -h github.com -p https -s admin:public_key
gh ssh-key add ~/.ssh/id_ed25519.pub --title $COMPUTERNAME