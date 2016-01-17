#! /bin/sh -

chown -R git /home/git/repositories
chmod -R u+rwX /home/git/repositories

chown -R git /home/git/.ssh/authorized_keys
chmod -R 0600 /home/git/.ssh/authorized_keys

if [ ! -f /home/git/repositories/.gitolite-configured ]; then
  echo $SSH_KEY > /tmp/admin.pub
  su git -c "/home/git/bin/gitolite setup -pk=/tmp/admin.pub"
  su git -c "touch /home/git/repositories/.gitolite-configured"
fi

/usr/sbin/sshd -D
