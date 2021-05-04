# frozen_string_literal: true

describe RollbarApi::Project do
  describe '.configure' do
    it 'adds a Project to list' do
      expect(described_class.find('my-project')).to be_nil

      described_class.configure('my-project', 'my-token')

      project = described_class.find('my-project')
      expect(project).to be_a(described_class)
      expect(project.name).to eq('my-project')
      expect(project.access_token).to eq('my-token')
    end

    it 'returns an Project' do
      expect(described_class.configure('my-project', 'my-token')).to be_a(described_class)
    end
  end

  describe '.find' do
    before { described_class.configure('my-project', 'my-token') }

    context 'Project exists' do
      it 'returns a Project' do
        expect(described_class.find('my-project')).to be_a(described_class)
      end
    end

    context 'Project does not exist' do
      it 'returns nil' do
        expect(described_class.find('my-project-2')).to be_nil
      end
    end
  end

  describe '.all' do
    it 'returns all Projects' do
      expect(described_class.all).to eq([])

      described_class.configure('my-project', 'token1')
      described_class.configure('my-project-2', 'token2')

      expect(described_class.all.size).to eq(2)
      expect(described_class.all.map(&:name)).to contain_exactly('my-project', 'my-project-2')
    end
  end
end
