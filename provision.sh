#!/bin/bash
set -e
echo ${SUDO_PW} | sudo -S mkdir -p /opt/ansible
echo "Running provisioning script..."

echo "Copy ansible files and keys"
echo ${SUDO_PW} | sudo -S cp -R /Users/admin/ansible/files /opt/ansible
echo ${SUDO_PW} | sudo -S cp -R /Users/admin/ansible/keys /opt/ansible

echo "Install Xcode Tools"
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$( softwareupdate -l |
        grep "*.*Command Line" |
        tail -n 1 |
        awk -F"*" '{print $2}' |
        sed -e 's/^ *//' |
        sed 's/Label: //g' |
        tr -d '\n')
softwareupdate -i "$PROD" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

echo "Install ansible"
echo ${SUDO_PW} | sudo -S python3 -m pip install --upgrade pip
echo ${SUDO_PW} | sudo -S /usr/bin/pip3 install ansible

echo "Running commands as root"
/usr/local/bin/ansible-playbook /Users/admin/ansible/root.yml -i /Users/admin/ansible/inventory --vault-password-file /tmp/password.txt

echo "Running commands as jenkins"
if [ -z "${FASTLANE_SESSION}" ]
then
        echo "Using fastlane variable from passwords.yml"
        /usr/local/bin/ansible-playbook /Users/admin/ansible/jenkins.yml -i /Users/admin/ansible/inventory --vault-password-file /tmp/password.txt
else
        echo "Using fastlane variable from Env"
        /usr/local/bin/ansible-playbook /Users/admin/ansible/jenkins.yml -i /Users/admin/ansible/inventory --vault-password-file /tmp/password.txt -e "fastlane_session='${FASTLANE_SESSION}'"
fi
