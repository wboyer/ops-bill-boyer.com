<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>true</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers class="vector">
    <hudson.triggers.TimerTrigger>
      <spec>30 17 * * *</spec>
    </hudson.triggers.TimerTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>. ~/.profile

path=/vagrant-mnt/ops/scripts/infrastructure/aws
instanceId=`$path/first-machine-in-load-balancer www-bill-boyer-com`
host=root@`$path/instance-ip-address $instanceId`
pem=~/.aws-pem

$path/backup-mongodb $host $pem /www.bill-boyer.com/backups/mongodb
$path/backup-sqlite $host $pem /srv/rails/www.bill-boyer.com/db/development.sqlite3 /www.bill-boyer.com/backups/rails
$path/backup-sqlite $host $pem /srv/wordpress/wp-content/database/.ht.sqlite /www.bill-boyer.com/backups/wordpress
</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.Mailer>
      <recipients>william.boyer.nyc@gmail.com</recipients>
      <dontNotifyEveryUnstableBuild>false</dontNotifyEveryUnstableBuild>
      <sendToIndividuals>false</sendToIndividuals>
    </hudson.tasks.Mailer>
  </publishers>
  <buildWrappers/>
</project>
