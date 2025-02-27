# encoding: UTF-8

control 'PHTN-30-000037' do
  title "The Photon operating system must configure sshd to disconnect idle SSH
sessions."
  desc  "Terminating an idle session within a short time period reduces the
window of opportunity for unauthorized personnel to take control of a
management session enabled on the console or console port that has been left
unattended."
  desc  'rationale', ''
  desc  'check', "
    At the command line, execute the following command:

    # sshd -T|&grep -i ClientAliveInterval

    Expected result:

    ClientAliveInterval 900

    If the output does not match the expected result, this is a finding.
  "
  desc  'fix', "
    Navigate to and open:

    /etc/ssh/sshd_config

    Ensure that the \"ClientAliveInterval\" line is uncommented and set to the
following:

    ClientAliveInterval 900

    At the command line, execute the following command:

    # systemctl restart sshd.service
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-OS-000163-GPOS-00072'
  tag gid: nil
  tag rid: nil
  tag stig_id: 'PHTN-30-000037'
  tag fix_id: nil
  tag cci: ['CCI-001133']
  tag nist: ['SC-10']

  describe command('sshd -T|&grep -i ClientAliveInterval') do
    its ('stdout.strip') { should cmp 'ClientAliveInterval 900' }
  end

end

