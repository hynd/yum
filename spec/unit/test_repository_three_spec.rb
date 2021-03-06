require 'spec_helper'

describe 'yum_test::test_repository_three' do
  let(:test_repository_three_run) do
    ChefSpec::Runner.new(
      :step_into => 'yum_repository'
      ).converge(described_recipe)
  end

  let(:test_repository_three_template) do
    test_repository_three_run.template('/etc/yum.repos.d/test3.repo')
  end

  let(:test_repository_three_content) do
    '# This file was generated by Chef
# Do NOT modify this file by hand.

[test3]
name=an test
baseurl=http://drop.the.baseurl.biz
enabled=1
gpgcheck=1
sslverify=1
'
  end

  context 'creating a yum_repository with the :add action alias' do
    it 'adds yum_repository[test3]' do
      expect(test_repository_three_run).to add_yum_repository('test3')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/test3.repo]' do
      expect(test_repository_three_run).to create_template('/etc/yum.repos.d/test3.repo')
    end

    it 'steps into yum_repository and renders file[/etc/yum.repos.d/test3.repo]' do
      expect(test_repository_three_run).to render_file('/etc/yum.repos.d/test3.repo').with_content(test_repository_three_content)
    end

    it 'steps into yum_repository and runs execute[yum-makecache-test3]' do
      expect(test_repository_three_run).to_not run_execute('yum-makecache-test3')
    end

    it 'steps into yum_repository and runs ruby_block[yum-cache-reload-test3]' do
      expect(test_repository_three_run).to_not run_ruby_block('yum-cache-reload-test3')
    end

    it 'sends a :run to execute[yum-makecache-test3]' do
      expect(test_repository_three_template).to notify('execute[yum-makecache-test3]')
    end

    it 'sends a :create to ruby_block[yum-cache-reload-test3]' do
      expect(test_repository_three_template).to notify('ruby_block[yum-cache-reload-test3]')
    end
  end
end
