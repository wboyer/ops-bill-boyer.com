<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
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
/vagrant-mnt/ops/scripts/infrastructure/aws/backup-mongodb root@54.186.166.111 ~/.aws-pem /www.bill-boyer.com/backups/mongodb
/vagrant-mnt/ops/scripts/infrastructure/aws/backup-sqlite root@54.186.166.111 ~/.aws-pem /srv/rails/www.bill-boyer.com/db/development.sqlite3 /www.bill-boyer.com/backups/sqlite
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
