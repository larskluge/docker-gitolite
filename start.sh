#! /bin/sh -

chown -R git /home/git/repositories
chmod -R u+rwX /home/git/repositories

chown -R git /home/git/.ssh
chmod -R 0700 /home/git/.ssh

if [ ! -f /home/git/repositories/.gitolite-configured ]; then
  echo Initial configuration of gitolite
  echo $SSH_KEY > /tmp/admin.pub
  su git -c "/home/git/bin/gitolite setup -pk=/tmp/admin.pub"
  su git -c "touch /home/git/repositories/.gitolite-configured"
fi

/usr/sbin/sshd -D
