#! /bin/sh -

chown -R git /home/git/repositories
chmod -R u+rwX /home/git/repositories

echo $SSH_KEY > /tmp/admin.pub

if [ ! -f /home/git/repositories/.gitolite-configured ]; then
  su git -c "/home/git/bin/gitolite setup -pk=/tmp/admin.pub"
  su git -c "touch /home/git/repositories/.gitolite-configured"
fi

/usr/sbin/sshd -D
