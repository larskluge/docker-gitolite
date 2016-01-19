#! /bin/bash -x

reset_admin_repo=false
git config --global push.default simple

cd /home/git

echo Fix file permissions
chown -R git repositories
chmod -R u+rwX repositories
chown -R git:git .ssh
chmod -R u+rwX .ssh

cd /home/git
if [ -d "repositories/gitolite-admin.git" ]; then
  git clone repositories/gitolite-admin.git /tmp/gitolite-admin
  cd /tmp/gitolite-admin
  commit_cnt=$(git rev-list HEAD --count)
  if [ "$commit_cnt" -gt "1" ]; then
    reset_admin_repo=true
  fi
fi

echo $SSH_KEY > /tmp/admin.pub
cd /home/git
su git -c "bin/gitolite setup -pk=/tmp/admin.pub"

if [ "$reset_admin_repo" = true ]; then
  cd /tmp/gitolite-admin
  git push --force
fi

rm -rf /tmp/gitolite-admin

/usr/sbin/sshd -D
